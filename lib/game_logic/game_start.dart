import 'package:eka_player_vs_bot/global.dart';

import '../animations/bot_draw_card.dart';
import '../animations/player_draw_card.dart';
import 'bot_turn.dart';
import 'draw_two.dart';
import 'player_turn.dart';

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
  for (int i = 0; i < 7; i++) {
    int ci = deckPile.removeLast();
    playerPile.add(ci);
    await playerDrawCard(ci);

    botPile.add(deckPile.removeLast());
    await botDrawCard();
  }

  while (card[deckPile.last].isWild) {
    deckPile.insert(0, deckPile.removeLast());
  }

  topCard = deckPile.removeLast();

  _postGameStart();
}
