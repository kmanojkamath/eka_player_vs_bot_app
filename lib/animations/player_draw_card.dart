import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/positions.dart';
import 'package:flutter/material.dart';

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
        playerCardAngle(i),
        Duration(milliseconds: i == ci ? 600 : 300),
        Curves.linear,
      );
    }),
    ...playerPile.map((i) {
      return card[i].controller.changePosition!.call(
        playerCardPosition(i),
        Duration(milliseconds: i == ci ? 600 : 300),
        Curves.linear,
      );
    }),
  ]);
}
