import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:eka_player_vs_bot/animations/card_animations.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/game_logic/card_storage.dart';

enum move {
  gameStart,
  playerTurn,
  botTurn,
  playerDrawTwo,
  botDrawTwo,
  playerWildCard,
  botWildCard,
  playerWildDrawFour,
  botWildDrawFour,
  gameWin,
  gameLose
}

class GamePlay {
  final CardAnimations cardAnimations;

  GamePlay(this.cardAnimations);

  CardStorage get cardStorage => cardAnimations.cardStorage;

  Future<int> mediumBot() async {
    if (playableBotCards().isEmpty) {
      return -1;
    } else {
      return playableBotCards().elementAt(
        Random().nextInt(playableBotCards().length),
      );
    }
  }

  Future<CardColor> mediumBotColor(CardStorage cardStorage) async {
    Set<CardColor> colors = {};

    playableBotCards().forEach((ci) {
      colors.add(cardStorage.card[ci].color);
    });

    colors.remove(CardColor.wild);

    if (colors.isEmpty) {
      return CardColor.values[Random().nextInt(4)];
    } else {
      return colors.toList().elementAt(Random().nextInt(colors.length));
    }
  }

  void reshuffle() {
    cardStorage.deckPile = [...cardStorage.discardPile];
    cardStorage.deckPile.remove(cardStorage.topCard.ci);
    cardStorage.deckPile.shuffle();
    cardStorage.discardPile = [cardStorage.topCard.ci];
  }

  bool isPlayable(int ci) {
    final top = cardStorage.topCard;
    final card = cardStorage.card[ci];

    return (top.isWild && (card.color == cardStorage.selectedColor.value || card.isWild)) ||
        card.isWild ||
        card.color == top.color ||
        card.value == top.value;
  }

  List<int> playableBotCards() =>
      cardStorage.botPile.where((ci) => isPlayable(ci)).toList();

  List<int> playablePlayerCards() =>
      cardStorage.playerPile.where((ci) => isPlayable(ci)).toList();

