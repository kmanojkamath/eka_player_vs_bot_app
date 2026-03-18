import 'dart:math';

import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

import 'animated_card.dart';

double cardAngle(int n, int i) {
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset cardPosition(int n, int i, BuildContext context, double cardScale) {
  double widthDifference = 24;
  Size size = MediaQuery.sizeOf(context);

  double lowest = size.height * 0.8;
  double highest = size.height * 0.7;

  double x = i - (n - 1) / 2;

  double cardWidth = 188 * cardScale;

  return Offset(
    x * widthDifference +
        size.width / 2 -
        cardWidth * cos(cardAngle(n, i)) * 0.5,
    (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
  );
}

class HandHolder extends StatefulWidget {
  final List<EkaCard> cardList;
  const HandHolder(this.cardList, {super.key});

  @override
  State<HandHolder> createState() => _HandHolderState();
}

class _HandHolderState extends State<HandHolder> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(25, (i) {
        return AnimatedCard(
          widget.cardList[i],
          cardScale: 0.5,
          cardWidthScale: 0,
          cardPosition: Offset(
            MediaQuery.sizeOf(context).width * 0.75,
            MediaQuery.sizeOf(context).height * 0.1,
          ),
        );
      }),
    );
  }
}
