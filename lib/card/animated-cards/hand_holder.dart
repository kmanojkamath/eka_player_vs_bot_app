import 'dart:math';

import 'package:eka_player_vs_bot/card/animated-cards/animated_back_card.dart';
import 'package:eka_player_vs_bot/card/card-backend/card_storage.dart';
import 'package:flutter/material.dart';

import 'animated_card.dart';

double cardAngle(int n, int i) {
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset cardPosition(
  int n,
  int i,
  BoxConstraints constraints,
  double cardScale,
) {
  double widthDifference = 24;

  double lowest = constraints.maxHeight * 0.8;
  double highest = constraints.maxHeight * 0.7;

  double x = i - (n - 1) / 2;

  double cardWidth = 188 * cardScale;

  return Offset(
    x * widthDifference +
        constraints.maxWidth / 2 -
        cardWidth * cos(cardAngle(n, i)) * 0.5,
    (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
  );
}

class HandHolder extends StatefulWidget {
  const HandHolder({super.key});

  @override
  State<HandHolder> createState() => _HandHolderState();
}

class _HandHolderState extends State<HandHolder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            AnimatedBackCard(
              BackCardController(),
              cardScale: 0.5,
              cardPosition: Offset(
                constraints.maxWidth * 0.75,
                constraints.maxHeight * 0.25,
              ),
            ),
            AnimatedBackCard(
              backOfDrawingCard,
              cardScale: 0.5,
              cardPosition: Offset(
                constraints.maxWidth * 0.75,
                constraints.maxHeight * 0.25,
              ),
            ),
            ...List.generate(108, (i) {
              return AnimatedCard(
                card[i],
                cardScale: 0.75,
                cardWidthScale: 0,
                cardPosition: Offset(
                  constraints.maxWidth * 0.75,
                  constraints.maxHeight * 0.25,
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
