import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

import '../card-ui/card_widget.dart';

class CardController {
  void Function(double newScale)? changeScale;
}

class AnimatedCard extends StatefulWidget {
  final EkaCard _card;
  final CardController cardController;
  final double cardScale;
  const AnimatedCard(
    this._card,
    this.cardController, {
    super.key,
    this.cardScale = 1,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    scaleAnim = AlwaysStoppedAnimation(widget.cardScale);

    widget.cardController.changeScale = (newScale) {
      setState(() {
        scaleAnim = Tween<double>(
          begin: scaleAnim.value,
          end: newScale,
        ).animate(_controller);
      });

      _controller.forward(from: 0);
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return EkaCardWidget(widget._card, cardScale: scaleAnim.value);
      },
    );
  }
}
