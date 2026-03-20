import '../global.dart';
import 'bot_turn.dart';
import 'player_turn.dart';

void _postPlayerWildDrawFour() {
  if (deckPile.length < 4) {
    deckPile = [...discardPile];
    deckPile.remove(topCard.ci);
    discardPile.clear();
    discardPile.add(topCard.ci);
  }
  botPile.add(deckPile.removeLast());
  botPile.add(deckPile.removeLast());
  botPile.add(deckPile.removeLast());
  botPile.add(deckPile.removeLast());
  playerTurn();
}

Future<void> playerWildDrawFour() async {
  _postPlayerWildDrawFour();
}

void _postBotWildDrawFour() {
  if (deckPile.length < 4) {
    deckPile = [...discardPile];
    deckPile.remove(topCard.ci);
    discardPile.clear();
    discardPile.add(topCard.ci);
  }
  playerPile.add(deckPile.removeLast());
  playerPile.add(deckPile.removeLast());
  playerPile.add(deckPile.removeLast());
  playerPile.add(deckPile.removeLast());
  botTurn();
}

Future<void> botWildDrawFour() async {
  _postBotWildDrawFour();
}
