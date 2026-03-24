import 'dart:async';

import 'package:eka_player_vs_bot/game_logic/draw_two.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import '../animations/play_card.dart';
import '../animations/show_playable_cards.dart';
import '../logics/playable_cards.dart';
import 'bot_turn.dart';
import 'wild_card.dart';
import 'wild_draw_four.dart';

Future<void> _postPlayerTurn() async {
  playerPile.remove(selectedCard.value);
  topCard = selectedCard.value;

  if (topCard.isDrawTwo) {
    await botDrawTwo();
  } else if (topCard.isSkip || topCard.isReverse) {
    await playerTurn();
  } else if (topCard.isWildCard) {
    await playerWildCard();
  } else if (topCard.isWildDrawFour) {
    await playerWildDrawFour();
  } else {
    await botTurn();
  }
}

Future<void> waitForPlayer() {
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

  if (playablePlayerCards().isEmpty) canDraw = true;

  await showPlayableCards();

  await waitForPlayer();

  await playerPlayCard();

  topCard = selectedCard.value;

  playerPile.remove(selectedCard.value);

  updateTopCardWidget.call(topCard.ci);

  if(playerPile.isEmpty) showResultScreen.call(true);

  await unshowPlayableCards();

  await _postPlayerTurn();
}
