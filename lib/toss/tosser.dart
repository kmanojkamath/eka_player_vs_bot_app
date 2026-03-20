import 'package:eka_player_vs_bot/toss/toss_circle.dart';
import 'package:flutter/material.dart';

class TossPointerCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );

    final pointerPath = Path();

    pointerPath.moveTo(size.width / 2 - 5, 10);
    pointerPath.lineTo(size.width / 2 + 5, 10);
    pointerPath.lineTo(size.width / 2, 20);
    pointerPath.close();

    canvas.drawPath(pointerPath, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Tosser extends StatefulWidget {
  final double length;
  final double numberOfTurns;
  const Tosser({super.key, required this.length, required this.numberOfTurns});

  @override
  State<Tosser> createState() => _TosserState();
}

class _TosserState extends State<Tosser> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.length,
      height: widget.length,
      child: Stack(
        children: [
          RotatingTossCircle(widget.numberOfTurns),
          CustomPaint(painter: TossPointerCircle()),
        ],
      ),
    );
  }
}
