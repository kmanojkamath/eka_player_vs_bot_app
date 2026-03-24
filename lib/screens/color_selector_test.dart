import 'package:eka_player_vs_bot/card/animated-cards/color_selector.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

class ColorSelectorTest extends StatefulWidget {
  const ColorSelectorTest({super.key});

  @override
  State<ColorSelectorTest> createState() => _ColorSelectorTestState();
}

class _ColorSelectorTestState extends State<ColorSelectorTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [ColorSelector()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showColorSelector.call();
        },
      ),
    );
  }
}
