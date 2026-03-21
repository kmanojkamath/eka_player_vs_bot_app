import 'package:eka_player_vs_bot/logics/medium_bot.dart';
import 'package:eka_player_vs_bot/global.dart';

import 'player_turn.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

void _preBotTurn() {}

void _postBotTurn(int ci) {
  botPile.remove(ci);
  topCard = ci;

  if (topCard.isSkip || topCard.isReverse) {
    botTurn();
  } else if (topCard.isWildCard) {
    botWildCard();
  } else if (topCard.isWildDrawFour) {
    botWildDrawFour();
  } else {
    playerTurn();
  }
}

Future<void> botTurn() async {
  _preBotTurn();

  int ci = await mediumBot();

  _postBotTurn(ci);
}
