import 'package:flutter/material.dart';

import '../../../theme/base_colors.dart';

final int aUnit = 'a'.codeUnitAt(0);
final int spaceUnit = ' '.codeUnitAt(0);

class OutlineSymbologyPainter extends CustomPainter {
  final String text;
  const OutlineSymbologyPainter({required this.text});

  int charToInt(int codeUnit) {
    if (codeUnit == spaceUnit) {
      return 0;
    }
    int dif = codeUnit - aUnit;
    if (dif >= 0 && dif < 26) {
      return dif + 1;
    }

    return -1;
  }

  List<int> toInts(String text) {
    text = text.toLowerCase();
    return text.codeUnits
        .map(charToInt)
        .where((i) => i != -1)
        .toList(growable: false);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    List<int> widths = toInts(text);

    Rect rect = Offset.zero & size;
    Paint ominous = Paint()
      ..color = Tertiary.shade3
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (int ix = 0; ix < widths.length; ++ix) {
      double dx = size.width / (widths.length * 2 + 7);
      double dy = .1 * size.height / (widths.length * 2 + 7);
      int bit = widths[ix];
      rect = Rect.fromLTWH(rect.left + dx, rect.top + dy, rect.width - dx * 2,
          rect.height - dy * 2);
      ominous.color = const Tertiary().getClampedColorDarkening(3 + bit ~/ 2);
      ominous.strokeWidth = bit / 3;
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(12)), ominous);
    }
  }

  @override
  bool shouldRepaint(OutlineSymbologyPainter oldDelegate) {
    return oldDelegate.text != text;
  }
}
