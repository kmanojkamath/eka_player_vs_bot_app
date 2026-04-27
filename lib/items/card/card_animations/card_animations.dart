import '../animated-cards/animated_back_card.dart';
import '../card_storage.dart';

import '/layers/positions.dart';

import 'package:flutter/material.dart';

import 'card_animator.dart';

class CardAnimations {
  final CardStorage cardStorage;
  final CardAnimator cardAnimator;
  final Positions positions;

  CardAnimations(this.cardStorage, this.positions)
    : cardAnimator = CardAnimator(cardStorage);

  Future<void> playerDrawCard(int ci) async {
    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    await Future.wait(
      cardAnimator.moveBackCard(
        widthScale: 0,
        scale: 0.75,
        duration: drawDuration,
      ),
    );

    await Future.wait(
      cardAnimator.moveCard(
        ci,
        widthScale: 1,
        scale: positions.playerCardScale,
        duration: drawDuration,
      ),
    );

    await Future.wait(cardAnimator.moveBackCard(widthScale: 1, scale: 0.5));

    await Future.wait(
      cardStorage.playerPile.expand(
        (i) => cardAnimator.moveCard(
          i,
          position: positions.playerCardPosition(i),
          angle: positions.playerCardAngle(i),
          scale: positions.playerCardScale,
          duration: i == ci ? moveDuration : drawDuration,
        ),
      ),
    );
  }

  Future<void> botDrawCard() async {
    int n = cardStorage.botPile.length;

    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfBotCard(BackCardController botCard) =>
        cardStorage.botCard.indexOf(botCard);

    await Future.wait(
      cardAnimator.moveBotCard(
        cardStorage.botCard[n - 1],
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.moveBotCard(
        cardStorage.botCard[n - 1],
        widthScale: 1,
        position: positions.botCardPosition(n - 1),
        angle: positions.botCardAngle(n - 1),
        duration: moveDuration,
      ),
      ...cardStorage.botCard
          .getRange(0, n - 1)
          .expand(
            (i) => cardAnimator.moveBotCard(
              i,
              position: positions.botCardPosition(indexOfBotCard(i)),
              angle: positions.botCardAngle(indexOfBotCard(i)),
              duration: drawDuration,
            ),
          ),
    ]);
  }

  Future<void> playerPlayCard() async {
    playablePlayerCards().forEach(
      (element) => cardStorage.card[element].controller.locked = true,
    );

    await Future.wait([
      ...cardAnimator.moveCard(
        cardStorage.selectedCard.value,
        position: positions.topCardPosition,
        angle: 0,
        scale: positions.topCardScale,
        duration: 300,
      ),
      ...playablePlayerCards()
          .where((i) => i != cardStorage.selectedCard.value)
          .expand(
            (ci) => cardAnimator.moveCard(
              ci,
              position: positions.playableCardPosition(ci),
              angle: positions.playableCardAngle(ci),
              scale: positions.playableCardScale,
              duration: 180,
            ),
          ),
    ]);
  }

  Future<void> botPlayCard() async {
    int n = cardStorage.botPile.length;

    await Future.wait(
      cardAnimator.moveBotCard(
        cardStorage.botCard[n],
        scale: positions.drawScale,
        widthScale: 0,
        angle: 0,
        duration: 100,
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.botCardPosition(cardStorage.botPile.length),
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        widthScale: 1,
        duration: 180,
        widthScaleDuration: 100,
      ),
    );

    await cardStorage.botCard[n].changePosition!.call(
      positions.drawPosition,
      Duration(milliseconds: 100),
      Curves.linear,
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );

    int indexOfBotCard(BackCardController botCard) =>
        cardStorage.botCard.indexOf(botCard);

    await Future.wait(
      cardStorage.botCard.expand(
        (botCard) => cardAnimator.moveBotCard(
          botCard,
          angle: positions.botCardAngle(indexOfBotCard(botCard)),
          position: positions.botCardPosition(indexOfBotCard(botCard)),
          duration: 300,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 180));
  }

  Future<void> putTopCard() async {
    await Future.wait(
      cardAnimator.moveBackCard(scale: 0.75, widthScale: 0, duration: 250),
    );

    await Future.wait(
      cardAnimator.moveTopCard(scale: 1, widthScale: 1, duration: 250),
    );

    await Future.wait(cardAnimator.moveBackCard(widthScale: 1, scale: 0.5));

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        duration: 300,
      ),
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );
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

  Future<void> showPlayableCards() async {
    await Future.wait(
      playablePlayerCards().expand(
        (ci) => cardAnimator.moveCard(
          ci,
          angle: 0,
          position: positions.playableCardPosition(ci),
          duration: 180,
        ),
      ),
    );

    playablePlayerCards().forEach(
      (element) => cardStorage.card[element].controller.locked = false,
    );
  }

  Future<void> unshowPlayableCards({bool didPlay = true}) async {
    Future.wait(
      cardStorage.playerPile.expand(
        (ci) => cardAnimator.moveCard(
          ci,
          angle: positions.playerCardAngle(ci),
          position: positions.playerCardPosition(ci),
          scale: positions.playerCardScale,
          duration: 180,
        ),
      ),
    );

    if (didPlay) {
      await Future.wait(
        cardAnimator.moveCard(
          cardStorage.selectedCard.value,
          position: positions.drawPosition,
          scale: positions.drawScale,
          widthScale: 0,
        ),
      );
    }
  }
}
