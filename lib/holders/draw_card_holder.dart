import 'package:eka_player_vs_bot/card/animated-cards/animated_back_card.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

class DrawCardHolder extends StatefulWidget {
  const DrawCardHolder({super.key});

  @override
  State<DrawCardHolder> createState() => _DrawCardsHolderState();
}

class _DrawCardsHolderState extends State<DrawCardHolder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            AnimatedBackCard(
              stationary,
              cardScale: 0.5,
              cardPosition: Offset(
                constraints.maxWidth * 0.75,
                constraints.maxHeight * 0.33,
              ),
            ),
            AnimatedBackCard(
              backOfDrawingCard,
              cardScale: 0.5,
              cardPosition: Offset(
                constraints.maxWidth * 0.75,
                constraints.maxHeight * 0.33,
              ),
            ),
          ],
        );
      },
    );
  }
}
