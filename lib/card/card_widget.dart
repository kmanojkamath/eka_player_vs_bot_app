import 'dart:math';

import 'card_logic.dart';
import 'card_symbols.dart';

import 'package:flutter/material.dart';

Color color(CardColor cardcolor) {
  switch (cardcolor) {
    case CardColor.red:
      return Colors.red;
    case CardColor.green:
      return Colors.green;
    case CardColor.blue:
      return Colors.blue;
    case CardColor.yellow:
      return Colors.amberAccent;
    case CardColor.wild:
      return Colors.black;
  }
}

class EkaCardWidget extends StatelessWidget {
  final int _ci;
  final double cardHeight;
  const EkaCardWidget(this._ci, {super.key, this.cardHeight = 281});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Container(
          width: cardHeight * 188 / 281,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 0.5),
          ),
        ),
        Container(
          width: cardHeight * 168 / 281,
          height: cardHeight * 261 / 281,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.black, color(EkaCard(_ci).color)],
            ),
            color: color(EkaCard(_ci).color),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: cardHeight * 178 / 281,
            height: cardHeight * 210 / 281,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentGeometry.center,
                  child: CustomPaint(
                    painter: CenterOval(
                      color(EkaCard(_ci).color),
                      width: cardHeight * 177 / 281,
                      height: cardHeight * 216 / 281,
                      angle: 0.6,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      EkaCard(_ci).isDrawTwo || EkaCard(_ci).isWildDrawFour
                          ? 8 * cardHeight / 281
                          : 16 * cardHeight / 281,
                      EkaCard(_ci).isSkip ||
                              EkaCard(_ci).isReverse ||
                              EkaCard(_ci).isWildCard
                          ? 16 * cardHeight / 281
                          : 0 * cardHeight / 281,
                      0,
                      0,
                    ),
                    child: Symbol(_ci, cardHeight: cardHeight),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      0,
                      EkaCard(_ci).isDrawTwo || EkaCard(_ci).isWildDrawFour
                          ? 8 * cardHeight / 281
                          : 16 * cardHeight / 281,
                      EkaCard(_ci).isSkip ||
                              EkaCard(_ci).isReverse ||
                              EkaCard(_ci).isWildCard
                          ? 16 * cardHeight / 281
                          : 0 * cardHeight / 281,
                    ),
                    child: Transform.flip(
                      flipY: true,
                      flipX: true,
                      child: Symbol(_ci, cardHeight: cardHeight),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: EkaCard(_ci).isWildDrawFour
                        ? Symbol(
                            100,
                            cardHeight: cardHeight,
                            isMiddleSymbol: true,
                          )
                        : Symbol(
                            _ci,
                            isMiddleSymbol: true,
                            cardHeight: cardHeight,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CenterOval extends CustomPainter {
  final Color color;
  final double width;
  final double height;
  final double angle;
  CenterOval(
    this.color, {
    required this.width,
    required this.height,
    required this.angle,
  });
  @override
  void paint(Canvas canvas, Size size) {
    double a = sqrt(
      (width * width * cos(angle) * cos(angle) -
              height * height * sin(angle) * sin(angle)) /
          (cos(angle) * cos(angle) - sin(angle) * sin(angle)),
    );
    double b = sqrt(
      (height * height * cos(angle) * cos(angle) -
              width * width * sin(angle) * sin(angle)) /
          (cos(angle) * cos(angle) - sin(angle) * sin(angle)),
    );
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle);
    canvas.translate(-size.width / 2, -size.height / 2);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: a + 10,
        height: b + 10,
      ),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: a,
        height: b,
      ),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
