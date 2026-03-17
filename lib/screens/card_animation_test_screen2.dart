import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

class CardAnimationScreen extends StatefulWidget {
  const CardAnimationScreen({super.key});

  @override
  State<CardAnimationScreen> createState() =>
      _CardAnimationScreenState();
}

class _CardAnimationScreenState extends State<CardAnimationScreen> {
  final CardController cardController = CardController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await cardController.changePosition!.call(
        Offset(
          MediaQuery.sizeOf(context).width / 2 - 188,
          MediaQuery.sizeOf(context).height / 2 - 281,
        ),
        Duration(milliseconds: 500),
        Curves.linear,
      );
      await cardController.changeAngle!.call(
        1.57,
        Duration(milliseconds: 500),
        Curves.linear,
      );
      await cardController.changeScale!.call(
        0.8,
        Duration(milliseconds: 500),
        Curves.linear,
      );
      await Future.wait(<Future<void>>[
        cardController.changePosition!.call(
          Offset.zero,
          Duration(milliseconds: 500),
          Curves.linear,
        ),
        cardController.changeAngle!.call(
          0,
          Duration(milliseconds: 500),
          Curves.linear,
        ),
        cardController.changeScale!.call(
          1,
          Duration(milliseconds: 500),
          Curves.linear,
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [AnimatedCard(EkaCard(CardColor.red, 11), cardController)],
      ),
    );
  }
}
