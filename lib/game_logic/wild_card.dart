import 'dart:async';
import 'dart:ui';

import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/game_logic/bot_turn.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/game_logic/medium_bot.dart';

import 'player_turn.dart';

Future<void> waitForColor() {
  final completer = Completer<CardColor>();

  late VoidCallback listener;
  listener = () {
    selectedColor.removeListener(listener);
    completer.complete(selectedColor.value);
  };

  selectedColor.addListener(listener);
  return completer.future;
}

Future<void> playerWildCard() async {
  showColorSelector.call();

  await waitForColor();

  await Future.delayed(Duration(milliseconds: 420));

  await botTurn();
}

Future<void> botWildCard() async {
  selectedColor.value = await mediumBotColor();

  await playerTurn();
}
