import 'dart:ui' as ui;

import 'package:flutter/material.dart';

ui.FragmentShader? smokeShader;
bool fragLoadCalled = false;

Future<ui.FragmentShader?> loadFragShader() async {
  if (smokeShader != null) {
    return smokeShader;
  }
  if (fragLoadCalled) {
    return null;
  }
  fragLoadCalled = true;
  var program = await ui.FragmentProgram.fromAsset('shaders/clouds.frag');
  smokeShader = program.fragmentShader();
  return smokeShader;
}

class SmokePainter extends CustomPainter {
  final double anim;
  SmokePainter({required this.anim}) {
    loadFragShader();
  }

  void setShaderColor(int i, Color c) {
    smokeShader?.setFloat(i, c.r);
    smokeShader?.setFloat(i + 1, c.g);
    smokeShader?.setFloat(i + 2, c.b);
  }

  @override
  void paint(Canvas canvas, Size size) {
    const Color smokeColor = Color(0xff121212);

    const Color middleSmokeColor = Color(0xff484848);

    const Color smokeHeatColor = Color(0xffff5500);

    const Color smokeTint = Color(0xff000000);
    //resolution
    const double scale = 1;
    smokeShader?.setFloat(0, scale * size.width);
    smokeShader?.setFloat(1, scale * size.height);
    //mouse?
    // double mouse = 10;
    // smokeShader?.setFloat(2, mouse);
    // smokeShader?.setFloat(3, mouse);

    //time
    smokeShader?.setFloat(4, 2000 + anim * 40);

//Sea Color
    setShaderColor(5, smokeColor);
    setShaderColor(8, middleSmokeColor);
    setShaderColor(11, smokeHeatColor);
    setShaderColor(14, smokeTint);

    Paint bg = Paint()..shader = smokeShader;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SmokeBg extends StatefulWidget {
  final double width;
  final double height;
  const SmokeBg({
    required super.key,
    required this.width,
    required this.height,
  });

  @override
  State<SmokeBg> createState() => _SmokeBgState();
}

class _SmokeBgState extends State<SmokeBg> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        debugLabel: 'SmokeAnim',
        animationBehavior: AnimationBehavior.preserve,
        vsync: this);
    animationController.animateTo(1, duration: const Duration(seconds: 15));
    TweenSequence<double> tweens = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0, end: .333), weight: 1),
      TweenSequenceItem(tween: Tween(begin: .333, end: .666), weight: .1),
      // TweenSequenceItem(tween: Tween(begin: .666, end: 1), weight: 2)
    ]);

    animation = tweens.animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: AnimatedBuilder(
                key: const Key("TitleAnimBuilder"),
                animation: animationController,
                builder: builder)));
  }

  Widget builder(BuildContext builder, Widget? previous) {
    return CustomPaint(
        key: const Key("TitlePainter"),
        isComplex: false,
        size: Size(widget.width, widget.height),
        willChange: animationController.isAnimating,
        painter: SmokePainter(
          anim: animationController.value,
        ));
  }
}
