import 'package:eka_player_vs_bot/card/animated-cards/animated_bot_card.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';

import 'package:flutter/material.dart';

class BotCardsHolder extends StatefulWidget {
  final CardStorage cardStorage;
  const BotCardsHolder(this.cardStorage, {super.key});
  @override
  State<BotCardsHolder> createState() => _BotCardsHolderState();
}

class _BotCardsHolderState extends State<BotCardsHolder> {
  @override
  Widget build(BuildContext context) {
    Positions positions = Positions(
      widget.cardStorage,
      MediaQuery.sizeOf(context),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: List.generate(widget.cardStorage.botCard.length, (i) {
            return AnimatedBotCard(
              widget.cardStorage.botCard[i],
              cardScale: positions.drawScale,
              cardWidthScale: 0,
              cardPosition: positions.drawPosition,
            );
          }),
        );
      },
    );
  }
}
