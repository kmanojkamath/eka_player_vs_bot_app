import 'dart:math';

import 'package:flutter/material.dart';

class ReverseSymbol extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width / 4.2;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-0.6);
    canvas.translate(-size.width / 2, -size.height / 2);

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(2.3 * x, size.height / 2 - 0.1 * x),
        width: 1.8 * x,
        height: 1.8 * x,
      ),
      pi,
      pi * 1/2,
      true,
      Paint()..color = Colors.white,
    );

    canvas.drawRRect(
      RRect.fromLTRBR(
        2.3 * x,
        size.height / 2 - 1 * x,
        3.2 * x,
        size.height / 2 - 0.1 * x,
        Radius.zero,
      ),
      Paint()..color = Colors.white,
    );

    final upperTrianglePath = Path();
    upperTrianglePath.moveTo(size.width, size.height / 2 - 0.55 * x);
    upperTrianglePath.lineTo(
      size.width - x,
      size.height / 2 - (0.55 - 0.81) * x,
    );
    upperTrianglePath.lineTo(
      size.width - x,
      size.height / 2 - (0.55 + 0.81) * x,
    );
    upperTrianglePath.close();

    canvas.drawPath(upperTrianglePath, Paint()..color = Colors.white);

    final lowerTrianglePath = Path();
    lowerTrianglePath.moveTo(0, size.height / 2 + 0.55 * x);
    lowerTrianglePath.lineTo(x, size.height / 2 + (0.55 + 0.81) * x);
    lowerTrianglePath.lineTo(x, size.height / 2 + (0.55 - 0.81) * x);
    lowerTrianglePath.close();

    canvas.drawPath(lowerTrianglePath, Paint()..color = Colors.white);

    canvas.drawRRect(
      RRect.fromLTRBR(
        x,
        size.height / 2 + 0.1 * x,
        1.9 * x,
        size.height / 2 + 1 * x,
        Radius.zero,
      ),
      Paint()..color = Colors.white,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(1.9 * x, size.height / 2 + 0.1 * x),
        width: 1.8 * x,
        height: 1.8 * x,
      ),
      0,
      pi / 2,
      true,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}