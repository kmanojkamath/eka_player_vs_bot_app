import 'package:eka_player_vs_bot/game_logic/card_storage.dart';

import '../global.dart';

List<int> playableBotCards(CardStorage cardStorage) =>
    cardStorage.botPile.where((ci) => isPlayable(ci, cardStorage)).toList();

List<int> playablePlayerCards(CardStorage cardStorage) =>
    cardStorage.playerPile.where((ci) => isPlayable(ci, cardStorage)).toList();

bool isPlayable(int ci, CardStorage cardStorage) {
  final top = cardStorage.topCard;
  final card = cardStorage.card[ci];

  return (top.isWild && (card.color == selectedColor.value || card.isWild)) ||
      card.isWild ||
      card.color == top.color ||
      card.value == top.value;
}
