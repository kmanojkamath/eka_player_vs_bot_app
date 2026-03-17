import 'dart:math';

import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

class CardScaleAnimationScreen extends StatelessWidget {
  const CardScaleAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CardController cardController = CardController();
    return Scaffold(
      body: Center(
        child: AnimatedCard(EkaCard(CardColor.red, 11), cardController),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cardController.changeScale?.call(Random().nextDouble()*2);
        },
      ),
    );
  }
}
