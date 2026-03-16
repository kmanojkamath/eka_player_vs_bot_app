import 'package:flutter/foundation.dart';

enum CardColor {
  red,
  green,
  blue,
  yellow,
  wild,
} //Enum to represent card colors, including wild cards

class EkaCard {
  late final int _ci; //Card Index, unique for all cards

  /*Card Indexing:
0-24: Red 0, (Red 1-9, Skip, Reverse, Draw Two) x 2 (25 cards)
25-49: Green 0, (Green 1-9, Skip, Reverse, Draw Two) x 2 (25 cards)
50-74: Blue 0, (Blue 1-9, Skip, Reverse, Draw Two) x 2 (25 cards)
75-99: Yellow 0, (Yellow 1-9, Skip, Reverse, Draw Two) x 2 (25 cards)
100-103: Wild Cards (4 cards)
104-107: Wild Draw Four Cards (4 cards)
*/

  EkaCard(this._ci); //Constructor to create a card from its index

  CardColor get color {
    //Determine color based on card index
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
    //Determine value based on card index
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

  /*Helper getters to identify card types based on value:*/
  bool get isNumber => value < 10;
  bool get isSkip => value == 10;
  bool get isReverse => value == 11;
  bool get isDrawTwo => value == 12;
  bool get isWild => value == 13 || value == 14;
  bool get isWildCard => value == 13;
  bool get isWildDrawFour => value == 14;
}
