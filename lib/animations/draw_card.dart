import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';
import 'package:flutter/material.dart';

Future<void> playerDrawCard(
  int ci,
  CardStorage cardStorage,
  Positions positions,
) async {
  await Future.wait([
    cardStorage.backOfDrawingCard.changeWidthScale!.call(
      0,
      Duration(milliseconds: cardStorage.discardPile.isEmpty ? 100 : 180),
      Curves.linear,
    ),
    cardStorage.backOfDrawingCard.changeScale!.call(
      0.75,
      Duration(milliseconds: cardStorage.discardPile.isEmpty ? 100 : 180),
      Curves.easeInOut,
    ),
  ]);

  await Future.wait([
    cardStorage.card[ci].controller.changeWidthScale!.call(
      1,
      Duration(milliseconds: cardStorage.discardPile.isEmpty ? 100 : 180),
      Curves.linear,
    ),
    cardStorage.card[ci].controller.changeScale!.call(
      positions.playerCardScale,
      Duration(milliseconds: cardStorage.discardPile.isEmpty ? 100 : 180),
      Curves.easeInOut,
    ),
  ]);

  await Future.wait([
    cardStorage.backOfDrawingCard.changeWidthScale!.call(
      1,
      Duration.zero,
      Curves.linear,
    ),
    cardStorage.backOfDrawingCard.changeScale!.call(
      0.5,
      Duration.zero,
      Curves.easeInOut,
    ),
  ]);

  await Future.wait([
    ...cardStorage.playerPile.map((i) {
      return cardStorage.card[i].controller.changeAngle!.call(
        positions.playerCardAngle(i),
        Duration(
          milliseconds: cardStorage.discardPile.isEmpty
              ? (i == ci ? 200 : 100)
              : (i == ci ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
    ...cardStorage.playerPile.map((i) {
      return cardStorage.card[i].controller.changePosition!.call(
        positions.playerCardPosition(i),
        Duration(
          milliseconds: cardStorage.discardPile.isEmpty
              ? (i == ci ? 200 : 100)
              : (i == ci ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
    ...cardStorage.playerPile.map((i) {
      return cardStorage.card[i].controller.changeScale!.call(
        positions.playerCardScale,
        Duration(
          milliseconds: cardStorage.discardPile.isEmpty
              ? (i == ci ? 200 : 100)
              : (i == ci ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
  ]);
}

Future<void> botDrawCard(CardStorage cardStorage, Positions positions) async {
  int n = cardStorage.botPile.length;

  await Future.wait([
    cardStorage.botCard[n - 1].changeWidthScale!.call(
      1,
      Duration.zero,
      Curves.linear,
    ),
    ...List.generate(n, (i) {
      return cardStorage.botCard[i].changeAngle!.call(
        positions.botCardAngle(i),
        Duration(
          milliseconds: cardStorage.discardPile.isEmpty
              ? (i == n - 1 ? 200 : 100)
              : (i == n - 1 ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
    ...List.generate(n, (i) {
      return cardStorage.botCard[i].changePosition!.call(
        positions.botCardPosition(i),
        Duration(
          milliseconds: cardStorage.discardPile.isEmpty
              ? (i == n - 1 ? 200 : 100)
              : (i == n - 1 ? 360 : 180),
        ),
        Curves.linear,
      );
    }),
  ]);
}
