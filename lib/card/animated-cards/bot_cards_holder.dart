import 'dart:math';

import 'package:eka_player_vs_bot/card/animated-cards/animated_bot_card.dart';
import 'package:eka_player_vs_bot/global.dart';

import 'package:flutter/material.dart';

double botCardAngle(int n, int i) {
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset botCardPosition(
  int n,
  int i,
  BoxConstraints constraints,
  double cardScale,
) {
  double widthDifference = 12;

  double lowest = constraints.maxHeight * 0.8;
  double highest = constraints.maxHeight * 0.7;

  double x = i - (n - 1) / 2;

  double cardWidth = 188 * cardScale;

  return Offset(
    x * widthDifference +
        constraints.maxWidth / 2 -
        cardWidth * cos(botCardAngle(n, i)) * 0.5,
    (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
  );
}

class BotCardsHolder extends StatefulWidget {
  const BotCardsHolder({super.key});
  @override
  State<BotCardsHolder> createState() => _BotCardsHolderState();
}

class _BotCardsHolderState extends State<BotCardsHolder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: List.generate(botCard.length, (i) {
            return AnimatedBotCard(
              botCard[i],
              cardScale: 0.5,
              cardWidthScale: 0,
              cardPosition: Offset(
                constraints.maxWidth * 0.75,
                constraints.maxHeight * 0.33,
              ),
            );
          }),
        );
      },
    );
  }
}
