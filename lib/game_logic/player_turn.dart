import 'dart:async';

import 'package:eka_player_vs_bot/game_logic/draw_two.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import '../animations/play_card.dart';
import '../animations/show_playable_cards.dart';
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
  canDraw = true;

  final completer = Completer<int>();

  late VoidCallback listener;

  listener = () {
    selectedCard.removeListener(listener);
    completer.complete(selectedCard.value);
  };

  selectedCard.addListener(listener);
  return completer.future;
}

Future<dynamic> waitAfterDraw() {
  canDraw = true;
  backgroundLock = false;

  final completer = Completer<dynamic>();

  late VoidCallback listener1;
  late VoidCallback listener2;

  void cleanup() {
    selectedCard.removeListener(listener1);
    backgroundPressed.removeListener(listener2);
  }

  listener1 = () {
    if (!completer.isCompleted) {
      completer.complete(selectedCard.value);
      cleanup();
    }
  };

  listener2 = () {
    if (!completer.isCompleted) {
      completer.complete(backgroundPressed.value);
      cleanup();
    }
  };

  selectedCard.addListener(listener1);
  backgroundPressed.addListener(listener2);

  return completer.future;
}

Future<void> playerTurn() async {
  await showPlayableCards();

  await waitForPlayer();

  await playerPlayCard();

  topCard = selectedCard.value;

  playerPile.remove(selectedCard.value);

  updateTopCardWidget.call(topCard.ci);

  if (playerPile.isEmpty) showResultScreen.call(true);

  await unshowPlayableCards();

  await _postPlayerTurn();
}

Future<void> afterDrawTurn() async {
  await showPlayableCards();

  await waitAfterDraw();

  if (backgroundPressed.value == false) {
    backgroundLock = true;
    
    await playerPlayCard();

    topCard = selectedCard.value;

    playerPile.remove(selectedCard.value);

    updateTopCardWidget.call(topCard.ci);

    if (playerPile.isEmpty) showResultScreen.call(true);

    await unshowPlayableCards();

    await _postPlayerTurn();
  } else {
    backgroundPressed.value = false;

    await unshowPlayableCards(didPlay: false);

    await botTurn();
  }
}
