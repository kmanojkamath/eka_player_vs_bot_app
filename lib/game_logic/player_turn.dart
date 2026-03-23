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
  await showPlayableCards();

  await waitForPlayer();

  await playerPlayCard();

  topCard = selectedCard.value;

  playerPile.remove(selectedCard.value);

  updateTopCardWidget.call(topCard.ci);

  await unshowPlayableCards();

  _postPlayerTurn();
}
