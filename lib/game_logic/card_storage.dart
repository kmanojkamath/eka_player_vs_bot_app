import 'dart:collection';

import '../card/animated-cards/animated_back_card.dart';
import '../card/animated-cards/animated_card.dart';
import '../card/card_logic.dart';

class CardStorage {
  List<EkaCard> _card = List.generate(108, (i) => EkaCard(i, CardController()));

  List<EkaCard> get card => _card;

  List<int> deckPile = List.generate(108, (i) {
    return i;
  })..shuffle();

  List<int> discardPile = [];

  SplayTreeSet<int> playerPile = SplayTreeSet<int>();

  SplayTreeSet<int> botPile = SplayTreeSet<int>();

  EkaCard get topCard => card[discardPile.last];

  set topCard(int ci) => discardPile.add(ci);

  BackCardController backOfDrawingCard = BackCardController();

  BackCardController stationary = BackCardController();

  List<BackCardController> botCard = List.generate(27, (i) {
    return BackCardController();
  });
}
