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
              const Spacer(flex: 5),
              const Text(
                "eka",
                style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
              ),
              const Text(
                "Player vs. Bot",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                clipBehavior: Clip.hardEdge,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GameInitialiser()),
                  );
                },
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        " PLAY",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
