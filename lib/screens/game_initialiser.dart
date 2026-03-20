import 'dart:async';
import 'dart:math';

import 'package:eka_player_vs_bot/card/card-backend/card_storage.dart';
import 'package:eka_player_vs_bot/toss/tosser.dart';
import 'package:flutter/material.dart';

class GameInitialiser extends StatefulWidget {
  const GameInitialiser({super.key});

  @override
  State<GameInitialiser> createState() => _GameInitialiserState();
}

class _GameInitialiserState extends State<GameInitialiser> {
  double numberOfTurns = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        numberOfTurns = 9 + Random().nextDouble() * 6;
      });
      if((numberOfTurns-9)/6<=0.75 && (numberOfTurns-9)/6>=0.25) {
        botStarts = false;
      } else {
        botStarts = true;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: (numberOfTurns * 325).toInt()), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Placeholder()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Tosser(numberOfTurns: numberOfTurns)),
    );
  }
}
