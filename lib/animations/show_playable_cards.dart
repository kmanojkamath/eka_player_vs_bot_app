import 'package:eka_player_vs_bot/logics/playable_cards.dart';
import 'package:flutter/material.dart';

import '../global.dart';

Offset cardPosition(int ci) {
  int n = playerPile.length;
  int i = playerPile.toList().indexOf(ci);

  double widthDifference = 24;

  double x = i - (n - 1) / 2;

  double cardWidth = 188;

  return Offset(
    x * widthDifference + screenSize.width / 2 - cardWidth * 0.5,
    screenSize.height * 0.6,
  );
}

Future<void> showPlayableCards() async {
  await Future.wait([
    ...playablePlayerCards().map(
      (element) => card[element].controller.changeAngle!.call(
        0,
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
    ...playablePlayerCards().map(
      (element) => card[element].controller.changePosition!.call(
        cardPosition(element),
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
  ]);

  playableBotCards().forEach(
    (element) => card[element].controller.locked = false,
  );
}
