import 'dart:math';

import 'package:flutter/material.dart';

class SpinningWheel extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      pi,
      pi,
      true,
      Paint()..color = Colors.red,
    );
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      0,
      pi,
      true,
      Paint()..color = Colors.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SpinningWheelWidget extends StatelessWidget {
  final double size;
  const SpinningWheelWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: SpinningWheel()),
        ),
        Column(
          children: [
            const Spacer(flex: 2),
            const Text(
              "Bot",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Transform.rotate(
              angle: pi,
              child: Text(
                "You",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ],
    );
  }
}

class RotatingTossCircle extends StatelessWidget {
  final double size;
  final double numberOfTurns;
  const RotatingTossCircle(this.numberOfTurns, {super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: numberOfTurns,
      curve: Curves.easeOutExpo,
      duration: Duration(milliseconds: (numberOfTurns * 300).toInt()),
      child: SpinningWheelWidget(size: size),
    );
  }
}
