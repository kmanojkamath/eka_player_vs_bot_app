import 'package:eka_player_vs_bot/card/card_widget.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:eka_player_vs_bot/card/card_logic.dart';

class WildSymbol extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.6);
    canvas.translate(-size.width / 2, -size.height / 2);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width*0.81,
        height: size.height,
      ),
      Paint()..color = Colors.white,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95*0.81,
        height: size.height * 0.95,
      ),
      0-0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.blue),
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95*0.81,
        height: size.height * 0.95,
      ),
      pi / 2-0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.yellow),
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95*0.81,
        height: size.height * 0.95,
      ),
      pi-0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.red),
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95*0.81,
        height: size.height * 0.95,
      ),
      3 * pi / 2-0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.green),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
