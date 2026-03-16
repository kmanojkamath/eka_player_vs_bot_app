import 'package:eka_player_vs_bot/card-ui/card_logic.dart';
import 'card_storage.dart';

Set<EkaCard> playableBotCards() {
  // Function to determine which cards in the bot's pile are playable based on the top card of the discard pile
  Set<EkaCard> S = {};
  for (EkaCard card in botPile) {
    if (card.isWildCard ||
        card.isWildDrawFour ||
        card.color == topCard.color ||
        card.value == topCard.value) {
      S.add(card);
    }
  }
  return S;
}

Future<EkaCard> mediumBot() async {
  // Function to determine the Medium bot's move
  return playableBotCards().first;
}
