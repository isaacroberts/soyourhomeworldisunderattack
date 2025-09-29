import 'dart:ui' as ui;

import 'package:flutter/material.dart';

ui.FragmentShader? landShader;
bool fragLoadCalled = false;

Future<ui.FragmentShader?> loadFragLandShader() async {
  if (landShader != null) {
    return landShader;
  }
  if (fragLoadCalled) {
    return null;
  }
  fragLoadCalled = true;
  var program =
      await ui.FragmentProgram.fromAsset('shaders/continents_land_only.frag');
  landShader = program.fragmentShader();
  return landShader;
}

class LandPainter extends CustomPainter {
  final double anim;
  LandPainter({required this.anim}) {
    loadFragLandShader();
  }

  void setShaderColor(int i, Color c) {
    landShader?.setFloat(i, c.r);
    landShader?.setFloat(i + 1, c.g);
    landShader?.setFloat(i + 2, c.b);
  }

  @override
  void paint(Canvas canvas, Size size) {
    const double seaStart = 0;
    // const double seaLength = .15;

    // ColorTweenSequence earthColor = ColorTweenSequence.fromColors(
    //     const [Color(0xff109552), Color(0xff015522), Color(0xff565656)]);

    //resolution
    const double scale = 1;
    landShader?.setFloat(0, scale * size.width);
    landShader?.setFloat(1, scale * size.height);
    //mouse?
    // double mouse = 0;
    // landShader?.setFloat(2, mouse);
    // landShader?.setFloat(3, mouse);

    //time
    landShader?.setFloat(4, .03 + anim / 10);

//Sea Color
    setShaderColor(5, const Color(0xffffffff));
    // setShaderColor(5, earthColor.transform(anim)!);
    // setShaderColor(11, smokeHeatColor);
    // setShaderColor(14, smokeTint);

    // Blue Earth BG
    if (anim > seaStart) {
      // double arcPos = math.min(1, (anim - seaStart) / seaLength);
      // arcPos = 1;

      Paint earthBg = Paint()..shader = landShader;

      double radius = size.width / 3;
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), radius, earthBg);

      // Rect earthRect = Rect.fromCenter(
      //     center: Offset(size.width / 2, size.height / 2),
      //     width: 2 * 12 * 12,
      //     height: 2 * 12 * 12);

      // canvas.drawArc(earthRect, -math.pi / 2 - arcPos * math.pi,
      //     arcPos * math.pi * 2, false, earthBg);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return anim < 3;
  }
}
