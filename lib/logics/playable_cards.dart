import '../global.dart';

List<int> playableBotCards() {
  // Function to determine which cards in the bot's pile are playable based on the top card of the discard pile
  List<int> S = [];
  for (int ci in botPile) {
    if (topCard.isWild &&
        (card[ci].color == selectedColor || card[ci].isWild)) {
      S.add(ci);
    } else if (card[ci].isWild ||
        card[ci].color == topCard.color ||
        card[ci].value == topCard.value) {
      S.add(ci);
    }
  }
  return S;
}

List<int> playablePlayerCards() {
  // Function to determine which cards in the player's pile are playable based on the top card of the discard pile
  List<int> S = [];
  for (int ci in playerPile) {
    if (topCard.isWild &&
        (card[ci].color == selectedColor || card[ci].isWild)) {
      S.add(ci);
    } else if (card[ci].isWild ||
        card[ci].color == topCard.color ||
        card[ci].value == topCard.value) {
      S.add(ci);
    }
  }
  return S;
}