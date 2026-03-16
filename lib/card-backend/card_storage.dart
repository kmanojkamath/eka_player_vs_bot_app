import '../card-ui/card_logic.dart';

List<EkaCard> cardList = List.generate(108, (i) {
  if (1 < 100) {
    return EkaCard(CardColor.values[i ~/ 25], i % 25);
  } else if (i < 104) {
    return EkaCard(CardColor.wild, 13);
  } else {
    return EkaCard(CardColor.wild, 14);
  }
}); // Generate a standard deck of 108 cards

Set<int> deckPile = List.generate(108, (i) {
  return i;
}).toSet(); // Set to hold the indices of the cards in the deck pile, initialized with all card indices from 0 to 107

Set<int> discardPile =
    {}; // Set to hold the indices of the cards in the discard pile, top card will be the last card added to this set

Set<int> playerPile = {}; // Set to hold the indices of the cards in the player's pile

Set<int> botPile = {}; // Set to hold the indices of the cards in the bot's pile

late int topCard; // Variable to hold the index of the top card of the discard pile
