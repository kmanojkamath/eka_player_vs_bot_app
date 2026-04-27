import 'package:eka_player_vs_bot/items/spinning_wheel/spinning_wheel.dart';
import 'package:flutter/material.dart';

class PointerCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    final pointerPath = Path();

    pointerPath.moveTo(size.width / 2 - 3, 0);
    pointerPath.lineTo(size.width / 2 + 3, 0);
    pointerPath.lineTo(size.width / 2, 20);
    pointerPath.close();

    canvas.drawPath(pointerPath, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SpinningCircle extends StatelessWidget {
  final double numberOfTurns;
  const SpinningCircle({super.key, required this.numberOfTurns});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).height / 2;
    return Stack(
      alignment: Alignment.center,
      children: [
        RotatingTossCircle(numberOfTurns, size: size),
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: PointerCircle()),
        ),
      ],
    );
  }
}
