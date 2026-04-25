import 'dart:async';

import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/draw_two.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import 'bot_turn.dart';
import 'playable_cards.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

Future<void> waitForPlayer(CardStorage cardStorage) {
  if (playablePlayerCards(cardStorage).isEmpty) canDraw = true;
  final completer = Completer<int>();

  late VoidCallback listener;

  listener = () {
    selectedCard.removeListener(listener);
    completer.complete(selectedCard.value);
  };

  selectedCard.addListener(listener);
  return completer.future;
}

Future<void> playerTurn(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;

  await cardAnimations.showPlayableCards();

  await waitForPlayer(cardStorage);

  await cardAnimations.playerPlayCard();

  cardStorage.topCard = selectedCard.value;

  cardStorage.playerPile.remove(selectedCard.value);

  updateTopCardWidget.call(cardStorage.topCard.ci);

  if (cardStorage.playerPile.isEmpty) showResultScreen.call(true);

  await cardAnimations.unshowPlayableCards();

  cardStorage.playerPile.remove(selectedCard.value);
  cardStorage.topCard = selectedCard.value;

  if (cardStorage.topCard.isDrawTwo) {
    await botDrawTwo(cardAnimations);
  } else if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
    await playerTurn(cardAnimations);
  } else if (cardStorage.topCard.isWildCard) {
    await playerWildCard(cardAnimations);
  } else if (cardStorage.topCard.isWildDrawFour) {
    await playerWildDrawFour(cardAnimations);
  } else {
    await botTurn(cardAnimations);
  }
}
