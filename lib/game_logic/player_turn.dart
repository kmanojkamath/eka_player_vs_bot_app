import 'package:eka_player_vs_bot/global.dart';

import 'bot_turn.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

void _prePlayerTurn() {
  selectionLocked = false;
}

void _postPlayerTurn() {
  playerPile.remove(selectedCard.value);
  topCard = selectedCard.value;

  if (topCard.isSkip || topCard.isReverse) {
    playerTurn();
  } else if (topCard.isWildCard) {
    playerWildCard();
  } else if (topCard.isWildDrawFour) {
    playerWildDrawFour();
  } else {
    botTurn();
  }
}

Future<void> playerTurn() async {
  _prePlayerTurn();

  _postPlayerTurn();
}
