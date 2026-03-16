import '../card-ui/card_logic.dart';

List<EkaCard> cardList = List.generate(108, (i) {
  return EkaCard(i);
}); // Generate a standard deck of 108 cards

Set<EkaCard> deckPile = cardList
    .toSet(); // Set to hold the cards in the deck pile, initialized with all cards from the cardList

Set<EkaCard> discardPile =
    {}; // Set to hold the cards in the discard pile, top card will be the last card added to this set

Set<EkaCard> playerPile = {}; // Set to hold the player's pile of cards

Set<EkaCard> botPile = {}; // Set to hold the bot's pile of cards

late EkaCard topCard; // Variable to hold the top card of the discard pile
