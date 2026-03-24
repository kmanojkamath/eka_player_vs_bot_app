import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool didWin;
  const ResultScreen({super.key, required this.didWin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          didWin ? "You Win" : "You Loose",
          style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
