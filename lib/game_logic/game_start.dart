import 'package:eka_player_vs_bot/global.dart';

import 'bot_turn.dart';
import 'draw_two.dart';
import 'player_turn.dart';

void _preGameStart() {
  for (int i = 0; i < 7; i++) {
    playerPile.add(deckPile.removeLast());
    botPile.add(deckPile.removeLast());
  }

  while (card[deckPile.last].isWild) {
    deckPile.insert(0, deckPile.removeLast());
  }

  topCard = deckPile.removeLast();
}

void _postGameStart() {
  if (topCard.isSkip || topCard.isReverse) {
    if (botStarts) {
      playerTurn();
    } else {
      botTurn();
    }
  } else if (topCard.isDrawTwo) {
    if (botStarts) {
      botDrawTwo();
    } else {
      playerDrawTwo();
    }
  } else {
    if (botStarts) {
      botTurn();
    } else {
      playerTurn();
    }
  }
}

Future<void> gameStart() async {
  _preGameStart();

  _postGameStart();
}
