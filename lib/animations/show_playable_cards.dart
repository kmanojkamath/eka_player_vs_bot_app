import 'package:eka_player_vs_bot/game_logic/playable_cards.dart';
import 'package:eka_player_vs_bot/positions.dart';
import 'package:flutter/material.dart';

import '../global.dart';

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
        playableCardPosition(element),
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
  ]);

  playablePlayerCards().forEach(
    (element) => card[element].controller.locked = false,
  );
}

Future<void> unshowPlayableCards({bool didPlay = true}) async {
  await Future.wait([
    ...playerPile.map(
      (element) => card[element].controller.changeAngle!.call(
        playerCardAngle(element),
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
    ...playerPile.map(
      (element) => card[element].controller.changePosition!.call(
        playerCardPosition(element),
        Duration(milliseconds: 180),
        Curves.linear,
      ),
    ),
  ]);

  if (didPlay) {
    await Future.wait([
      card[selectedCard.value].controller.changePosition!.call(
        drawPosition,
        Duration.zero,
        Curves.linear,
      ),
      card[selectedCard.value].controller.changeScale!.call(
        drawScale,
        Duration.zero,
        Curves.linear,
      ),
      card[selectedCard.value].controller.changeWidthScale!.call(
        0,
        Duration.zero,
        Curves.linear,
      ),
    ]);
  }
}
