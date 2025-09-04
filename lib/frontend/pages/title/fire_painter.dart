import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../backend/utils.dart';

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
  // var program = await ui.FragmentProgram.fromAsset('shaders/earth_shader.frag');
  // shader = program.fragmentShader();
  return shader;
}

class FirePainter extends CustomPainter {
  final double anim;
  final int flameCt;

  //flameCt = 4 + math.max(0, (anim - 2) * 2).round();

  FirePainter({required this.anim, required this.flameCt}) {
    loadFragShader();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (anim < 0 || flameCt <= 0) {
      return;
    }
    Offset center = Offset(size.width / 2, size.height / 2);

    //resolution
    double scale = 1;
    shader?.setFloat(0, scale * size.width);
    shader?.setFloat(1, scale * size.height);
    //mouse?
    double mouse = 0;
    shader?.setFloat(2, mouse);
    shader?.setFloat(3, mouse);

    //time
    shader?.setFloat(4, anim * 500);

    //colorA
// NoirPrimary.shade3
    //0xff0f0d24
    shader?.setFloat(5, 0x0f / 255.0);
    shader?.setFloat(6, 0x0d / 255.0);
    shader?.setFloat(7, 0x24 / 255.0);

    double fireCreep = math.min(1, math.max(0, math.sqrt(anim) * 1));
    // Paint firePaint = Paint()
    //   ..color = planColor
    //   ..shader = shader;
    for (int n = 0; n < flameCt; ++n) {
      double angle = (rNG.nextDouble() - .5);
      // angle = (n * .2 - .5);
      double fAngle = -(angle - .5) * math.pi;
      double width = (.2 + n / 6) * 500 * fireCreep;
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

      // canvas.drawArc(rect, fAngle, flameWidth, true, firePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //The point of the fire is that it's flickering
    return true;
  }
}
