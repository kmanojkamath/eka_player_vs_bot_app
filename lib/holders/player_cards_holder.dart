import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:flutter/material.dart';

import '../card/animated-cards/animated_card.dart';

class PlayerCardsHolder extends StatefulWidget {
  final CardStorage cardStorage;
  const PlayerCardsHolder(this.cardStorage, {super.key});

  @override
  State<PlayerCardsHolder> createState() => _PlayerCardsHolderState();
}

class _PlayerCardsHolderState extends State<PlayerCardsHolder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            ...List.generate(108, (i) {
              return AnimatedCard(
                widget.cardStorage.card[i],
                widget.cardStorage,
                cardScale: 0.75,
                cardWidthScale: 0,
                cardPosition: Offset(
                  constraints.maxWidth * 0.75,
                  constraints.maxHeight * 0.33,
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
