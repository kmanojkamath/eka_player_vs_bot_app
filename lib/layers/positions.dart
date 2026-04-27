import 'dart:math';
import 'dart:ui';

import 'package:eka_player_vs_bot/items/card/card_storage.dart';

class Positions {
  final CardStorage cardStorage;

  final Size screenSize;

  const Positions(this.cardStorage, this.screenSize);

  Offset playerCardPosition(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);

    double widthDifference = 32 - cardStorage.playerPile.length / 2;

    double lowest = screenSize.height * 0.8;
    double highest = screenSize.height * 0.7;

    double x = i - (n - 1) / 2;

    double cardWidth = 188;

    return Offset(
      x * widthDifference +
          screenSize.width / 2 -
          cardWidth * cos(playerCardAngle(ci)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
    );
  }

  double playerCardAngle(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);
    double angle = 0.18 * (1 - (n - 1) / 27);
    return (i - (n - 1) / 2) * angle;
  }

  double get playerCardScale => 1.25 - cardStorage.playerPile.length / 48;

  double botCardAngle(int i) {
    int n = cardStorage.botPile.length;
    double angle = 0.2 * (1 - (n - 1) / 27);
    return (i - (n - 1) / 2) * angle;
  }

  Offset botCardPosition(int i) {
    int n = cardStorage.botPile.length;

    double widthDifference = 12;

    double lowest = screenSize.height * 0.075;
    double highest = screenSize.height * 0.025;

    double x = i - (n - 1) / 2;

    double cardWidth = 188 * 0.4;

    return Offset(
      x * widthDifference +
          screenSize.width / 2 -
          cardWidth * cos(botCardAngle(i)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
    );
  }

  double get botCardScale => 0.5;

  double playableCardAngle(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);
    double angle = 0.18 * (1 - (n - 1) / 54);
    return (i - (n - 1) / 2) * angle;
  }

  Offset playableCardPosition(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);

    double widthDifference = 32 - cardStorage.playerPile.length / 2;

    double x = i - (n - 1) / 2;

    double cardWidth = 188;

    return Offset(
      x * widthDifference + screenSize.width / 2 - cardWidth * 0.5,
      screenSize.height * 0.6,
    );
  }

  double get playableCardScale => 1.25 - cardStorage.playerPile.length / 48;

  Offset get topCardPosition =>
      Offset(screenSize.width * 0.4, screenSize.height * 0.3);
  double get topCardScale => 0.75;

  Offset get drawPosition =>
      Offset(screenSize.width * 0.75, screenSize.height * 0.33);
  double get drawScale => 0.5;
}
