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
  bool start = false;
  @override
  void initState() {
    super.initState();
    showColorSelector = () async {
      setState(() {
        show = true;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        start = true;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    double x = screenSize.width / 17;
    if (show) {
      return Align(
        alignment: AlignmentGeometry.center,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: start ? 0.69 : 0,
              duration: Duration(milliseconds: 420),
              child: Container(decoration: BoxDecoration(color: Colors.black)),
            ),
            Positioned(
              left: x,
              top: screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    selectedColor.value = CardColor.red;
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 100));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
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
              left: 5 * x,
              top: screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    selectedColor.value = CardColor.green;
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 100));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
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
              left: 9 * x,
              top: screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    selectedColor.value = CardColor.blue;
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 100));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
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
              left: 13 * x,
              top: screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    selectedColor.value = CardColor.yellow;
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 100));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(screenSize.height * 0.05),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 420),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
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
