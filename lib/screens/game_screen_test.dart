import 'package:eka_player_vs_bot/card/animated-cards/bot_cards_holder.dart';
import 'package:eka_player_vs_bot/card/animated-cards/top_card.dart';
import 'package:eka_player_vs_bot/game_logic/game_start.dart';
import 'package:flutter/material.dart';
import 'package:eka_player_vs_bot/global.dart';

import '../card/animated-cards/player_cards_holder.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await gameStart();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(children: [TopCard(),BotCardsHolder(), PlayerCardsHolder()]),
    );
  }
}
