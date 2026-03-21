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
      Offset(screenSize.width / 2, screenSize.height * 0.4),
      Duration(milliseconds: 300),
      Curves.linear,
    ),
    topCard.controller.changeScale!.call(
      0.5,
      Duration(milliseconds: 300),
      Curves.easeOut,
    ),
  ]);

  updateTopCardWidget.call;

  await Future.wait([]);
  
}
