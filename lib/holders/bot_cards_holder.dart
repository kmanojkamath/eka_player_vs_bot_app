import 'package:eka_player_vs_bot/card/animated-cards/animated_bot_card.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/positions.dart';

import 'package:flutter/material.dart';

class BotCardsHolder extends StatefulWidget {
  const BotCardsHolder({super.key});
  @override
  State<BotCardsHolder> createState() => _BotCardsHolderState();
}

class _BotCardsHolderState extends State<BotCardsHolder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: List.generate(botCard.length, (i) {
            return AnimatedBotCard(
              botCard[i],
              cardScale: drawScale,
              cardWidthScale: 0,
              cardPosition: drawPosition,
            );
          }),
        );
      },
    );
  }
}
