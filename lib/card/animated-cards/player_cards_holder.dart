import 'package:eka_player_vs_bot/card/animated-cards/animated_back_card.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import 'animated_card.dart';

class PlayerCardsHolder extends StatefulWidget {
  const PlayerCardsHolder({super.key});

  @override
  State<PlayerCardsHolder> createState() => _PlayerCardsHolderState();
}

class _PlayerCardsHolderState extends State<PlayerCardsHolder> {
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
            ...List.generate(108, (i) {
              return AnimatedCard(
                card[i],
                cardScale: 0.75,
                cardWidthScale: 0,
                cardPosition: Offset(
                  constraints.maxWidth * 0.75,
                  constraints.maxHeight * 0.33,
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
