import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/base_colors.dart';

import '../../../backend/utils.dart';
import '../../parts/noir_colors.dart';

const Color begin = Color(0x8afad906);
// const Color charcoal = Color(0x5a121212);
// const Color ash = Color(0xff6A6A6A);
const Color dirt = Color(0xff432a18);

const Color midColor = Color(0xff054e07);
const Color brighter = Color(0xff056112);

const Color end = Color(0xff027c12);
final TweenSequence<Color?> tween = TweenSequence<Color?>([
  TweenSequenceItem(tween: ColorTween(begin: begin, end: dirt), weight: .15),
  // TweenSequenceItem(tween: ColorTween(begin: charcoal, end: ash), weight: .05),
  TweenSequenceItem(tween: ColorTween(begin: dirt, end: midColor), weight: .15),
  TweenSequenceItem(
      tween: ColorTween(begin: midColor, end: brighter), weight: .15),
  TweenSequenceItem(tween: ColorTween(begin: brighter, end: end), weight: .6),
]);

class SplashPainter extends CustomPainter {
  final List<Offset> points;
  final double anim;
  SplashPainter({required this.points, required this.anim});

  Color greenLines(double colorPt) {
    return tween.transform(colorPt) ?? Colors.transparent;

/*
    Color charcoal = const Color(0xff053507);

    Color midColor = const Color(0xff053507);
    if (colorPt < .25) {
      return Color.lerp(const Color(0x66fad906), charcoal, colorPt * 2)!;
    }
      else if (colorPt < .5) {
      return Color.lerp( charcoal, midColor, colorPt * 2)!;

    } else {
      return Color.lerp(midColor, const Color(0xff027c12), (colorPt - .5) * 2)!;
    }

 */
  }

  @override
  void paint(Canvas canvas, Size size) {
    const double seaStart = .25;
    const double seaLength = .75;
    // dev.log("Painting");
    double colorPt = math.min(1, anim * 2 / 3);

    Color sky =
        Color.lerp(const Color(0xffc12121), const Color(0xFF1C1C43), colorPt)!;
    //canvasColor = 0xFF060615
    Color sunset =
        Color.lerp(const Color(0xfff6900a), const Color(0xFF060615), colorPt)!;
    Color lines = greenLines(colorPt);
    //0xff192d7c
    Color earthColor = Color.lerp(NoirPrimary.shade2, const Color(0xFF1D1D67),
        math.min(1, math.max(0, (anim - seaStart) / (seaLength))))!;

    Paint bg = Paint()
      ..blendMode = BlendMode.src
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(0, size.height),
        [sky, sunset],
      );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Blue Earth BG
    if (anim > seaStart) {
      double arcPos = math.min(1, (anim - seaStart) / seaLength);

      Paint earthBg = Paint()..color = earthColor;
      Rect earthRect = Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: 400,
          height: 400);

      canvas.drawArc(earthRect, -math.pi / 2 - arcPos * math.pi,
          arcPos * math.pi * 2, false, earthBg);
    }

    double stroke =
        math.max(1, math.min(5, (anim - (seaStart + seaLength)) * 200));
    stroke = 2;
    //Draw all together
    Paint paint = Paint()
      ..color = lines
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.bevel;

    canvas.drawPoints(ui.PointMode.lines, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return anim < 3;
  }
}

class FirePainter extends CustomPainter {
  final double anim;
  final int flameCt;

  //flameCt = 4 + math.max(0, (anim - 2) * 2).round();

  FirePainter({required this.anim, required this.flameCt});

  @override
  void paint(Canvas canvas, Size size) {
    if (anim < 0 || flameCt <= 0) {
      return;
    }
    Offset center = Offset(size.width / 2, size.height / 2);

    double fireCreep = math.min(1, math.max(0, math.sqrt(anim) * 1));
    Paint firePaint = Paint()..color = planColor;
    for (int n = 0; n < flameCt; ++n) {
      double angle = (rNG.nextDouble() - .5);
      // angle = (n * .2 - .5);
      double fAngle = -(angle - .5) * math.pi;
      double wScale = 1;
      double width = (.2 + n / 6) * 500 * fireCreep * wScale;
      double height = (.1 + n / 7) * 500 * fireCreep;

      double flameWidth = (rNG.nextDouble()) * math.pi / 2;
      // if (lastFrame) {
      //   flameWidth /= 4;
      // }
      double cx = 0; //(rNG.nextDouble() - .5) * 1;
      double cy = 200;
      Rect rect = Rect.fromCenter(
          center: center +
              Offset(cx - width * math.cos(fAngle) / 2,
                  cy - height * math.sin(fAngle) / 2),
          width: width,
          height: height);

      // flameWidth = .2 + anim * .4;

      canvas.drawArc(rect, fAngle, flameWidth, true, firePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //The point of the fire is that it's flickering
    return true;
  }
}
