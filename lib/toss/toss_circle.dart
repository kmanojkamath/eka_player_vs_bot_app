import 'dart:math';

import 'package:eka_player_vs_bot/card/card-backend/card_storage.dart';
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
  const TossCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          CustomPaint(painter: TossCircle()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Bot"), Text("You")],
          ),
        ],
      ),
    );
  }
}

class RotatingTossCircle extends StatefulWidget {
  final double numberOfTurns;
  const RotatingTossCircle(this.numberOfTurns, {super.key});

  @override
  State<RotatingTossCircle> createState() => _RotatingTossCircleState();
}

class _RotatingTossCircleState extends State<RotatingTossCircle> {
  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: widget.numberOfTurns,
      duration: Duration(milliseconds: (widget.numberOfTurns * 2 * pi).toInt()),
    );
  }
}
