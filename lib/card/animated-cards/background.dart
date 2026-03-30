import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import '../card-ui/card_widget.dart';
import '../card_logic.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: GestureDetector(
        onTap: () {
          if (backgroundLock == false) {
            backgroundLock = true;
            backgroundPressed.value = true;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [Colors.amber, Colors.brown],
            ),
          ),
          height: screenSize.height,
          width: screenSize.width,
        ),
      ),
    );
  }
}
