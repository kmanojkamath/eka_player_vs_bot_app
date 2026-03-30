import 'dart:math';

import '../card/card_logic.dart';
import '../global.dart';
import 'playable_cards.dart';

Future<int> mediumBot() async {
  // Function to determine the Medium bot's move
  if (playableBotCards().isEmpty) {
    return -1;
  } else {
    return playableBotCards().elementAt(
      Random().nextInt(playableBotCards().length),
    );
  }
}

Future<CardColor> mediumBotColor() async {
  Set<CardColor> colors = {};
  playableBotCards().forEach((ci) {
    colors.add(card[ci].color);
  });
  colors.remove(CardColor.wild);
  if (colors.isEmpty) {
    return CardColor.values[Random().nextInt(4)];
  } else {
    return colors.toList().elementAt(Random().nextInt(colors.length));
  }
}
