import 'package:eka_player_vs_bot/screens/game_initialiser.dart';
import 'package:flutter/material.dart';

import '../card/card-ui/card_widget.dart';
import '../card/card_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool startTurn = false;
  bool showTitle = false;
  bool showSubtitle = false;
  bool showPlay = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        startTurn = true;
        showTitle = true;
      });
      await Future.delayed(Duration(milliseconds: 360));
      setState(() {
        showSubtitle = true;
      });
      await Future.delayed(Duration(milliseconds: 360));
      setState(() {
        showPlay = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Transform.scale(
            scale: 3,
            child: AnimatedRotation(
              curve: Curves.linear,
              turns: startTurn ? 12 : 0,
              duration: Duration(seconds: 81),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    colors: [
                      color(CardColor.green),
                      color(CardColor.blue),
                      color(CardColor.blue),
                      color(CardColor.yellow),
                      color(CardColor.yellow),
                      color(CardColor.red),
                      color(CardColor.red),
                      color(CardColor.green),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 5),
              AnimatedScale(
                scale: showTitle ? 1 : 0,
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 540),
                child: const Text(
                  "eka",
                  style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
                ),
              ),
              AnimatedOpacity(
                opacity: showTitle ? 1 : 0,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 540),
                child: const Text(
                  "Player vs. Bot",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(flex: 2),
              AnimatedScale(
                scale: showPlay ? 1 : 0,
                duration: Duration(milliseconds: 480),
                child: ElevatedButton(
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
              ),
              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
