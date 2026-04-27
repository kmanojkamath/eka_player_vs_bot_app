import '/items/card/card_animations/card_animations.dart';
import '/items/card/card_storage.dart';

import '/game_play.dart';

import '/layers/background.dart';
import '/layers/bot_cards_layer.dart';
import '/layers/draw_card_layer.dart';
import '/layers/positions.dart';
import '/layers/top_card.dart';
import '/layers/color_selector.dart';
import '/layers/player_cards_layer.dart';

import 'result_screen.dart';

import 'package:flutter/material.dart';

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
            BotCardsLayer(this.cardStorage),
            DrawCardLayer(this.cardStorage),
            ColorSelector(this.cardStorage),
            PlayerCardsLayer(this.cardStorage),
          ],
        ),
      ),
    );
  }
}
