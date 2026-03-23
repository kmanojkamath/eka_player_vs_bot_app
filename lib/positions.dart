import 'dart:math';
import 'dart:ui';

import 'global.dart';

Offset playerCardPosition(int ci) {
  int n = playerPile.length;
  int i = playerPile.toList().indexOf(ci);

  double widthDifference = 24;

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
  int n = playerPile.length;
  int i = playerPile.toList().indexOf(ci);
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

double get playerCardScale => 1;

double botCardAngle(int i) {
  int n = botPile.length;
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset botCardPosition(int i) {
  int n = botPile.length;

  double widthDifference = 12;

  double lowest = screenSize.height * 0.15;
  double highest = screenSize.height * 0.1;

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
  int n = playerPile.length;
  int i = playerPile.toList().indexOf(ci);
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset playableCardPosition(int ci) {
  int n = playerPile.length;
  int i = playerPile.toList().indexOf(ci);

  double widthDifference = 24;

  double x = i - (n - 1) / 2;

  double cardWidth = 188;

  return Offset(
    x * widthDifference + screenSize.width / 2 - cardWidth * 0.5,
    screenSize.height * 0.6,
  );
}

double get playableCardScale => 1;

Offset get topCardPosition =>
    Offset(screenSize.width * 0.4, screenSize.height * 0.3);
double get topCardScale => 0.75;

Offset get drawPosition =>
    Offset(screenSize.width * 0.75, screenSize.height * 0.33);
double get drawScale => 0.5;