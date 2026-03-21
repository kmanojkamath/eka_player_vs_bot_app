import 'dart:math';

import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

double botCardAngle(int i) {
  int n = botPile.length;
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset botCardPosition(int i) {
  int n = botPile.length;

  double widthDifference = 12;

  double lowest = screenSize.height * 0.15;
  double highest = screenSize.height * 0.1;

  double x = i - (n - 1) / 2;

  double cardWidth = 188 * 0.4;

  return Offset(
    x * widthDifference +
        screenSize.width / 2 -
        cardWidth * cos(botCardAngle(i)) * 0.5,
    (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
  );
}

Future<void> botDrawCard() async {
  int n = botPile.length;

  await Future.wait([
    botCard[n - 1].changeWidthScale!.call(1, Duration.zero, Curves.linear),
    ...List.generate(n, (i) {
      return botCard[i].changeAngle!.call(
        botCardAngle(i),
        Duration(milliseconds: i == n - 1 ? 600 : 300),
        Curves.linear,
      );
    }),
    ...List.generate(n, (i) {
      return botCard[i].changePosition!.call(
        botCardPosition(i),
        Duration(milliseconds: i == n - 1 ? 600 :300),
        Curves.linear,
      );
    }),
  ]);
}
