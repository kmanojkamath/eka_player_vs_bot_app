import 'package:eka_player_vs_bot/card/card_logic.dart';

import '../animations/draw_card.dart';
import '../global.dart';
import 'medium_bot.dart';
import 'bot_turn.dart';
import 'player_turn.dart';
import 'wild_card.dart';

Future<void> playerWildDrawFour() async {
  selectedColor.value = CardColor.wild;
  
  showColorSelector.call();

  await waitForColor();

  await Future.delayed(Duration(milliseconds: 420));

  if (deckPile.length < 4) {
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
  botPile.add(deckPile.removeLast());
  await botDrawCard();
  botPile.add(deckPile.removeLast());
  await botDrawCard();

  await playerTurn();
}

Future<void> botWildDrawFour() async {
  selectedColor.value = await mediumBotColor();

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
  ci = deckPile.removeLast();
  playerPile.add(ci);
  await playerDrawCard(ci);
  ci = deckPile.removeLast();
  playerPile.add(ci);
  await playerDrawCard(ci);

  await botTurn();
}
