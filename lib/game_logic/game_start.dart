import 'package:eka_player_vs_bot/animations/put_top_card.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';

import '../animations/draw_card.dart';
import 'bot_turn.dart';
import 'draw_two.dart';
import 'player_turn.dart';

Future<void> gameStart(CardStorage cardStorage, Positions positions) async {
  for (int i = 0; i < 7; i++) {
    int ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);
    await playerDrawCard(ci, cardStorage, positions);

    cardStorage.botPile.add(cardStorage.deckPile.removeLast());
    await botDrawCard(cardStorage, positions);
  }

  while (cardStorage.card[cardStorage.deckPile.last].isWild) {
    cardStorage.deckPile.insert(0, cardStorage.deckPile.removeLast());
  }

  cardStorage.topCard = cardStorage.deckPile.removeLast();

  await putTopCard(cardStorage, positions);

  if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
    if (botStarts) {
      await playerTurn(cardStorage, positions);
    } else {
      await botTurn(cardStorage, positions);
    }
  } else if (cardStorage.topCard.isDrawTwo) {
    if (botStarts) {
      await botDrawTwo(cardStorage, positions);
    } else {
      await playerDrawTwo(cardStorage, positions);
    }
  } else {
    if (botStarts) {
      await botTurn(cardStorage, positions);
    } else {
      await playerTurn(cardStorage, positions);
    }
  }
}
