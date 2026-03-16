import 'package:eka_player_vs_bot/card-ui/card_logic.dart';
import 'card_storage.dart';

Set<EkaCard> playableBotCards() {
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
  return playableBotCards().first;
}
