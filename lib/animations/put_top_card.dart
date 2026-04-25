import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';
import 'package:flutter/animation.dart';

import '../global.dart';

Future<void> putTopCard(CardStorage cardStorage, Positions positions) async {
  await Future.wait([
    cardStorage.backOfDrawingCard.changeWidthScale!.call(
      0,
      Duration(milliseconds: 250),
      Curves.linear,
    ),
    cardStorage.backOfDrawingCard.changeScale!.call(
      0.75,
      Duration(milliseconds: 250),
      Curves.easeInOut,
    ),
  ]);

  await Future.wait([
    cardStorage.topCard.controller.changeWidthScale!.call(
      1,
      Duration(milliseconds: 250),
      Curves.linear,
    ),
    cardStorage.topCard.controller.changeScale!.call(
      1,
      Duration(milliseconds: 250),
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
    cardStorage.topCard.controller.changePosition!.call(
      positions.topCardPosition,
      Duration(milliseconds: 300),
      Curves.linear,
    ),
    cardStorage.topCard.controller.changeScale!.call(
      positions.topCardScale,
      Duration(milliseconds: 300),
      Curves.easeOut,
    ),
  ]);

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
}
