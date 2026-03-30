import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool didWin;
  const ResultScreen({super.key, required this.didWin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            colors: [
              didWin? Colors.lightGreen:Colors.red,
              didWin? Colors.green[900]!:Colors.brown,
            ],
          ),
        ),
        child: Center(
          child: Text(
            didWin ? "You Win" : "You Lose",
            style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}