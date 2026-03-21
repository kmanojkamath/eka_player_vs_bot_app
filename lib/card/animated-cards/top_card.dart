import 'package:eka_player_vs_bot/card/card-ui/card_widget.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

class TopCard extends StatefulWidget {
  const TopCard({super.key});

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  @override
  void initState() {
    super.initState();
    updateTopCardWidget = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: discardPile.isEmpty ? SizedBox.shrink() : EkaCardWidget(topCard),
    );
  }
}
