import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../backend/utils.dart';
import '../../human_jack_theme.dart';
import '../custom_code/ad_widget.dart';

class HumanJackPartyStillGoing extends StatelessWidget {
  const HumanJackPartyStillGoing({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: CustomPaint(
            willChange: false,
            isComplex: true,
            painter: const RavePainter(),
            size: AdSize.banner.size,
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Human Jack",
                              style: humanJackTextTheme.labelMedium,
                            )),
                        Align(
                            alignment: Alignment.center,
                            child: Text("“This party's still going!”",
                                textAlign: TextAlign.center,
                                style: humanJackTextTheme.displayLarge
                                    ?.copyWith(
                                        color: const Color(0xffffffff)))),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "can hang.",
                              style: humanJackTextTheme.labelMedium,
                            )),
                      ],
                    )))));
  }
}

class RavePainter extends CustomPainter {
  static const Color c1 = Color(0xff771198);
  static const Color c2 = Color(0xff70229a);
  static const Color c3 = Color(0xffa733af);

  final int n;

  // final List<Offset> points;
  // final Color fore, bg;

  const RavePainter({this.n = 0
      // required this.points,
      // required this.fore,
      // required this.bg,
      });

  static Color getCN(int n) {
    if (n >= 3) {
      n %= 3;
    }
    switch (n) {
      case 0:
        return c1;
      case 1:
        return c2;
      case 2:
        return c3;
      default:
        return const Color(0xffff00ff);
    }
  }

  Offset randPoint(Size size) {
    return Offset(
        RNG.nextDouble() * size.width, RNG.nextDouble() * size.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    int n = RNG.nextInt(3);
    Color bg = getCN(n);
    Color spots = getCN(RNG.nextInt(3));

    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = bg);
    // canvas.drawColor(bg, BlendMode.src);

    Paint paint = Paint()
      ..color = spots
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    paint.imageFilter = ImageFilter.blur(sigmaY: 30, sigmaX: 30);

    // List<Offset> points = List.generate(3, (i) => randPoint(size));

    for (int m = 0; m < 3; ++m) {
      canvas.drawCircle(randPoint(size), 100, paint);
    }
    // canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
