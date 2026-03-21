import 'dart:async';

import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import '../animations/player_play_card.dart';
import '../animations/show_playable_cards.dart';
import '../logics/playable_cards.dart';
import 'bot_turn.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

void _postPlayerTurn() {
  playerPile.remove(selectedCard.value);
  topCard = selectedCard.value;

  if (topCard.isSkip || topCard.isReverse) {
    playerTurn();
  } else if (topCard.isWildCard) {
    playerWildCard();
  } else if (topCard.isWildDrawFour) {
    playerWildDrawFour();
  } else {
    botTurn();
  }
}

Future<int> waitForPlayer() {
  final completer = Completer<int>();

  late VoidCallback listener;
  listener = () {
    selectedCard.removeListener(listener);
    completer.complete(selectedCard.value);
  };

  selectedCard.addListener(listener);
  return completer.future;
}

Future<void> playerTurn() async {
  playablePlayerCards().forEach((element) {
    card[element].controller.locked = false;
  });
  print("1");
  await showPlayableCards();
  print("2");

  await waitForPlayer();
  print("3");
  await playerPlayCard();
  print("4");

  topCard = selectedCard.value;

  playerPile.removeWhere((element) => element == selectedCard.value);

  updateTopCardWidget.call();

  print("5");

  _postPlayerTurn();
}
