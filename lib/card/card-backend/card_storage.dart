import 'package:eka_player_vs_bot/card/animated-cards/animated_back_card.dart';
import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';

import '../card_logic.dart';

List<EkaCard> card = List.generate(108, (i) {
  if (i < 100) {
    return EkaCard(
      CardColor.values[i ~/ 25],
      (i % 25 + 1) ~/ 2,
      CardController(),
    );
  } else if (i < 104) {
    return EkaCard(CardColor.wild, 13, CardController());
  } else {
    return EkaCard(CardColor.wild, 14, CardController());
  }
}); // Generate a standard deck of 108 cards

BackCardController backOfDrawingCard = BackCardController();

BackCardController stationary = BackCardController();

List<BackCardController> botCard = List.filled(27, BackCardController());

List<int> deckPile = List.generate(
  108,
  (i) {
    return i;
  },
)..shuffle(); // List to hold the indices of the cards in the deck pile, initialized with all card indices from 0 to 107

List<int> discardPile =
    []; // List to hold the indices of the cards in the discard pile, top card will be the last card added to this List

List<int> playerPile =
    []; // List to hold the indices of the cards in the player's pile

List<int> botPile =
    []; // List to hold the indices of the cards in the bot's pile

late int
topCard; // Variable to hold the index of the top card of the discard pile
