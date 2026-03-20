import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';

import 'player_turn.dart';

void _postPlayerWildCard() {
  botTurn();
}

Future<void> playerWildCard() async {
  _postPlayerWildCard();
}

void _postBotWildCard() {
  playerTurn();
}

Future<void> botWildCard() async {
  _postBotWildCard();
}
