import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../parts/part.dart';

class ReadingProgressIndicator extends StatelessWidget {
  ///Can be null, in which case it'll show full circle, grey color
  final int? chapter;
  final int totalChapters;
  final Color? color;
  const ReadingProgressIndicator(
      {required super.key,
      required this.chapter,
      required this.totalChapters,
      required this.color});

  @override
  Widget build(BuildContext context) {
    Color color = this.color ??
        Part.maybeOf(context)?.primary.sc ??
        const Color(0xffffffff);
    late final double pct;
    if (chapter != null) {
      pct = chapter! / totalChapters;
    } else {
      pct = 1;
      //Error color
      color = const Color(0x40000000);
    }
    String pctTooltip = (pct * 100).toStringAsPrecision(2);
    return SizedBox(
        width: 36,
        height: 36,
        child: Tooltip(
            message: '$pctTooltip%',
            child: CustomPaint(
                key: const Key('progressPaint'),
                painter: _ProgressPainter(pct, color: color))));
  }
}

class _ProgressPainter extends CustomPainter {
  final Color color;
  final double pct;
  const _ProgressPainter(this.pct, {required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    //
    double dim = math.min(size.width, size.height);
    //Center
    Rect rect = Rect.fromLTWH(
        (size.width - dim) / 2, (size.height - dim) / 2, dim, dim);
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawArc(rect, math.pi * 3 / 2, (pct) * math.pi * (2), true, paint);

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    //Outline
    canvas.drawCircle(rect.center, dim / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _ProgressPainter) {
      return oldDelegate.pct != pct || color != oldDelegate.color;
    }
    return true;
  }
}
