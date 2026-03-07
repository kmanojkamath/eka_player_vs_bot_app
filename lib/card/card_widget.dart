import 'dart:math';

import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

Color color(CardColor cardcolor){
  switch(cardcolor){
    case CardColor.red:
      return Colors.redAccent;
    case CardColor.green:
      return Colors.green;
    case CardColor.blue:
      return Colors.blue;
    case CardColor.yellow:
      return Colors.amber;
    case CardColor.wild:
      return Colors.black;
  }
}

class EkaCardWidget extends StatelessWidget {
  final int _ci;
  const EkaCardWidget(this._ci, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Container(
          width: 188,
          height: 281,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 0.5),
          ),
        ),
        Container(
          width: 168,
          height: 261,
          decoration: BoxDecoration(
            color: color(EkaCard(_ci).color),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: 178,
            height: 210,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentGeometry.center,
                  child: CustomPaint(
                    painter: CenterOval(
                      color(EkaCard(_ci).color),
                      width: 177,
                      height: 216,
                      angle: 0.6,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Text(
                      EkaCard(_ci).value.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 42,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Transform.flip(
                      flipY: true,
                      child: Text(
                        EkaCard(_ci).value.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 42,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      EkaCard(_ci).value.toString(),
                        style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 81,
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.italic,
                      ),
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
      Paint()
        ..color = color
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
