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
  final EkaCard card = EkaCard(CardColor.red, 11, CardController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await card.controller.changePosition!.call(
        Offset(
          MediaQuery.sizeOf(context).width / 2 - 188,
          MediaQuery.sizeOf(context).height / 2 - 281,
        ),
        Duration(milliseconds: 500),
        Curves.linear,
      );
      await card.controller.changeAngle!.call(
        1.57,
        Duration(milliseconds: 500),
        Curves.linear,
      );
      await card.controller.changeScale!.call(
        0.8,
        Duration(milliseconds: 500),
        Curves.linear,
      );
      await Future.wait(<Future<void>>[
        card.controller.changePosition!.call(
          Offset.zero,
          Duration(milliseconds: 500),
          Curves.linear,
        ),
        card.controller.changeAngle!.call(
          0,
          Duration(milliseconds: 500),
          Curves.linear,
        ),
        card.controller.changeScale!.call(
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
        children: [AnimatedCard(card)],
      ),
    );
  }
}
