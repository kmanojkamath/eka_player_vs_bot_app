import 'dart:math';

import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

double cardAngle(int ci) {
  int n = playerPile.length;
  int i = playerPile.toList().indexOf(ci);
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset cardPosition(int ci) {
  int n = playerPile.length;
  int i = playerPile.toList().indexOf(ci);

  double widthDifference = 24;

  double lowest = screenSize.height * 0.8;
  double highest = screenSize.height * 0.7;

  double x = i - (n - 1) / 2;

  double cardWidth = 188;

  return Offset(
    x * widthDifference +
        screenSize.width / 2 -
        cardWidth * cos(cardAngle(ci)) * 0.5,
    (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
  );
}

Future<void> playerDrawCard(int ci) async {
  await Future.wait([
    backOfDrawingCard.changeWidthScale!.call(
      0,
      Duration(milliseconds: 250),
      Curves.linear,
    ),
    backOfDrawingCard.changeScale!.call(
      0.75,
      Duration(milliseconds: 250),
      Curves.easeInOut,
    ),
  ]);

  await Future.wait([
    card[ci].controller.changeWidthScale!.call(
      1,
      Duration(milliseconds: 250),
      Curves.linear,
    ),
    card[ci].controller.changeScale!.call(
      1,
      Duration(milliseconds: 250),
      Curves.easeInOut,
    ),
  ]);

  await Future.wait([
    backOfDrawingCard.changeWidthScale!.call(1, Duration.zero, Curves.linear),
    backOfDrawingCard.changeScale!.call(0.5, Duration.zero, Curves.easeInOut),
  ]);

  await Future.wait([
    ...playerPile.map((i) {
      return card[i].controller.changeAngle!.call(
        cardAngle(i),
        Duration(milliseconds: i == ci ? 600 : 300),
        Curves.linear,
      );
    }),
    ...playerPile.map((i) {
      return card[i].controller.changePosition!.call(
        cardPosition(i),
        Duration(milliseconds: i == ci ? 600 : 300),
        Curves.linear,
      );
    }),
  ]);
}
