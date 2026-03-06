import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum CardColor { red, green, blue, yellow, wild }

class EkaCard {
  late final int _ci; //Card Index

  EkaCard(this._ci);

  CardColor get color {
    switch (_ci ~/ 25) {
      case 0:
        return CardColor.red;
      case 1:
        return CardColor.green;
      case 2:
        return CardColor.blue;
      case 3:
        return CardColor.yellow;
      case 4:
        return CardColor.wild;
      default:
        if (kDebugMode) {
          debugPrint("Card Color Error for Card Index = $_ci");
        }
        return CardColor.wild;
    }
  }

  int get value {
    if (_ci < 100) {
      return (_ci % 25 + 1) ~/ 2;
    } else if (_ci < 104) {
      return 13;
    } else if (_ci < 108) {
      return 14;
    } else {
      if (kDebugMode) {
        debugPrint("Card Value Error for Card Index = $_ci");
      }
      return 14;
    }
  }
}

Color color(CardColor cardcolor){
  switch(cardcolor){
    case CardColor.red:
      return Colors.red;
    case CardColor.green:
      return Colors.green;
    case CardColor.blue:
      return Colors.blue;
    case CardColor.yellow:
      return Colors.yellow;
    case CardColor.wild:
      return Colors.black;
  }
}