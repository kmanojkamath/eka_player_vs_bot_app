import 'package:eka_player_vs_bot/card/animated-cards/bot_cards_holder.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';
import 'package:eka_player_vs_bot/global.dart';

import '../card/animated-cards/player_cards_holder.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Stack(children: [BotCardsHolder(botCard), PlayerCardsHolder()]),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {

          //     await Future.wait([
          //       backOfDrawingCard.changeWidthScale!.call(
          //         0,
          //         Duration(milliseconds: 300),
          //         Curves.linear,
          //       ),
          //       backOfDrawingCard.changeScale!.call(
          //         0.75,
          //         Duration(milliseconds: 300),
          //         Curves.easeInOut,
          //       ),
          //     ]);

          //     await Future.wait([
          //       card[i].controller.changeWidthScale!.call(
          //         1,
          //         Duration(milliseconds: 300),
          //         Curves.linear,
          //       ),
          //       card[i].controller.changeScale!.call(
          //         1,
          //         Duration(milliseconds: 300),
          //         Curves.easeInOut,
          //       ),
          //     ]);

          //     await Future.wait([
          //       backOfDrawingCard.changeWidthScale!.call(
          //         1,
          //         Duration(milliseconds: 0),
          //         Curves.linear,
          //       ),
          //       backOfDrawingCard.changeScale!.call(
          //         0.5,
          //         Duration(milliseconds: 0),
          //         Curves.easeInOut,
          //       ),
          //     ]);

          //     await Future.wait([
          //       ...List.generate(i + 1, (j) {
          //         return card[j].controller.changeAngle!.call(
          //           cardAngle(i + 1, j),
          //           Duration(milliseconds: j == i ? 750 : 400),
          //           Curves.linear,
          //         );
          //       }),
          //       ...List.generate(i + 1, (j) {
          //         return card[j].controller.changePosition!.call(
          //           cardPosition(i + 1, j, constraints, 0.5),
          //           Duration(milliseconds: j == i ? 750 : 400),
          //           Curves.linear,
          //         );
          //       }),
          //     ]);
          //   },
          // ),
        );
      },
    );
  }
}
