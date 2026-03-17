enum CardColor {
  red,
  green,
  blue,
  yellow,
  wild,
} //Enum to represent card colors, including wild cards

class EkaCard {
  final int value;
  //Value of the card, where 0-9 represent number cards, 10 = Skip, 11 = Reverse, 12 = Draw Two, 13 = Wild, 14 = Wild Draw Four
  final CardColor color; //Color of the card, represented by the CardColor enum

  EkaCard(this.color, this.value); //Constructor to create a card from its index

  /*Helper getters to identify card types based on value:*/
  bool get isNumber => value < 10;
  bool get isSkip => value == 10;
  bool get isReverse => value == 11;
  bool get isDrawTwo => value == 12;
  bool get isWild => value == 13 || value == 14;
  bool get isWildCard => value == 13;
  bool get isWildDrawFour => value == 14;
}
