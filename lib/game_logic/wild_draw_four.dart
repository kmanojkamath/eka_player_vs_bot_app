import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';

import '../global.dart';
import 'medium_bot.dart';
import 'bot_turn.dart';
import 'player_turn.dart';
import 'wild_card.dart';

Future<void> playerWildDrawFour(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;
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
  await cardAnimations.botDrawCard();
  cardStorage.botPile.add(cardStorage.deckPile.removeLast());
  await cardAnimations.botDrawCard();
  cardStorage.botPile.add(cardStorage.deckPile.removeLast());
  await cardAnimations.botDrawCard();
  cardStorage.botPile.add(cardStorage.deckPile.removeLast());
  await cardAnimations.botDrawCard();

  await playerTurn(cardAnimations);
}

Future<void> botWildDrawFour(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;

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
  await cardAnimations.playerDrawCard(ci);
  ci = cardStorage.deckPile.removeLast();
  cardStorage.playerPile.add(ci);
  await cardAnimations.playerDrawCard(ci);
  ci = cardStorage.deckPile.removeLast();
  cardStorage.playerPile.add(ci);
  await cardAnimations.playerDrawCard(ci);
  ci = cardStorage.deckPile.removeLast();
  cardStorage.playerPile.add(ci);
  await cardAnimations.playerDrawCard(ci);

  await botTurn(cardAnimations);
}
