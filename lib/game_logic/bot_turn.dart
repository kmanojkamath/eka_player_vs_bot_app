import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/draw_two.dart';
import 'package:eka_player_vs_bot/game_logic/medium_bot.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/game_logic/playable_cards.dart';

import 'player_turn.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

Future<void> botTurn(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;
  int ci = await mediumBot(cardStorage);

  if (ci == -1) {
    if (cardStorage.deckPile.isEmpty) {
      cardStorage.deckPile = [...cardStorage.discardPile];
      cardStorage.deckPile.remove(cardStorage.topCard.ci);
      cardStorage.deckPile.shuffle();
      cardStorage.discardPile.clear();
      cardStorage.discardPile.add(cardStorage.topCard.ci);
    }
    int i = cardStorage.deckPile.removeLast();
    cardStorage.botPile.add(i);
    await cardAnimations.botDrawCard();
    if (isPlayable(i, cardStorage)) {
      await botTurn(cardAnimations);
    } else {
      await playerTurn(cardAnimations);
    }
  } else {
    cardStorage.topCard = ci;

    cardStorage.botPile.remove(ci);

    await cardAnimations.botPlayCard();

    if (cardStorage.botPile.isEmpty) showResultScreen.call(false);

    cardStorage.botPile.remove(ci);
    cardStorage.topCard = ci;

    if (cardStorage.topCard.isDrawTwo) {
      await playerDrawTwo(cardAnimations);
    } else if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
      await botTurn(cardAnimations);
    } else if (cardStorage.topCard.isWildCard) {
      await botWildCard(cardAnimations);
    } else if (cardStorage.topCard.isWildDrawFour) {
      await botWildDrawFour(cardAnimations);
    } else {
      await playerTurn(cardAnimations);
    }
  }
}
