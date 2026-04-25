import 'dart:math';

import 'package:eka_player_vs_bot/game_logic/card_storage.dart';

import '../card/card_logic.dart';
import 'playable_cards.dart';

Future<int> mediumBot(CardStorage cardStorage) async {
  // Function to determine the Medium bot's move
  if (playableBotCards(cardStorage).isEmpty) {
    return -1;
  } else {
    return playableBotCards(
      cardStorage,
    ).elementAt(Random().nextInt(playableBotCards(cardStorage).length));
  }
}

Future<CardColor> mediumBotColor(CardStorage cardStorage) async {
  Set<CardColor> colors = {};

  playableBotCards(cardStorage).forEach((ci) {
    colors.add(cardStorage.card[ci].color);
  });

  colors.remove(CardColor.wild);

  if (colors.isEmpty) {
    return CardColor.values[Random().nextInt(4)];
  } else {
    return colors.toList().elementAt(Random().nextInt(colors.length));
  }
}
