import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:eka_player_vs_bot/card/card-ui/card_widget.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/positions.dart';
import 'package:flutter/material.dart';

class TopCard extends StatefulWidget {
  const TopCard({super.key});

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  late int ci;
  @override
  void initState() {
    super.initState();
    updateTopCardWidget = (int i) {
      setState(() {
        ci = i;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: topCardPosition.dx,
          top: topCardPosition.dy,
          child: discardPile.isEmpty
              ? SizedBox.shrink()
              : Transform.scale(
                  scale: topCardScale,
                  child: EkaCardWidget(
                    EkaCard(
                      ci,
                      card[ci].color,
                      card[ci].value,
                      CardController(),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
