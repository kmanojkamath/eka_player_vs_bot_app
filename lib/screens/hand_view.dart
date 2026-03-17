import 'dart:math';

import 'package:flutter/material.dart';

import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/card/card-ui/card_widget.dart';

double cardAngle(int n, int i) {
  double angle = 0.2;
  return (i - n / 2 + 0.5) * angle;
}

double cardLeftPosition(int n, int i, BuildContext context, double cardWidth) {
  return cardCenterPosition(n, i, context) -
      cardWidth * cos(cardAngle(n, i)) * 0.5;
}

double cardCenterPosition(int n, int i, BuildContext context) {
  double widthDifference = 10;
  return ((i - n / 2 + 0.5) * widthDifference +
      MediaQuery.sizeOf(context).width / 2);
}

class HandView extends StatelessWidget {
  final int n;
  const HandView(this.n, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(n, (i) {
        return Positioned(
          left: cardLeftPosition(n, i, context, 150 * 188 / 281),
          bottom: MediaQuery.sizeOf(context).height * 0.05,
          child: Transform.rotate(
            alignment: Alignment.bottomCenter,
            angle: cardAngle(n, i),
            child: EkaCardWidget(EkaCard(CardColor.values[i ~/ 25], i % 25), cardHeight: 150),
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
  int n = 1;
  bool front = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HandView(n),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (n == 13) front = false;
            if (n == 1) front = true;
            if (front) {
              n++;
            } else {
              n--;
            }
          });
        },
      ),
    );
  }
}
