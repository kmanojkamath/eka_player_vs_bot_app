import '../global.dart';

List<int> playableBotCards() {
  // Function to determine which cards in the bot's pile are playable based on the top card of the discard pile
  List<int> S = [];
  for (int ci in botPile) {
    if (isPlayable(ci)) S.add(ci);
  }
  return S;
}

List<int> playablePlayerCards() {
  // Function to determine which cards in the player's pile are playable based on the top card of the discard pile
  List<int> S = [];
  for (int ci in playerPile) {
    if (isPlayable(ci)) S.add(ci);
  }
  return S;
}

bool isPlayable(int ci) {
  if (topCard.isWild && (card[ci].color == selectedColor.value || card[ci].isWild)) {
    return true;
  } else if (card[ci].isWild ||
      card[ci].color == topCard.color ||
      card[ci].value == topCard.value) {
    return true;
  } else {
    return false;
  }
}
