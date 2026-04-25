import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/draw_two.dart';
import 'package:eka_player_vs_bot/game_logic/medium_bot.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/game_logic/playable_cards.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';

import '../animations/draw_card.dart';
import '../animations/play_card.dart';
import 'player_turn.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

Future<void> botTurn(CardStorage cardStorage, Positions positions) async {
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
    await botDrawCard(cardStorage, positions);
    if (isPlayable(i, cardStorage)) {
      await botTurn(cardStorage, positions);
    } else {
      await playerTurn(cardStorage, positions);
    }
  } else {
    cardStorage.topCard = ci;

    cardStorage.botPile.remove(ci);

    await botPlayCard(cardStorage, positions);

    if (cardStorage.botPile.isEmpty) showResultScreen.call(false);

    cardStorage.botPile.remove(ci);
    cardStorage.topCard = ci;

    if (cardStorage.topCard.isDrawTwo) {
      await playerDrawTwo(cardStorage, positions);
    } else if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
      await botTurn(cardStorage, positions);
    } else if (cardStorage.topCard.isWildCard) {
      await botWildCard(cardStorage, positions);
    } else if (cardStorage.topCard.isWildDrawFour) {
      await botWildDrawFour(cardStorage, positions);
    } else {
      await playerTurn(cardStorage, positions);
    }
  }
}
