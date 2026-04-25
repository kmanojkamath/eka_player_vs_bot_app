import 'dart:async';

import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/game_logic/draw_two.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/holders/positions.dart';
import 'package:flutter/material.dart';

import '../animations/play_card.dart';
import '../animations/show_playable_cards.dart';
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

Future<void> playerTurn(CardStorage cardStorage, Positions positions) async {
  await showPlayableCards(cardStorage, positions);

  await waitForPlayer(cardStorage);

  await playerPlayCard(cardStorage, positions);

  cardStorage.topCard = selectedCard.value;

  cardStorage.playerPile.remove(selectedCard.value);

  updateTopCardWidget.call(cardStorage.topCard.ci);

  if (cardStorage.playerPile.isEmpty) showResultScreen.call(true);

  await unshowPlayableCards(cardStorage, positions);

  cardStorage.playerPile.remove(selectedCard.value);
  cardStorage.topCard = selectedCard.value;

  if (cardStorage.topCard.isDrawTwo) {
    await botDrawTwo(cardStorage, positions);
  } else if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
    await playerTurn(cardStorage, positions);
  } else if (cardStorage.topCard.isWildCard) {
    await playerWildCard(cardStorage, positions);
  } else if (cardStorage.topCard.isWildDrawFour) {
    await playerWildDrawFour(cardStorage, positions);
  } else {
    await botTurn(cardStorage, positions);
  }
}
