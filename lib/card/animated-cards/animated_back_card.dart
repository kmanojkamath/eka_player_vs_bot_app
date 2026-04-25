import 'dart:async';

import 'package:eka_player_vs_bot/animations/draw_card.dart';
import 'package:eka_player_vs_bot/card/card-ui/back_card_widget.dart';
import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/player_turn.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/game_logic/playable_cards.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';

import 'package:flutter/material.dart';

class BackCardController {
  Future<void> Function(double, Duration, Curve)? changeScale;
  Future<void> Function(Offset, Duration, Curve)? changePosition;
  Future<void> Function(double, Duration, Curve)? changeAngle;
  Future<void> Function(double, Duration, Curve)? changeWidthScale;
}

class AnimatedBackCard extends StatefulWidget {
  final BackCardController _backCardController;

  final CardStorage cardStorage;
  final Positions positions;

  final double cardScale;
  final Offset cardPosition;
  final double cardAngle;
  final double cardWidthScale;

  const AnimatedBackCard(
    this._backCardController,
    this.cardStorage,
    this.positions, {
    super.key,
    this.cardScale = 1,
    this.cardPosition = Offset.zero,
    this.cardAngle = 0,
    this.cardWidthScale = 1,
  });

  @override
  State<AnimatedBackCard> createState() => _AnimatedBackCardState();
}

class _AnimatedBackCardState extends State<AnimatedBackCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _posController;
  late AnimationController _angleController;
  late AnimationController _widthScaleController;

  late final Listenable _merged;

  late Animation<double> scaleAnim;
  late Animation<Offset> posAnim;
  late Animation<double> angleAnim;
  late Animation<double> widthScaleAnim;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _posController = AnimationController(vsync: this, duration: Duration.zero);

    _angleController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _widthScaleController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _merged = Listenable.merge([
      _scaleController,
      _posController,
      _angleController,
      _widthScaleController,
    ]);

    scaleAnim = AlwaysStoppedAnimation(widget.cardScale);
    posAnim = AlwaysStoppedAnimation(widget.cardPosition);
    angleAnim = AlwaysStoppedAnimation(widget.cardAngle);
    widthScaleAnim = AlwaysStoppedAnimation(widget.cardWidthScale);

    widget._backCardController.changeScale = (newScale, duration, curve) async {
      setState(() {
        _scaleController.duration = duration;

        scaleAnim = Tween<double>(
          begin: scaleAnim.value,
          end: newScale,
        ).animate(CurvedAnimation(parent: _scaleController, curve: curve));
      });

      await _scaleController.forward(from: 0);
    };

    widget._backCardController.changePosition =
        (newPosition, duration, curve) async {
          setState(() {
            _posController.duration = duration;

            posAnim = Tween<Offset>(
              begin: posAnim.value,
              end: newPosition,
            ).animate(CurvedAnimation(parent: _posController, curve: curve));
          });

          await _posController.forward(from: 0);
        };

    widget._backCardController.changeAngle = (newAngle, duration, curve) async {
      setState(() {
        _angleController.duration = duration;

        angleAnim = Tween<double>(
          begin: angleAnim.value,
          end: newAngle,
        ).animate(CurvedAnimation(parent: _angleController, curve: curve));
      });

      await _angleController.forward(from: 0);
    };

    widget
        ._backCardController
        .changeWidthScale = (newWidthScale, duration, curve) async {
      setState(() {
        _widthScaleController.duration = duration;

        widthScaleAnim = Tween<double>(
          begin: widthScaleAnim.value,
          end: newWidthScale,
        ).animate(CurvedAnimation(parent: _widthScaleController, curve: curve));
      });

      await _widthScaleController.forward(from: 0);
    };

    widget._backCardController.changePosition?.call(
      widget.cardPosition,
      Duration(),
      Curves.linear,
    );
  }

  @override
  void dispose() {
    _angleController.dispose();
    _posController.dispose();
    _scaleController.dispose();
    _widthScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _merged,

      builder: (context, child) {
        return Positioned(
          left: posAnim.value.dx,
          top: posAnim.value.dy,
          child: Transform.rotate(
            angle: angleAnim.value,
            child: Transform.scale(
              scaleX: widthScaleAnim.value * scaleAnim.value,
              scaleY: scaleAnim.value,
              child: child,
            ),
          ),
        );
      },

      child: GestureDetector(
        onTap: () async {
          print("yo");
          if (canDraw) {
            canDraw = false;
            print("Player: ${widget.cardStorage.playerPile}");
            if (widget.cardStorage.deckPile.isEmpty) {
              widget.cardStorage.deckPile = [...widget.cardStorage.discardPile];
              widget.cardStorage.deckPile.remove(widget.cardStorage.topCard.ci);
              widget.cardStorage.deckPile.shuffle();
              widget.cardStorage.discardPile.clear();
              widget.cardStorage.discardPile.add(widget.cardStorage.topCard.ci);
            }
            int ci = widget.cardStorage.deckPile.removeLast();
            widget.cardStorage.playerPile.add(ci);
            print("Player: ${widget.cardStorage.playerPile}");
            await playerDrawCard(ci, widget.cardStorage, widget.positions);
            if (isPlayable(ci, widget.cardStorage)) {
              await playerTurn(widget.cardStorage, widget.positions);
            } else {
              await botTurn(widget.cardStorage, widget.positions);
            }
          }
        },
        child: BackCardWidget(),
      ),
    );
  }
}
