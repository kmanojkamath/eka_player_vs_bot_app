import 'dart:collection';

import 'package:eka_player_vs_bot/card/animated-cards/animated_back_card.dart';
import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:flutter/material.dart';

import 'card/card_logic.dart';

List<EkaCard> card = List.generate(108, (i) {
  if (i < 100) {
    return EkaCard(
      i,
      CardColor.values[i ~/ 25],
      (i % 25 + 1) ~/ 2,
      CardController(),
    );
  } else if (i < 104) {
    return EkaCard(i, CardColor.wild, 13, CardController());
  } else {
    return EkaCard(i, CardColor.wild, 14, CardController());
  }
}); // Generate a standard deck of 108 cards

List<int> deckPile = List.generate(
  108,
  (i) {
    return i;
  },
)..shuffle(); // List to hold the indices of the cards in the deck pile, initialized with all card indices from 0 to 107

List<int> discardPile =
    []; // List to hold the indices of the cards in the discard pile, top card will be the last card added to this List

SplayTreeSet<int> playerPile =
    SplayTreeSet<int>(); // List to hold the indices of the cards in the player's pile

SplayTreeSet<int> botPile =
    SplayTreeSet<int>(); // List to hold the indices of the cards in the bot's pile

EkaCard get topCard => card[discardPile.last]; // Getter to get the the top card of the discard pile

set topCard(int ci){
  discardPile.add(ci);
} // Setter to set the index of the top card of the discard pile, adds the card index to the discard pile list

BackCardController backOfDrawingCard = BackCardController();

BackCardController stationary = BackCardController();

List<BackCardController> botCard = List.generate(27, (i){return BackCardController();});

ValueNotifier<int> selectedCard = ValueNotifier(-1); // Variable to hold the index of the card selected by the player to play
 
late bool botStarts; // Variable to determine if the bot starts the game

late CardColor selectedColor; // Variable to hold the color selected by player/bot when playing a wild card/ a wild draw four

late Size screenSize;

late Function updateTopCardWidget;