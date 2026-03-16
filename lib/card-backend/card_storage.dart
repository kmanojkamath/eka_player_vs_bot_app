import '../card-ui/card_logic.dart';

Set<EkaCard> deckPile = List.generate(108, (i) {
  return EkaCard(i);
}).toSet();

Set<EkaCard> discardPile = {};

Set<EkaCard> playerPile = {};

Set<EkaCard> botPile = {};

late EkaCard topCard;