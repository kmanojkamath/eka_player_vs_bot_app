import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';

import '../animations/draw_card.dart';
import '../global.dart';
import 'medium_bot.dart';
import 'bot_turn.dart';
import 'player_turn.dart';
import 'wild_card.dart';

Future<void> playerWildDrawFour(
  CardStorage cardStorage,
  Positions positions,
) async {
  selectedColor.value = CardColor.wild;

  showColorSelector.call();

  await waitForColor();

  await Future.delayed(Duration(milliseconds: 420));

  if (cardStorage.deckPile.length < 4) {
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
  cardStorage.botPile.add(cardStorage.deckPile.removeLast());
  await botDrawCard(cardStorage, positions);
  cardStorage.botPile.add(cardStorage.deckPile.removeLast());
  await botDrawCard(cardStorage, positions);

  await playerTurn(cardStorage, positions);
}

Future<void> botWildDrawFour(
  CardStorage cardStorage,
  Positions positions,
) async {
  selectedColor.value = await mediumBotColor(cardStorage);

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
  ci = cardStorage.deckPile.removeLast();
  cardStorage.playerPile.add(ci);
  await playerDrawCard(ci, cardStorage, positions);
  ci = cardStorage.deckPile.removeLast();
  cardStorage.playerPile.add(ci);
  await playerDrawCard(ci, cardStorage, positions);

  await botTurn(cardStorage, positions);
}
