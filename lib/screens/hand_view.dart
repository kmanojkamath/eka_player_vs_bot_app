import 'package:eka_player_vs_bot/card/card-backend/card_storage.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:flutter/material.dart';

import '../card/animated-cards/animated_card.dart';
import '../card/animated-cards/hand_holder.dart';

List<CardController> handCardController = List.generate(
  25,
  (i) => CardController(),
);

List<EkaCard> ekaCardList = List.generate(25, (i) => card[2 * i]);

class HandViewScreen extends StatefulWidget {
  const HandViewScreen({super.key});

  @override
  State<HandViewScreen> createState() => _HandViewScreenState();
}

class _HandViewScreenState extends State<HandViewScreen> {
  int i = 0;
  bool front = true;
  final hv = HandHolder(ekaCardList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hv,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            if (i == 25) front = false;
            if (i == 1) front = true;
            if (front) {
              i++;
            } else {
              i--;
            }
          });

          await Future.wait([
            hv.cardList[i].controller.changeWidthScale!.call(
              1,
              Duration(milliseconds: 500),
              Curves.linear,
            ),
            hv.cardList[i].controller.changeScale!.call(
              1,
              Duration(milliseconds: 500),
              Curves.easeInOut,
            ),
          ]);

          List<Future> L = [];
          L.addAll(
            List.generate(i + 1, (j) {
              return hv.cardList[j].controller.changeAngle!.call(
                cardAngle(i + 2, j),
                Duration(milliseconds: j == i ? 750 : 400),
                Curves.linear,
              );
            }),
          );
          L.addAll(
            List.generate(i + 1, (j) {
              return hv.cardList[j].controller.changePosition!.call(
                cardPosition(i + 2, j, context, 0.5),
                Duration(milliseconds: j == i ? 750 : 400),
                Curves.linear,
              );
            }),
          );
          await Future.wait(L as Iterable<Future<dynamic>>);
        },
      ),
    );
  }
}
