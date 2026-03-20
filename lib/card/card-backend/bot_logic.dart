import '../../global.dart';

Set<int> playableBotCards() {
  // Function to determine which cards in the bot's pile are playable based on the top card of the discard pile
  Set<int> S = {};
  for (int ci in botPile) {
    if (card[ci].isWildCard ||
        card[ci].isWildDrawFour ||
        card[ci].color == card[topCard].color ||
        card[ci].value == card[topCard].value) {
      S.add(ci);
    }
  }
  return S;
}

Future<int> mediumBot() async {
  // Function to determine the Medium bot's move
  return playableBotCards().first;
}
