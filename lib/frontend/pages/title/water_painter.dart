import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../components/color_tween_sequence.dart';

ui.FragmentShader? waterShader;
bool fragLoadCalled = false;

Future<ui.FragmentShader?> loadFragWaterShader() async {
  if (waterShader != null) {
    return waterShader;
  }
  if (fragLoadCalled) {
    return null;
  }
  fragLoadCalled = true;
  var program = await ui.FragmentProgram.fromAsset('shaders/water_clouds.frag');
  waterShader = program.fragmentShader();
  return waterShader;
}

class WaterPainter extends CustomPainter {
  double anim;
  Stopwatch watch;
  WaterPainter({required this.anim}) : watch = Stopwatch();

  void setShaderColor(int i, Color c) {
    waterShader?.setFloat(i, c.r);
    waterShader?.setFloat(i + 1, c.g);
    waterShader?.setFloat(i + 2, c.b);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // if (!watch.isRunning) {
    //   watch.start();
    // } else {
    //   anim += watch.elapsedMilliseconds.toDouble() / 1000 * 60;
    //   watch.reset();
    // }

    //resolution
    waterShader?.setFloat(0, size.width);
    waterShader?.setFloat(1, size.width);

    //time
    waterShader?.setFloat(2, anim * 60);

    double colorPt = ui.clampDouble(anim * 4, 0, 1);

    ColorTweenSequence cloudColor = ColorTweenSequence.fromColors(const [
      // Color(0xff111032),
      // Color(0xff1d1a32),
      // Color(0xff212032),
      // Color(0xff212032),
      Color(0xfffffdf1),
      Color(0xfffffdf1),
      Color(0xff7a786c),
      Color(0xff532912),
    ]);

    ColorTweenSequence chemicalSpill = ColorTweenSequence.fromColors(const [
      // Color(0xff1177ff),
      // Color(0xff223344),
      Color(0x008f8f9c),
      Color(0xff8a969c),

      // Color(0xff515172),
      // Color(0xff9f5172),
      Color(0xff9c9306),
      Color(0xff9f5172),
      Color(0xff0aa3e4),
      Color(0xffe3ba86),
      Color(0xffe3ba86),
    ]);

    //Unused because we're doing color rotation
    ColorTweenSequence earthColor = ColorTweenSequence.fromColors(
        const [Color(0xff026031), Color(0xff26653f), Color(0xff565656)]);

    //Cloud color
    setShaderColor(3, cloudColor.transform(colorPt)!);
//Middle color
    setShaderColor(6, chemicalSpill.transform(colorPt)!);

    setShaderColor(9, earthColor.transform(colorPt)!);

    Paint earthBg = Paint()
      // ..color = Color(0xffab97cd)
      ..shader = waterShader;

    // double radius = size.width / 3;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), earthBg);
  }

  @override
  bool shouldRepaint(WaterPainter oldDelegate) {
    return true;
    //If timer advanced
    return anim > oldDelegate.anim ||
        //Or restarted
        (anim == 0 && oldDelegate.anim != 0);
  }
}

class WaterWrap extends StatelessWidget {
  // final WaterPainter painter;
  final AnimationController animation;

  const WaterWrap({super.key, required this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        key: const Key('animBuilder'), animation: animation, builder: builder);
  }

  Widget builder(BuildContext context, Widget? previous) {
    return CustomPaint(
        key: const Key('customPaint'),
        painter: WaterPainter(anim: animation.value),
        willChange: animation.isAnimating,
        isComplex: true);
  }
}
