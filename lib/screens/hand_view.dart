import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

import '../card/animated-cards/player_cards_holder.dart';

List<EkaCard> ekaCardList = List.generate(25, (i) => card[2 * i]);

class HandViewScreen extends StatefulWidget {
  const HandViewScreen({super.key});

  @override
  State<HandViewScreen> createState() => _HandViewScreenState();
}

class _HandViewScreenState extends State<HandViewScreen> {
  int i = -1;
  bool front = true;
  bool firstTime = true;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: PlayerCardsHolder(),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              setState(() {
                if (i == 108) front = false;
                if (i == 0) front = true;
                if (front) {
                  i++;
                } else {
                  i--;
                }
              });

              await Future.wait([
                if (firstTime)
                  backOfDrawingCard.changePosition!.call(
                    Offset(
                      constraints.maxWidth * 0.75,
                      constraints.maxHeight * 0.25,
                    ),
                    Duration(),
                    Curves.linear,
                  ),
                if (firstTime)
                  stationary.changePosition!.call(
                    Offset(
                      constraints.maxWidth * 0.75,
                      constraints.maxHeight * 0.25,
                    ),
                    Duration(),
                    Curves.linear,
                  ),
                if (firstTime)
                  ...List.generate(108, (i) {
                    return card[i].controller.changePosition!.call(
                      Offset(
                        constraints.maxWidth * 0.75,
                        constraints.maxHeight * 0.25,
                      ),
                      Duration(),
                      Curves.linear,
                    );
                  }),
              ]);

              if (firstTime) firstTime = false;

              await Future.wait([
                backOfDrawingCard.changeWidthScale!.call(
                  0,
                  Duration(milliseconds: 300),
                  Curves.linear,
                ),
                backOfDrawingCard.changeScale!.call(
                  0.75,
                  Duration(milliseconds: 300),
                  Curves.easeInOut,
                ),
              ]);

              await Future.wait([
                card[i].controller.changeWidthScale!.call(
                  1,
                  Duration(milliseconds: 300),
                  Curves.linear,
                ),
                card[i].controller.changeScale!.call(
                  1,
                  Duration(milliseconds: 300),
                  Curves.easeInOut,
                ),
              ]);

              await Future.wait([
                backOfDrawingCard.changeWidthScale!.call(
                  1,
                  Duration(milliseconds: 0),
                  Curves.linear,
                ),
                backOfDrawingCard.changeScale!.call(
                  0.5,
                  Duration(milliseconds: 0),
                  Curves.easeInOut,
                ),
              ]);

              await Future.wait([
                ...List.generate(i + 1, (j) {
                  return card[j].controller.changeAngle!.call(
                    cardAngle(i + 1, j),
                    Duration(milliseconds: j == i ? 750 : 400),
                    Curves.linear,
                  );
                }),
                ...List.generate(i + 1, (j) {
                  return card[j].controller.changePosition!.call(
                    cardPosition(i + 1, j, constraints, 0.5),
                    Duration(milliseconds: j == i ? 750 : 400),
                    Curves.linear,
                  );
                }),
              ]);
            },
          ),
        );
      },
    );
  }
}
