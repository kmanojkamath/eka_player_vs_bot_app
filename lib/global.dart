import 'package:flutter/material.dart';
import 'card/card_logic.dart';

ValueNotifier<int> selectedCard = ValueNotifier(-1);

late bool botStarts;

ValueNotifier<CardColor> selectedColor = ValueNotifier(CardColor.wild);

late Function updateTopCardWidget;

late Function showColorSelector;

late Function showResultScreen;

bool canDraw = false;
