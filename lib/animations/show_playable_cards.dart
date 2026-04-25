import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/playable_cards.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';
import 'package:flutter/material.dart';

import '../global.dart';

Future<void> showPlayableCards(
  CardStorage cardStorage,
  Positions positions,
) async {
  await Future.wait([
    ...playablePlayerCards(cardStorage).map(
      (element) => cardStorage.card[element].controller.changeAngle!.call(
        0,
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
    ...playablePlayerCards(cardStorage).map(
      (element) => cardStorage.card[element].controller.changePosition!.call(
        positions.playableCardPosition(element),
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
  ]);

  playablePlayerCards(
    cardStorage,
  ).forEach((element) => cardStorage.card[element].controller.locked = false);
}

Future<void> unshowPlayableCards(
  CardStorage cardStorage,
  Positions positions, {
  bool didPlay = true,
}) async {
  await Future.wait([
    ...cardStorage.playerPile.map(
      (element) => cardStorage.card[element].controller.changeAngle!.call(
        positions.playerCardAngle(element),
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
    ...cardStorage.playerPile.map(
      (element) => cardStorage.card[element].controller.changePosition!.call(
        positions.playerCardPosition(element),
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
    ...cardStorage.playerPile.map(
      (element) => cardStorage.card[element].controller.changeScale!.call(
        positions.playerCardScale,
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
  ]);

  if (didPlay) {
    await Future.wait([
      cardStorage.card[selectedCard.value].controller.changePosition!.call(
        positions.drawPosition,
        Duration.zero,
        Curves.linear,
      ),
      cardStorage.card[selectedCard.value].controller.changeScale!.call(
        positions.drawScale,
        Duration.zero,
        Curves.linear,
      ),
      cardStorage.card[selectedCard.value].controller.changeWidthScale!.call(
        0,
        Duration.zero,
        Curves.linear,
      ),
    ]);
  }
}
