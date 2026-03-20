import 'dart:math';

import 'package:flutter/material.dart';

class TossCircle extends CustomPainter {
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

class TossCircleWidget extends StatelessWidget {
  final double size;
  const TossCircleWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: TossCircle()),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Bot"),
            Transform.rotate(angle: pi, child: Text("You")),
          ],
        ),
      ],
    );
  }
}

class RotatingTossCircle extends StatefulWidget {
  final double size;
  double numberOfTurns = 0;
  RotatingTossCircle(this.numberOfTurns, {super.key, required this.size});

  @override
  State<RotatingTossCircle> createState() => _RotatingTossCircleState();
}

class _RotatingTossCircleState extends State<RotatingTossCircle> {
  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: widget.numberOfTurns,
      duration: Duration(milliseconds: (widget.numberOfTurns * 300).toInt()),
      child: TossCircleWidget(size: widget.size),
    );
  }
}
