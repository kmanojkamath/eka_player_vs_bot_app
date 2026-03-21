import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import '../positions.dart';

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
