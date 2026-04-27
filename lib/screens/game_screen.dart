import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/game_play.dart';
import 'package:eka_player_vs_bot/holders/background.dart';
import 'package:eka_player_vs_bot/holders/bot_cards_holder.dart';
import 'package:eka_player_vs_bot/holders/draw_card_holder.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';
import 'package:eka_player_vs_bot/holders/top_card.dart';
import 'package:eka_player_vs_bot/screens/result_screen.dart';
import 'package:flutter/material.dart';

import '../holders/color_selector.dart';
import '../holders/player_cards_holder.dart';

class GameScreen extends StatefulWidget {
  final bool botStarts;
  const GameScreen(this.botStarts, {super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  CardStorage cardStorage = CardStorage();
  CardAnimations cardAnimations = CardAnimations(
    CardStorage(),
    Positions(CardStorage(), Size(0, 0)),
  );

  Future<void> processMove(move nextMove, GamePlay gamePlay) async {
    switch (nextMove) {
      case move.botDrawTwo:
        nextMove = await gamePlay.botDrawTwo();
        break;
      case move.botTurn:
        nextMove = await gamePlay.botTurn();
        break;
      case move.playerDrawTwo:
        nextMove = await gamePlay.playerDrawTwo();
        break;
      case move.playerTurn:
        nextMove = await gamePlay.playerTurn();
        break;
      case move.playerWildCard:
        nextMove = await gamePlay.playerWildCard();
        break;
      case move.botWildCard:
        nextMove = await gamePlay.botWildCard();
        break;
      case move.playerWildDrawFour:
        nextMove = await gamePlay.playerWildDrawFour();
        break;
      case move.botWildDrawFour:
        nextMove = await gamePlay.botWildDrawFour();
        break;
      case move.gameStart:
        nextMove = await gamePlay.gameStart(widget.botStarts);
        break;

      case move.gameWin:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(didWin: true)),
        );
        return;

      case move.gameLose:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(didWin: false)),
        );
        return;
    }
    await processMove(nextMove, gamePlay);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cardAnimations = CardAnimations(
        cardStorage,
        Positions(cardStorage, MediaQuery.sizeOf(context)),
      );
      move nextMove = move.gameStart;
      GamePlay gamePlay = GamePlay(cardAnimations);
      await processMove(nextMove, gamePlay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Background(),
            TopCard(this.cardStorage),
            BotCardsHolder(this.cardStorage),
            DrawCardHolder(this.cardStorage),
            ColorSelector(this.cardStorage),
            PlayerCardsHolder(this.cardStorage),
          ],
        ),
      ),
    );
  }
}
