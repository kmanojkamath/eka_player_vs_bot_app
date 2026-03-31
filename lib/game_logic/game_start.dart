import 'package:eka_player_vs_bot/animations/put_top_card.dart';
import 'package:eka_player_vs_bot/global.dart';

import '../animations/draw_card.dart';
import 'bot_turn.dart';
import 'draw_two.dart';
import 'player_turn.dart';

Future<void> _postGameStart() async {
  if (topCard.isSkip || topCard.isReverse) {
    if (botStarts) {
      await playerTurn();
    } else {
      await botTurn();
    }
  } else if (topCard.isDrawTwo) {
    if (botStarts) {
      await botDrawTwo();
    } else {
      await playerDrawTwo();
    }
  } else {
    if (botStarts) {
      await botTurn();
    } else {
      await playerTurn();
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

  await putTopCard();

  await _postGameStart();
}
