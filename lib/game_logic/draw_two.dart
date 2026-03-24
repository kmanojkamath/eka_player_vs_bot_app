import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';
import 'package:eka_player_vs_bot/game_logic/player_turn.dart';

import '../animations/draw_card.dart';
import '../global.dart';

Future<void> playerDrawTwo() async {
  if (deckPile.length < 2) {
    deckPile = [...discardPile];
    deckPile.remove(topCard.ci);
    deckPile.shuffle();
    discardPile.clear();
    discardPile.add(topCard.ci);
  }
  int ci = deckPile.removeLast();
  playerPile.add(ci);
  await playerDrawCard(ci);
  ci = deckPile.removeLast();
  playerPile.add(ci);
  await playerDrawCard(ci);
  await botTurn();
}

Future<void> botDrawTwo() async {
  if (deckPile.length < 2) {
    deckPile = [...discardPile];
    deckPile.remove(topCard.ci);
    deckPile.shuffle();
    discardPile.clear();
    discardPile.add(topCard.ci);
  }
  botPile.add(deckPile.removeLast());
  await botDrawCard();
  botPile.add(deckPile.removeLast());
  await botDrawCard();
  await playerTurn();
}
