import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'card_logic.dart';
import 'symbols/skip_symbol.dart';
import 'symbols/reverse_symbol.dart';

class Symbol extends StatelessWidget {
  final int _ci;
  final bool isMiddleSymbol;
  final double cardHeight;
  const Symbol(
    this._ci, {
    super.key,
    this.isMiddleSymbol = false,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (EkaCard(_ci).value < 10) {
      return Text(
        EkaCard(_ci).value.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol
              ? 81 * cardHeight / 281
              : 42 * cardHeight / 281,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (EkaCard(_ci).value == 12) {
      return Text(
        "+2",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol
              ? 81 * cardHeight / 281
              : 40 * cardHeight / 281,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (EkaCard(_ci).value == 14) {
      return Text(
        "+4",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol
              ? 81 * cardHeight / 281
              : 40 * cardHeight / 281,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (EkaCard(_ci).value == 10) {
      return SizedBox(
        height: isMiddleSymbol ? 72 * cardHeight / 281 : 32 * cardHeight / 281,
        width: isMiddleSymbol ? 72 * cardHeight / 281 : 32 * cardHeight / 281,
        child: CustomPaint(painter: SkipSymbol()),
      );
    } else if (EkaCard(_ci).value == 11) {
      return SizedBox(
        height: isMiddleSymbol ? 81 * cardHeight / 281 : 42 * cardHeight / 281,
        width: isMiddleSymbol ? 81 * cardHeight / 281 : 42 * cardHeight / 281,
        child: CustomPaint(painter: ReverseSymbol()),
      );
    }

    if (kDebugMode) debugPrint("Card Symbol Error for Card Index $_ci");
    return const Placeholder();
  }
}
