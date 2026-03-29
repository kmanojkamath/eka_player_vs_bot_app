import 'package:eka_player_vs_bot/card/animated-cards/background.dart';
import 'package:eka_player_vs_bot/card/animated-cards/bot_cards_holder.dart';
import 'package:eka_player_vs_bot/card/animated-cards/top_card.dart';
import 'package:eka_player_vs_bot/game_logic/game_start.dart';
import 'package:eka_player_vs_bot/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:eka_player_vs_bot/global.dart';

import '../card/animated-cards/color_selector.dart';
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
    showResultScreen = (bool didWin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(didWin: didWin)),
      );
    };
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await gameStart();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          TopCard(),
          BotCardsHolder(),
          PlayerCardsHolder(),
          ColorSelector(),
        ],
      ),
    );
  }
}
