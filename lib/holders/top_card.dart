import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:eka_player_vs_bot/card/card-ui/card_widget.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';
import 'package:flutter/material.dart';

class TopCard extends StatefulWidget {
  final CardStorage cardStorage;

  const TopCard(this.cardStorage, {super.key});

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  late int ci;
  @override
  void initState() {
    super.initState();
    updateTopCardWidget = (int i) {
      setState(() {
        ci = i;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    Positions positions = Positions(
      widget.cardStorage,
      MediaQuery.sizeOf(context),
    );
    return Stack(
      children: [
        Positioned(
          left: positions.topCardPosition.dx,
          top: positions.topCardPosition.dy,
          child: widget.cardStorage.discardPile.isEmpty
              ? SizedBox.shrink()
              : Transform.scale(
                  scale: positions.topCardScale,
                  child: EkaCardWidget(EkaCard(ci, CardController())),
                ),
        ),
      ],
    );
  }
}
