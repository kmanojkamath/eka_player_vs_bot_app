import 'package:eka_player_vs_bot/screens/card_scale_animation_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:CardScaleAnimationScreen());
  }
}