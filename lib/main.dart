import 'package:eka_player_vs_bot/screens/card_animation_test_screen1.dart';
import 'package:eka_player_vs_bot/screens/card_view_screen.dart';
import 'package:eka_player_vs_bot/screens/hand_view.dart';
import 'package:flutter/material.dart';

import 'screens/card_animation_test_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    Choose from the following screens to test the card animations:
    - CardViewScreen(): A screen to view a single card with customizable value and color.
    - HandViewScreen(): A screen to view a hand of cards.
    - CardScaleAnimationScreen(): A screen to test scaling, positioning, and rotation animations on a card.
    - CardAnimationScreen(): A screen to test a sequence of animations on a card, including moving, rotating, and scaling.
    */
    return MaterialApp(home:CardAnimationScreen());
  }
}