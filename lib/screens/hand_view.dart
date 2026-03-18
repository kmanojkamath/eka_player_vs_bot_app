import 'dart:math';

import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:eka_player_vs_bot/card/card-backend/card_storage.dart';
import 'package:flutter/material.dart';

double cardAngle(int n, int i) {
  double angle = 0.2 * (1 - (n - 1) / 27);
  return (i - (n - 1) / 2) * angle;
}

Offset cardPosition(int n, int i, BuildContext context, double cardScale) {
  double widthDifference = 18;
  Size size = MediaQuery.sizeOf(context);

  double lowest = size.height * 0.5;
  double highest = size.height * 0.4;

  double x = i - (n - 1) / 2;

  double cardWidth = 188 * cardScale;

  return Offset(
    x * widthDifference +
        size.width / 2 -
        cardWidth * cos(cardAngle(n, i)) * 0.5,
    (lowest - highest) / ((n / 2) * (n / 2)) * x * x +
        highest,
  );
}

class HandView extends StatefulWidget {
  List<CardController> cardController = List.generate(
    25,
    (i) => CardController(),
  );
  HandView({super.key});

  @override
  State<HandView> createState() => _HandViewState();
}

class _HandViewState extends State<HandView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(25, (i) {
        return AnimatedCard(
          card[i*2],
          widget.cardController[i],
          cardScale: MediaQuery.sizeOf(context).height * 0.1 / 281,
          cardWidthScale: 0,
          cardPosition: Offset(
            MediaQuery.sizeOf(context).width * 0.75,
            MediaQuery.sizeOf(context).height * 0.1,
          ),
        );
      }),
    );
  }
}

class HandViewScreen extends StatefulWidget {
  const HandViewScreen({super.key});

  @override
  State<HandViewScreen> createState() => _HandViewScreenState();
}

class _HandViewScreenState extends State<HandViewScreen> {
  int i = 0;
  bool front = true;
  final hv = HandView();
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
            hv.cardController[i].changeWidthScale!.call(
              1,
              Duration(milliseconds: 500),
              Curves.linear,
            ),
            hv.cardController[i].changeScale!.call(
              MediaQuery.sizeOf(context).height * 0.25 / 281,
              Duration(milliseconds: 500),
              Curves.easeInOut,
            ),
          ]);

          List<Future> L = [];
          L.addAll(
            List.generate(i + 1, (j) {
              return hv.cardController[j].changeAngle!.call(
                cardAngle(i + 2, j),
                Duration(milliseconds: j == i ? 750 : 400),
                Curves.linear,
              );
            }),
          );
          L.addAll(
            List.generate(i + 1, (j) {
              return hv.cardController[j].changePosition!.call(
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
