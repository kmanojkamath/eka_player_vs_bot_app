import 'package:flutter/material.dart';
import 'package:eka_player_vs_bot/card/card_widget.dart';

class CardViewScreen extends StatefulWidget {
  const CardViewScreen({super.key});

  @override
  State<CardViewScreen> createState() => _CardViewScreenState();
}

class _CardViewScreenState extends State<CardViewScreen> {
  int _ci = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton(
                hint: Text("Value"),
                items: List.generate(15, (i) {
                  return DropdownMenuItem(value: i, child: Text(i.toString()));
                }),
                onChanged: (v) {
                  setState(() {
                    _ci = (_ci ~/ 25) * 25 + (v ?? 0)*2;
                  });
                },
              ),
              DropdownButton(
                hint: Text("Color"),
                items: List.generate(5, (i) {
                  return DropdownMenuItem(
                    value: i,
                    child: Text(switch (i) {
                      0 => "Red",
                      1 => "Green",
                      2 => "Blue",
                      3 => "Yellow",
                      4 => "Wild",
                      _ => "Error",
                    }),
                  );
                }),
                onChanged: (v) {
                  setState(() {
                    _ci = _ci % 25 + (v ?? 0) * 25;
                  });
                },
              ),
            ],
          ),
          EkaCardWidget(_ci, cardHeight: 420,),
        ],
      ),
    );
  }
}
