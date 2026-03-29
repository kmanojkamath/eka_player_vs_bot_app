import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: GestureDetector(
        onTap: () {
          print("Tapped Background");
          if (backgroundLock == false) {
            backgroundLock = true;
            backgroundPressed.value = true;
            print("Background Working");
          }
        },
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
