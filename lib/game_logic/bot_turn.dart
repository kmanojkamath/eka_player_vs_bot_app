import 'package:eka_player_vs_bot/game_logic/draw_two.dart';
import 'package:eka_player_vs_bot/logics/medium_bot.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/logics/playable_cards.dart';

import '../animations/draw_card.dart';
import '../animations/play_card.dart';
import 'player_turn.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

Future<void> _postBotTurn(int ci) async {
  botPile.remove(ci);
  topCard = ci;

  if (topCard.isDrawTwo) {
    await playerDrawTwo();
  } else if (topCard.isSkip || topCard.isReverse) {
    await botTurn();
  } else if (topCard.isWildCard) {
    await botWildCard();
  } else if (topCard.isWildDrawFour) {
    await botWildDrawFour();
  } else {
    await playerTurn();
  }
}

Future<void> botTurn() async {
  int ci = await mediumBot();

  if (ci == -1) {
    if (deckPile.isEmpty) {
      deckPile = [...discardPile];
      deckPile.remove(topCard.ci);
      deckPile.shuffle();
      discardPile.clear();
      discardPile.add(topCard.ci);
    }
    int i = deckPile.removeLast();
    botPile.add(i);
    await botDrawCard();
    if (isPlayable(i)) {
      await botTurn();
    } else {
      await playerTurn();
    }
  } else {
    topCard = ci;

    botPile.remove(ci);

    await botPlayCard();

    if (botPile.isEmpty) showResultScreen.call(false);

    _postBotTurn(ci);
  }
}
