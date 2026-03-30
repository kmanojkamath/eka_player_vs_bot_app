import 'package:eka_player_vs_bot/screens/game_initialiser.dart';
import 'package:flutter/material.dart';

import '../card/card-ui/card_widget.dart';
import '../card/card_logic.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 5,),
              const Text(
                "eka",
                style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
              ),
              const Text(
                "Player vs. Bot",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 2,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GameInitialiser()),
                  );
                },
                child: const Text(
                  "Play",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
}
