import 'package:eka_player_vs_bot/holders/background.dart';
import 'package:eka_player_vs_bot/holders/bot_cards_holder.dart';
import 'package:eka_player_vs_bot/holders/draw_card_holder.dart';
import 'package:eka_player_vs_bot/holders/top_card.dart';
import 'package:eka_player_vs_bot/game_logic/game_start.dart';
import 'package:eka_player_vs_bot/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:eka_player_vs_bot/global.dart';

import '../holders/color_selector.dart';
import '../holders/player_cards_holder.dart';

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
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            TopCard(),
            BotCardsHolder(),
            DrawCardHolder(),
            ColorSelector(),
            PlayerCardsHolder(),
          ],
        ),
      ),
    );
  }
}
