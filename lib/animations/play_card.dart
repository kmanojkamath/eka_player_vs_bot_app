import 'package:eka_player_vs_bot/logics/playable_cards.dart';
import 'package:eka_player_vs_bot/positions.dart';
import 'package:flutter/material.dart';

import '../global.dart';

Future<void> playerPlayCard() async {
  playablePlayerCards().forEach(
    (element) => card[element].controller.locked = true,
  );

  Future.wait([
    ...playablePlayerCards().map(
      (element) => card[element].controller.changeAngle!.call(
        element == selectedCard.value ? 0 : playableCardAngle(element),
        Duration(milliseconds: element == selectedCard.value ? 300 : 180),
        Curves.linear,
      ),
    ),
    ...playablePlayerCards().map(
      (element) => card[element].controller.changePosition!.call(
        element == selectedCard.value
            ? topCardPosition
            : playableCardPosition(element),
        Duration(milliseconds: element == selectedCard.value ? 300 : 180),
        Curves.linear,
      ),
    ),
    card[selectedCard.value].controller.changeScale!.call(
      topCardScale,
      Duration(milliseconds: 300),
      Curves.linear,
    ),
  ]);

  await Future.delayed(Duration(milliseconds: 250));
}

Future<void> botPlayCard() async {
  int n = botPile.length;
  await Future.wait([
    botCard[n - 1].changeScale!.call(
      drawScale,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
    botCard[n - 1].changeWidthScale!.call(
      0,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
    botCard[n - 1].changeAngle!.call(
      0,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
  ]);

  await topCard.controller.changePosition!.call(
    botCardPosition(botPile.length),
    Duration.zero,
    Curves.linear,
  );

  await Future.wait([
    topCard.controller.changePosition!.call(
      topCardPosition,
      Duration(milliseconds: 180),
      Curves.linear,
    ),
    topCard.controller.changeScale!.call(
      topCardScale,
      Duration(milliseconds: 180),
      Curves.linear,
    ),
    topCard.controller.changeWidthScale!.call(
      1,
      Duration(milliseconds: 100),
      Curves.linear,
    ),
  ]);

  updateTopCardWidget.call(topCard.ci);

  await Future.wait([
    topCard.controller.changePosition!.call(
      drawPosition,
      Duration.zero,
      Curves.linear,
    ),
    topCard.controller.changeScale!.call(
      drawScale,
      Duration.zero,
      Curves.linear,
    ),
    topCard.controller.changeWidthScale!.call(
      0,
      Duration.zero,
      Curves.linear,
    ),
  ]);

  await Future.delayed(Duration(milliseconds: 180));
}
