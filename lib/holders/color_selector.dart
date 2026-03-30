import 'package:eka_player_vs_bot/card/card-ui/card_widget.dart';
import 'package:eka_player_vs_bot/card/card_logic.dart';
import 'package:eka_player_vs_bot/global.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  bool show = false;
  @override
  void initState() {
    super.initState();
    showColorSelector = () {
      setState(() {
        setState(() {
          show = true;
        });
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    if (show) {
      return Align(
        alignment: AlignmentGeometry.center,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: show ? 0.69 : 0,
              duration: Duration(milliseconds: 420),
              child: Container(decoration: BoxDecoration(color: Colors.black)),
            ),
            Positioned(
              right: screenSize.width * 0.5 + screenSize.height * 0.05,
              top: screenSize.height * 0.1,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    selectedColor.value = CardColor.red;
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: show ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: screenSize.height * 0.35,
                      height: screenSize.height * 0.35,
                      decoration: BoxDecoration(
                        color: color(CardColor.red),
                        borderRadius: BorderRadius.circular(
                          screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.5 + screenSize.height * 0.05,
              top: screenSize.height * 0.1,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    selectedColor.value = CardColor.green;
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: show ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: screenSize.height * 0.35,
                      height: screenSize.height * 0.35,
                      decoration: BoxDecoration(
                        color: color(CardColor.green),
                        borderRadius: BorderRadius.circular(
                          screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: screenSize.width * 0.5 + screenSize.height * 0.05,
              bottom: screenSize.height * 0.1,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    selectedColor.value = CardColor.blue;
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: show ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: screenSize.height * 0.35,
                      height: screenSize.height * 0.35,
                      decoration: BoxDecoration(
                        color: color(CardColor.blue),
                        borderRadius: BorderRadius.circular(
                          screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.5 + screenSize.height * 0.05,
              bottom: screenSize.height * 0.1,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    selectedColor.value = CardColor.yellow;
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: show ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: screenSize.height * 0.35,
                      height: screenSize.height * 0.35,
                      decoration: BoxDecoration(
                        color: color(CardColor.yellow),
                        borderRadius: BorderRadius.circular(
                          screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
