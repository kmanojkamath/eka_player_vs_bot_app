import 'package:eka_player_vs_bot/global.dart';
import 'package:eka_player_vs_bot/screens/launch_screen.dart';
import 'package:flutter/material.dart';

class ScreenSizeMeaseaurer extends StatefulWidget {
  const ScreenSizeMeaseaurer({super.key});

  @override
  State<ScreenSizeMeaseaurer> createState() => _ScreenSizeMeaseaurerState();
}

class _ScreenSizeMeaseaurerState extends State<ScreenSizeMeaseaurer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LaunchScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    return const SizedBox.shrink();
  }
}
