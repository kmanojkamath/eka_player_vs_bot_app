import 'package:eka_player_vs_bot/card/animated-cards/animated_card.dart';
import 'package:flutter/material.dart';

import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/card/card-ui/card_widget.dart';

class CardViewScreen extends StatefulWidget {
  const CardViewScreen({super.key});

  @override
  State<CardViewScreen> createState() => _CardViewScreenState();
}

class _CardViewScreenState extends State<CardViewScreen> {
  int value = 0;
  CardColor color = CardColor.red;

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
                    value = v ?? 0;
                  });
                },
              ),
              DropdownButton(
                hint: Text("Color"),
                items: List.generate(5, (i) {
                  return DropdownMenuItem(
                    value: CardColor.values[i],
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
                    color = v ?? CardColor.red;
                  });
                },
              ),
            ],
          ),
          EkaCardWidget(EkaCard(color, value, CardController()), cardScale: 1.5),
        ],
      ),
    );
  }
}
