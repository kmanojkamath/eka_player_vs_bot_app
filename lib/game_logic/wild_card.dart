import 'dart:async';
import 'dart:ui';

import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/game_logic/medium_bot.dart';
import 'package:flutter/material.dart';

import 'player_turn.dart';

Future<CardColor> waitForColor() {
  final completer = Completer<CardColor>();

  late VoidCallback listener;
  listener = () {
    selectedColor.removeListener(listener);
    completer.complete(selectedColor.value);
  };

  selectedColor.addListener(listener);
  return completer.future;
}

Future<void> playerWildCard(CardAnimations cardAnimations) async {
  selectedColor.value = CardColor.wild;

  showColorSelector.call();

  await waitForColor();

  await Future.delayed(Duration(milliseconds: 420));

  await botTurn(cardAnimations);
}

Future<void> botWildCard(CardAnimations cardAnimations) async {
  CardStorage cardStorage = cardAnimations.cardStorage;

  selectedColor.value = await mediumBotColor(cardStorage);

  await playerTurn(cardAnimations);
}
