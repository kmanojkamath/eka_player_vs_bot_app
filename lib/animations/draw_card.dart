import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/positions.dart';
import 'package:flutter/material.dart';

Future<void> playerDrawCard(int ci) async {
  await Future.wait([
    backOfDrawingCard.changeWidthScale!.call(
      0,
      Duration(milliseconds: discardPile.isEmpty ? 100 : 180),
      Curves.linear,
    ),
    backOfDrawingCard.changeScale!.call(
      0.75,
      Duration(milliseconds: discardPile.isEmpty ? 100 : 180),
      Curves.easeInOut,
    ),
  ]);

  await Future.wait([
    card[ci].controller.changeWidthScale!.call(
      1,
      Duration(milliseconds: discardPile.isEmpty ? 100 : 180),
      Curves.linear,
    ),
    card[ci].controller.changeScale!.call(
      playerCardScale,
      Duration(milliseconds: discardPile.isEmpty ? 100 : 180),
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
        Duration(
          milliseconds: discardPile.isEmpty
              ? (i == ci ? 200 : 100)
              : (i == ci ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
    ...playerPile.map((i) {
      return card[i].controller.changePosition!.call(
        playerCardPosition(i),
        Duration(
          milliseconds: discardPile.isEmpty
              ? (i == ci ? 200 : 100)
              : (i == ci ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
    ...playerPile.map((i) {
      return card[i].controller.changeScale!.call(
        playerCardScale,
        Duration(
          milliseconds: discardPile.isEmpty
              ? (i == ci ? 200 : 100)
              : (i == ci ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
  ]);
}

Future<void> botDrawCard() async {
  int n = botPile.length;

  await Future.wait([
    botCard[n - 1].changeWidthScale!.call(1, Duration.zero, Curves.linear),
    ...List.generate(n, (i) {
      return botCard[i].changeAngle!.call(
        botCardAngle(i),
        Duration(
          milliseconds: discardPile.isEmpty
              ? (i == n - 1 ? 200 : 100)
              : (i == n - 1 ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
    ...List.generate(n, (i) {
      return botCard[i].changePosition!.call(
        botCardPosition(i),
        Duration(
          milliseconds: discardPile.isEmpty
              ? (i == n - 1 ? 200 : 100)
              : (i == n - 1 ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
  ]);
}
