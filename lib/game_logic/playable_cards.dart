import 'package:eka_player_vs_bot/game_logic/card_storage.dart';

import '../global.dart';

List<int> playableBotCards(CardStorage cardStorage) {
  // Function to determine which cards in the bot's pile are playable based on the top card of the discard pile
  List<int> S = [];
  for (int ci in cardStorage.botPile) {
    if (isPlayable(ci, cardStorage)) S.add(ci);
  }
  return S;
}

List<int> playablePlayerCards(CardStorage cardStorage) {
  // Function to determine which cards in the player's pile are playable based on the top card of the discard pile
  List<int> S = [];
  for (int ci in cardStorage.playerPile) {
    if (isPlayable(ci, cardStorage)) S.add(ci);
  }
  return S;
}

bool isPlayable(int ci, CardStorage cardStorage) {
  if (cardStorage.topCard.isWild &&
      (cardStorage.card[ci].color == selectedColor.value ||
          cardStorage.card[ci].isWild)) {
    return true;
  } else if (cardStorage.card[ci].isWild ||
      cardStorage.card[ci].color == cardStorage.topCard.color ||
      cardStorage.card[ci].value == cardStorage.topCard.value) {
    return true;
  } else {
    return false;
  }
}
