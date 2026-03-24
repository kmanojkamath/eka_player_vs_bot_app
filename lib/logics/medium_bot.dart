import 'dart:math';

import 'playable_cards.dart';

Future<int> mediumBot() async {
  // Function to determine the Medium bot's move
  if(playableBotCards().isEmpty) {
    return -1;
  } else {
    return Random().nextInt(playableBotCards().length);
  }
}
