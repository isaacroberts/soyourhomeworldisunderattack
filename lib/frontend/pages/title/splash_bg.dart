import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../parts/noir_colors.dart';
import '../../theme/base_colors.dart';

ui.FragmentShader? shader;
bool fragLoadCalled = false;

Future<ui.FragmentShader?> loadFragShader() async {
  if (shader != null) {
    return shader;
  }
  if (fragLoadCalled) {
    return null;
  }
  fragLoadCalled = true;
  var program = await ui.FragmentProgram.fromAsset('shaders/clouds.frag');
  shader = program.fragmentShader();
  return shader;
}

class SplashPainter extends CustomPainter {
  final double anim;
  SplashPainter({required this.anim}) {
    loadFragShader();
  }

  void setShaderColor(int i, Color c) {
    shader?.setFloat(i, c.r);
    shader?.setFloat(i + 1, c.g);
    shader?.setFloat(i + 2, c.b);
  }

  @override
  void paint(Canvas canvas, Size size) {
    const double seaStart = .1;
    const double seaLength = .5;
    // dev.log("Painting");
    double topColorPt = ui.clampDouble(anim, 0, 1);
    double colorPt = ui.clampDouble((anim - seaStart - seaLength) * 2, 0, 1);

    var skyTween = const NoirPrimary().getColorTween(0xa, 3);
    Color sky = skyTween.transform(topColorPt)!;
    // Color sky = Color.lerp(NoirPrimary.shadea, NoirPrimary.shade2, colorPt)!;
    //canvasColor = 0xFF060615
    Color sunset =
        Color.lerp(const Color(0xffd5400a), Tertiary.shadee, colorPt)!;
    //0xff192d7c
    double earthColorPt =
        math.min(1, math.max(0, (anim - seaStart - seaLength) / (seaLength)));
    const Color earthColor = Color(0xff011aa1);
    // Color earthColor =
    //     Color.lerp(Color(0xff011aa1), NoirPrimary.shade4, earthColorPt)!;

    const Color smokeColor = Color(0xff87888a);

    const Color middleSmokeColor = Color(0xff6f7078);

    const Color smokeHeatColor = Color(0xffff5500);

    const Color smokeTint = NoirPrimary.shade5;
    //resolution
    const double scale = 1;
    shader?.setFloat(0, scale * size.width);
    shader?.setFloat(1, scale * size.height);
    //mouse?
    double mouse = 10;
    shader?.setFloat(2, mouse);
    shader?.setFloat(3, mouse);

    //time
    shader?.setFloat(4, 2000 + anim * 40);

//Sea Color
    setShaderColor(5, smokeColor);
    setShaderColor(8, middleSmokeColor);
    setShaderColor(11, smokeHeatColor);
    setShaderColor(14, smokeTint);

    Paint bg = Paint()
      // ..blendMode = BlendMode.
      ..shader = shader;
    // ..shader = ui.Gradient.linear(
    //   const Offset(0, 0),
    //   Offset(0, size.height),
    //   [sky, sunset],
    // );

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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return anim < 3;
  }
}
