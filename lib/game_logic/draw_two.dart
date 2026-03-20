import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';

import '../global.dart';

List<int> _prePlayerDrawTwo() {
  if (deckPile.length < 2) {
    deckPile = [...discardPile];
    deckPile.remove(topCard.ci);
    discardPile.clear();
    discardPile.add(topCard.ci);
  }
  List<int> L = [];
  L.add(deckPile.removeLast());
  L.add(deckPile.removeLast());
  playerPile.addAll(L);
  return L;
}

void _postPlayerDrawTwo() {
  botTurn();
}

Future<void> playerDrawTwo() async {
  List<int> drewCards = _prePlayerDrawTwo();

  _postPlayerDrawTwo();
}

void _preBotDrawTwo() {
  if (deckPile.length < 2) {
    deckPile = [...discardPile];
    deckPile.remove(topCard.ci);
    discardPile.clear();
    discardPile.add(topCard.ci);
  }
  botPile.add(deckPile.removeLast());
  botPile.add(deckPile.removeLast());
}

void _postBotDrawTwo() {
  botTurn();
}

Future<void> botDrawTwo() async {
  _preBotDrawTwo();

  _postBotDrawTwo();
}
