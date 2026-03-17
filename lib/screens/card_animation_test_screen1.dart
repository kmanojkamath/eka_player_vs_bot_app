import 'dart:math';

import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

class CardScaleAnimationScreen extends StatefulWidget {
  const CardScaleAnimationScreen({super.key});

  @override
  State<CardScaleAnimationScreen> createState() =>
      _CardScaleAnimationScreenState();
}

class _CardScaleAnimationScreenState extends State<CardScaleAnimationScreen> {
  @override
  Widget build(BuildContext context) {
    CardController cardController = CardController();
    AnimatedCard card = AnimatedCard(
      EkaCard(CardColor.red, 11),
      cardController,
    );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                cardController.changeScale?.call(
                  Random().nextDouble() * 1,
                  Duration(milliseconds: Random().nextInt(10000)),
                  Curves.linear,
                );
              },
              child: Text("Scale"),
            ),
            ElevatedButton(
              onPressed: () {
                cardController.changePosition?.call(
                  Offset(
                    Random().nextDouble() * 150 + 50,
                    Random().nextDouble() * 300 + 100,
                  ),
                  Duration(milliseconds: Random().nextInt(10000)),
                  Curves.linear,
                );
              },
              child: Text("Position"),
            ),
            ElevatedButton(
              onPressed: () {
                cardController.changeAngle?.call(
                  Random().nextDouble() * pi - pi / 2,
                  Duration(milliseconds: Random().nextInt(10000)),
                  Curves.linear,
                );
              },
              child: Text("Angle"),
            ),
          ],
        ),
      ),
      body: Stack(children: [card]),
    );
  }
}
