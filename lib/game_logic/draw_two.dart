import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/player_turn.dart';

Future<void> playerDrawTwo(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;

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

  await botTurn(cardAnimations);
}

Future<void> botDrawTwo(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;

  if (cardStorage.deckPile.length < 2) {
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

  await playerTurn(cardAnimations);
}
