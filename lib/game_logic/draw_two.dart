import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/player_turn.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';

import '../animations/draw_card.dart';

Future<void> playerDrawTwo(CardStorage cardStorage, Positions positions) async {
  if (cardStorage.deckPile.length < 2) {
    cardStorage.deckPile = [...cardStorage.discardPile];
    cardStorage.deckPile.remove(cardStorage.topCard.ci);
    cardStorage.deckPile.shuffle();
    cardStorage.discardPile.clear();
    cardStorage.discardPile.add(cardStorage.topCard.ci);
  }
  int ci = cardStorage.deckPile.removeLast();
  cardStorage.playerPile.add(ci);
  await playerDrawCard(ci, cardStorage, positions);
  ci = cardStorage.deckPile.removeLast();
  cardStorage.playerPile.add(ci);
  await playerDrawCard(ci, cardStorage, positions);
  await botTurn(cardStorage, positions);
}

Future<void> botDrawTwo(CardStorage cardStorage, Positions positions) async {
  if (cardStorage.deckPile.length < 2) {
    cardStorage.deckPile = [...cardStorage.discardPile];
    cardStorage.deckPile.remove(cardStorage.topCard.ci);
    cardStorage.deckPile.shuffle();
    cardStorage.discardPile.clear();
    cardStorage.discardPile.add(cardStorage.topCard.ci);
  }
  cardStorage.botPile.add(cardStorage.deckPile.removeLast());
  await botDrawCard(cardStorage, positions);
  cardStorage.botPile.add(cardStorage.deckPile.removeLast());
  await botDrawCard(cardStorage, positions);
  await playerTurn(cardStorage, positions);
}
