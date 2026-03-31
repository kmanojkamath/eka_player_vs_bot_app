import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

import 'game_initialiser.dart';

class ResultScreen extends StatelessWidget {
  final bool didWin;
  const ResultScreen({super.key, required this.didWin});

  @override
  Widget build(BuildContext context) {
    reset();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            colors: [
              didWin ? Colors.lightGreen : Colors.red,
              didWin ? Colors.green[900]! : Colors.brown,
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 5),
            Text(
              didWin ? "You Win" : "You Lose",
              style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
            ),
            const Spacer(flex: 1),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
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
                        Icons.replay_rounded,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      " PLAY AGAIN",
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
    );
  }
}
