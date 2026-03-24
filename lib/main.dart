import 'package:eka_player_vs_bot/screens/game_initialiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    Choose from the following screens to test the card animations:
    - CardViewScreen(): A screen to view a single card with customizable value and color.
    - CardScaleAnimationScreen(): A screen to test scaling, positioning, and rotation animations on a card.
    - CardAnimationScreen(): A screen to test a sequence of animations on a card, including moving, rotating, and scaling.
    - HandViewScreen(): A screen to view a hand of cards.
    - GameInitialiser(): A screen which shows the tossing mechanism
    */
    return MaterialApp(home: GameInitialiser());
  }
}
