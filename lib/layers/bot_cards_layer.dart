import 'package:eka_player_vs_bot/items/card/animated-cards/animated_bot_card.dart';
import 'package:eka_player_vs_bot/items/card/card_storage.dart';
import 'package:eka_player_vs_bot/layers/positions.dart';

import 'package:flutter/material.dart';

class BotCardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const BotCardsLayer(this.cardStorage, {super.key});
  @override
  State<BotCardsLayer> createState() => _BotCardsLayerState();
}

class _BotCardsLayerState extends State<BotCardsLayer> {
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
