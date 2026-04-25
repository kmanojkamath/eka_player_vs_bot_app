import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/global.dart';

import 'bot_turn.dart';
import 'draw_two.dart';
import 'player_turn.dart';

Future<void> gameStart(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;

  for (int i = 0; i < 7; i++) {
    int ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);
    await cardAnimations.playerDrawCard(ci);

    cardStorage.botPile.add(cardStorage.deckPile.removeLast());
    await cardAnimations.botDrawCard();
  }

  while (cardStorage.card[cardStorage.deckPile.last].isWild) {
    cardStorage.deckPile.insert(0, cardStorage.deckPile.removeLast());
  }

  cardStorage.topCard = cardStorage.deckPile.removeLast();

  await cardAnimations.putTopCard();

  if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
    if (botStarts) {
      await playerTurn(cardAnimations);
    } else {
      await botTurn(cardAnimations);
    }
  } else if (cardStorage.topCard.isDrawTwo) {
    if (botStarts) {
      await botDrawTwo(cardAnimations);
    } else {
      await playerDrawTwo(cardAnimations);
    }
  } else {
    if (botStarts) {
      await botTurn(cardAnimations);
    } else {
      await playerTurn(cardAnimations);
    }
  }
}
