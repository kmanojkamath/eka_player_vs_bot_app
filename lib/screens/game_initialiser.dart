import 'dart:async';
import 'dart:math';

import '/items/card/card-ui/card_widget.dart';
import '/items/card/card_logic.dart';
import '/items/spinning_wheel/spinning_circle.dart';

import 'package:flutter/material.dart';

import 'game_screen.dart';

class GameInitialiser extends StatefulWidget {
  const GameInitialiser({super.key});

  @override
  State<GameInitialiser> createState() => _GameInitialiserState();
}

class _GameInitialiserState extends State<GameInitialiser> {
  bool botStarts = false;
  double numberOfTurns = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        numberOfTurns = 9 + Random().nextDouble() * 6;
      });
      if (numberOfTurns - numberOfTurns.floor() < 0.25 && numberOfTurns - numberOfTurns.floor() > 0.75)
        botStarts = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: (numberOfTurns * 325).toInt()), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GameScreen(botStarts)),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            colors: [
              color(CardColor.blue),
              color(CardColor.green),
              color(CardColor.yellow),
              color(CardColor.red),
            ],
          ),
        ),
        child: Center(child: SpinningCircle(numberOfTurns: numberOfTurns)),
      ),
    );
  }
}
