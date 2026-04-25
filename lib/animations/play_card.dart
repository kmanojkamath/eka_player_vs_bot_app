import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/playable_cards.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';
import 'package:flutter/material.dart';

import '../global.dart';

Future<void> playerPlayCard(
  CardStorage cardStorage,
  Positions positions,
) async {
  playablePlayerCards(
    cardStorage,
  ).forEach((element) => cardStorage.card[element].controller.locked = true);

  Future.wait([
    ...playablePlayerCards(cardStorage).map(
      (element) => cardStorage.card[element].controller.changeAngle!.call(
        element == selectedCard.value
            ? 0
            : positions.playableCardAngle(element),
        Duration(milliseconds: element == selectedCard.value ? 300 : 180),
        Curves.linear,
      ),
    ),
    ...playablePlayerCards(cardStorage).map(
      (element) => cardStorage.card[element].controller.changeScale!.call(
        element == selectedCard.value
            ? positions.topCardScale
            : positions.playableCardScale,
        Duration(milliseconds: element == selectedCard.value ? 300 : 180),
        Curves.linear,
      ),
    ),
    ...playablePlayerCards(cardStorage).map(
      (element) => cardStorage.card[element].controller.changePosition!.call(
        element == selectedCard.value
            ? positions.topCardPosition
            : positions.playableCardPosition(element),
        Duration(milliseconds: element == selectedCard.value ? 300 : 180),
        Curves.linear,
      ),
    ),
    cardStorage.card[selectedCard.value].controller.changeScale!.call(
      positions.topCardScale,
      Duration(milliseconds: 300),
      Curves.linear,
    ),
  ]);

  await Future.delayed(Duration(milliseconds: 250));
}

Future<void> botPlayCard(CardStorage cardStorage, Positions positions) async {
  int n = cardStorage.botPile.length;
  await Future.wait([
    cardStorage.botCard[n].changeScale!.call(
      positions.drawScale,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
    cardStorage.botCard[n].changeWidthScale!.call(
      0,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
    cardStorage.botCard[n].changeAngle!.call(
      0,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
  ]);

  await cardStorage.topCard.controller.changePosition!.call(
    positions.botCardPosition(cardStorage.botPile.length),
    Duration.zero,
    Curves.linear,
  );

  await Future.wait([
    cardStorage.topCard.controller.changePosition!.call(
      positions.topCardPosition,
      Duration(milliseconds: 180),
      Curves.linear,
    ),
    cardStorage.topCard.controller.changeScale!.call(
      positions.topCardScale,
      Duration(milliseconds: 180),
      Curves.linear,
    ),
    cardStorage.topCard.controller.changeWidthScale!.call(
      1,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
  ]);

  await cardStorage.botCard[n].changePosition!.call(
    positions.drawPosition,
    Duration(milliseconds: 100),
    Curves.linear,
  );

  updateTopCardWidget.call(cardStorage.topCard.ci);

  await Future.wait([
    cardStorage.topCard.controller.changePosition!.call(
      positions.drawPosition,
      Duration.zero,
      Curves.linear,
    ),
    cardStorage.topCard.controller.changeScale!.call(
      positions.drawScale,
      Duration.zero,
      Curves.linear,
    ),
    cardStorage.topCard.controller.changeWidthScale!.call(
      0,
      Duration.zero,
      Curves.linear,
    ),
  ]);

  await Future.wait([
    ...List.generate(n, (i) {
      return cardStorage.botCard[i].changeAngle!.call(
        positions.botCardAngle(i),
        Duration(milliseconds: 300),
        Curves.linear,
      );
    }),
    ...List.generate(n, (i) {
      return cardStorage.botCard[i].changePosition!.call(
        positions.botCardPosition(i),
        Duration(milliseconds: 300),
        Curves.linear,
      );
    }),
  ]);

  await Future.delayed(Duration(milliseconds: 180));
}
