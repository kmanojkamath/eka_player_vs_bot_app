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
}
