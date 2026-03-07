import 'dart:math';

import 'package:flutter/material.dart';
import 'card_logic.dart';

class SkipSymbol extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    debugPrint(size.width.toString());
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width / 7,
    );
    canvas.drawLine(
      Offset(
        0.5 * size.width * (1 + 1 / sqrt2),
        0.5 * size.height * (1 - 1 / sqrt2),
      ),
      Offset(
        0.5 * size.width * (1 - 1 / sqrt2),
        0.5 * size.height * (1 + 1 / sqrt2),
      ),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width / 7,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Symbol extends StatelessWidget {
  final int _ci;
  final bool isMiddleSymbol;
  const Symbol(this._ci, {super.key, this.isMiddleSymbol = false});

  @override
  Widget build(BuildContext context) {
    if (EkaCard(_ci).value < 10) {
      return Text(
        EkaCard(_ci).value.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol ? 81 : 42,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (EkaCard(_ci).value == 12) {
      return Text(
        "+2",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol ? 81 : 40,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (EkaCard(_ci).value == 14) {
      return Text(
        "+4",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol ? 81 : 40,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (EkaCard(_ci).value == 10) {
      return SizedBox(
        height: isMiddleSymbol ? 72 : 32,
        width: isMiddleSymbol ? 72 : 32,
        child: CustomPaint(painter: SkipSymbol()),
      );
    }
    return const Placeholder();
  }
}