  Future<move> gameStart(bool botStarts) async {
    for (int i = 0; i < 7; i++) {
      int ci = cardStorage.deckPile.removeLast();
      cardStorage.playerPile.add(ci);
      await cardAnimations.playerDrawCard(ci);

      cardStorage.botPile.add(cardStorage.deckPile.removeLast());
      await cardAnimations.botDrawCard();
    }

    while (cardStorage.card[cardStorage.deckPile.last].isWild) {
      cardStorage.deckPile.insert(0, cardStorage.deckPile.removeLast());
    }

    cardStorage.topCard = cardStorage.deckPile.removeLast();

    await cardAnimations.putTopCard();

    if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
      if (botStarts) {
        return move.playerTurn;
      } else {
        return move.botTurn;
      }
    } else if (cardStorage.topCard.isDrawTwo) {
      if (botStarts) {
        return move.botDrawTwo;
      } else {
        return move.playerDrawTwo;
      }
    } else {
      if (botStarts) {
        return move.botTurn;
      } else {
        return move.playerTurn;
      }
    }
  }

  Future<void> waitForPlayer() {
    if (playablePlayerCards().isEmpty) cardStorage.canDraw = true;

    final completer = Completer<int>();

    late VoidCallback listener;

    listener = () {
      cardStorage.selectedCard.removeListener(listener);
      completer.complete(cardStorage.selectedCard.value);
    };

    cardStorage.selectedCard.addListener(listener);
    return completer.future;
  }

  Future<move> playerTurn() async {
    await cardAnimations.showPlayableCards();

    await waitForPlayer();

    if (cardStorage.selectedCard.value < 0) {
      if (cardStorage.deckPile.isEmpty) reshuffle();

      int ci = cardStorage.deckPile.removeLast();
      cardStorage.playerPile.add(ci);

      await cardAnimations.playerDrawCard(ci);

      if (isPlayable(ci)) {
        return move.playerTurn;
      } else {
        return move.botTurn;
      }
    } else {
      await cardAnimations.playerPlayCard();

      cardStorage.topCard = cardStorage.selectedCard.value;

      cardStorage.playerPile.remove(cardStorage.selectedCard.value);

      cardStorage.changeDisplayedTopCard();

      if (cardStorage.playerPile.isEmpty) return move.gameWin;

      await cardAnimations.unshowPlayableCards();

      cardStorage.playerPile.remove(cardStorage.selectedCard.value);
      cardStorage.topCard = cardStorage.selectedCard.value;

      if (cardStorage.topCard.isDrawTwo) {
        return move.botDrawTwo;
      } else if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
        return move.playerTurn;
      } else if (cardStorage.topCard.isWildCard) {
        return move.playerWildCard;
      } else if (cardStorage.topCard.isWildDrawFour) {
        return move.playerWildDrawFour;
      } else {
        return move.botTurn;
      }
    }
  }

  Future<move> botTurn() async {
    int ci = await mediumBot();

    if (ci == -1) {
      if (cardStorage.deckPile.isEmpty) reshuffle();

      int i = cardStorage.deckPile.removeLast();
      cardStorage.botPile.add(i);

      await cardAnimations.botDrawCard();

      if (isPlayable(i)) {
        return move.botTurn;
      } else {
        return move.playerTurn;
      }
    } else {
      cardStorage.topCard = ci;

      cardStorage.botPile.remove(ci);

      await cardAnimations.botPlayCard();

      if (cardStorage.botPile.isEmpty) return move.gameLose;

      cardStorage.botPile.remove(ci);
      cardStorage.topCard = ci;

      if (cardStorage.topCard.isDrawTwo) {
        return move.playerDrawTwo;
      } else if (cardStorage.topCard.isSkip || cardStorage.topCard.isReverse) {
        return move.botTurn;
      } else if (cardStorage.topCard.isWildCard) {
        return move.botWildCard;
      } else if (cardStorage.topCard.isWildDrawFour) {
        return move.botWildDrawFour;
      } else {
        return move.playerTurn;
      }
    }
  }

  Future<move> playerDrawTwo() async {
    if (cardStorage.deckPile.length < 2) reshuffle();

    int ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);

    await cardAnimations.playerDrawCard(ci);

    ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);

    await cardAnimations.playerDrawCard(ci);

    return move.botTurn;
  }

  Future<move> botDrawTwo() async {
    if (cardStorage.deckPile.length < 2) reshuffle();

    cardStorage.botPile.add(cardStorage.deckPile.removeLast());

    await cardAnimations.botDrawCard();

    cardStorage.botPile.add(cardStorage.deckPile.removeLast());

    await cardAnimations.botDrawCard();

    return move.playerTurn;
  }

  Future<CardColor> waitForColor() {
    final completer = Completer<CardColor>();

    late VoidCallback listener;
    listener = () {
      cardStorage.selectedColor.removeListener(listener);
      completer.complete(cardStorage.selectedColor.value);
    };

    cardStorage.selectedColor.addListener(listener);
    return completer.future;
  }

  Future<move> playerWildCard() async {
    cardStorage.selectedColor.value = CardColor.wild;

    cardStorage.showColorSelector.call();

    await waitForColor();

    await Future.delayed(Duration(milliseconds: 420));

    return move.botTurn;
  }

  Future<move> botWildCard() async {
    cardStorage.selectedColor.value = await mediumBotColor(cardStorage);

    return move.playerTurn;
  }

  Future<move> playerWildDrawFour() async {
    cardStorage.selectedColor.value = CardColor.wild;

    cardStorage.showColorSelector.call();

    await waitForColor();

    await Future.delayed(Duration(milliseconds: 420));

    if (cardStorage.deckPile.length < 4) reshuffle();

    cardStorage.botPile.add(cardStorage.deckPile.removeLast());
    await cardAnimations.botDrawCard();
    cardStorage.botPile.add(cardStorage.deckPile.removeLast());
    await cardAnimations.botDrawCard();
    cardStorage.botPile.add(cardStorage.deckPile.removeLast());
    await cardAnimations.botDrawCard();
    cardStorage.botPile.add(cardStorage.deckPile.removeLast());
    await cardAnimations.botDrawCard();

    return move.playerTurn;
  }

  Future<move> botWildDrawFour() async {
    cardStorage.selectedColor.value = await mediumBotColor(cardStorage);

    if (cardStorage.deckPile.length < 4) reshuffle();

    int ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);
    await cardAnimations.playerDrawCard(ci);
    ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);
    await cardAnimations.playerDrawCard(ci);
    ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);
    await cardAnimations.playerDrawCard(ci);
    ci = cardStorage.deckPile.removeLast();
    cardStorage.playerPile.add(ci);
    await cardAnimations.playerDrawCard(ci);

    return move.botTurn;
  }
}
