import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';

class LengthSummaryWidget extends StatelessWidget {
  final int numDots;
  final double dotSize;
  final Color color;
  const LengthSummaryWidget(
      {super.key,
      required this.numDots,
      this.color = Colors.white,
      this.dotSize = 1});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: 'Reading length: ${Chapter.readingLengthDescriptor(numDots)}',
        //Because there's no onClick
        excludeFromSemantics: true,
        child: CustomPaint(
          foregroundPainter: DotSquarePainter(
              numDots: numDots, dotColor: color, dotSize: dotSize),
        ));
  }

  static int clampDotAmt(int numDots) => math.min(9, math.max(0, numDots));
}

class DotSquarePainter extends CustomPainter {
  final int numDots;
  final Color dotColor;
  final double dotSize;
  const DotSquarePainter(
      {required this.numDots, required this.dotColor, required this.dotSize});

  @override
  void paint(Canvas canvas, Size size) {
    double sqrSize = math.min(size.width, size.height);
    double dotRadius = sqrSize / 6;

    // double maxSpan = dotRadius * 8;
    // double lmargin = dotRadius;

    // var paint = Paint()
    //   ..color = canvasColor
    //   ..strokeWidth = 1;
    // canvas.drawRect(
    //     Rect.fromLTRB(
    //         -dotRadius, -dotRadius, sqrSize + dotRadius, sqrSize + dotRadius),
    //     paint);

    int numDots = LengthSummaryWidget.clampDotAmt(this.numDots);

    if (numDots == 0) {
      return;
    }
    Paint paint = Paint()
      ..color = dotColor
      ..strokeWidth = 0;

    int numCols = math.min(3, numDots);
    int numRows = (numDots / 3).ceil();

    // dot  dot   dot
    // [rr]r[rr]r[rr] = 8 radius in 1 widget
    //However, the dots are NOT allowed to hang off the end, subtracting 2 radii.
    // double dotRadius = sqrSize / 6;
    //Span = radius.
    //I just had to figure these out by hand.
    //Max numDots = 9.
    const List<double> spanColMargin = [2, 3, 1.5, 0];

    double x0 = spanColMargin[numCols] * sqrSize / 6;
    double y0 = spanColMargin[numRows] * sqrSize / 6;
    x0 += (size.width - sqrSize) / 2;
    y0 += (size.height - sqrSize) / 2;

    //I <3 cheap hacks
    int dotsDrawn = 0;

    for (int y = 0; y < numRows; y++) {
      double ypos = y0 + y * (dotRadius * 3);

      for (int x = 0; x < numCols; x++) {
        double xpos = x0 + x * (dotRadius * 3);
        //Heh heh
        if (dotsDrawn >= numDots) {
          return;
        }
        dotsDrawn++;

        Offset center = Offset(xpos, ypos);
        canvas.drawCircle(center, dotRadius * dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DotSquarePainter oldDelegate) =>
      LengthSummaryWidget.clampDotAmt(numDots) !=
      LengthSummaryWidget.clampDotAmt(oldDelegate.numDots);

  @override
  bool shouldRebuildSemantics(DotSquarePainter oldDelegate) =>
      LengthSummaryWidget.clampDotAmt(numDots) !=
      LengthSummaryWidget.clampDotAmt(oldDelegate.numDots);
}
