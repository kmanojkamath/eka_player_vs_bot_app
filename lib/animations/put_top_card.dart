import 'package:eka_player_vs_bot/positions.dart';
import 'package:flutter/animation.dart';

import '../global.dart';

Future<void> putTopCard() async {
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
    topCard.controller.changeWidthScale!.call(
      1,
      Duration(milliseconds: 250),
      Curves.linear,
    ),
    topCard.controller.changeScale!.call(
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
    topCard.controller.changePosition!.call(
      topCardPosition,
      Duration(milliseconds: 300),
      Curves.linear,
    ),
    topCard.controller.changeScale!.call(
      topCardScale,
      Duration(milliseconds: 300),
      Curves.easeOut,
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
}
