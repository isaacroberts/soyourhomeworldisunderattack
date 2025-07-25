import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/pages/title/splash_bg.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_copy.dart';

import '../../../backend/utils.dart';

class SplashBgWidget extends StatefulWidget {
  final double width;
  final double height;
  const SplashBgWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<SplashBgWidget> createState() => _SplashBgWidgetState();
}

class _SplashBgWidgetState extends State<SplashBgWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  static const double fireStart = .333333;

  late final List<Offset> points;
  late final List<_Vel> vels;

  late final timer;
  int flameCt = 4;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animationController.animateTo(1, duration: const Duration(seconds: 60));
    super.initState();
    points = getPoints();
    vels = List.generate(points.length, (i) => _Vel.rand());
    timer = Timer.periodic(const Duration(seconds: 1), timerCallback);
  }

  void timerCallback(Timer t) {
    if (animationController.value > fireStart) {
      setState(() {
        flameCt += 1;
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  static const int pointAmt = 128;
  List<Offset> getPoints() {
    List<Offset> points = [];
    for (int n = 0; n < pointAmt; n++) {
      double x = rNG.nextDouble();
      // x = math.sin(x);
      double y = rNG.nextDouble();
      // y = math.cos(y);
      double f = (x + y) * (x + y);
      x /= f;
      y /= f;
      x *= widget.width;
      y *= widget.height;
      points.add(Offset(x, y));
    }
    return points;
  }

  bool isPointDone(int i) {
    double rx = points[i].dx - widget.width / 2;
    double ry = points[i].dy - widget.height / 2;
    double dist = (rx * rx) + (ry * ry);
    // Virtual sqrt. 40000 = 200^2
    const double target = 40000;
    double dd = dist - target;
    //This 200 is an epsilon
    return dd.abs() < 200;
  }

  bool isDone() {
    for (int n = 0; n < points.length; ++n) {
      if (!isPointDone(n)) {
        return false;
      }
    }
    return true;
  }

  void modPoints() {
    for (int n = 0; n < points.length; ++n) {
      double kcx = points[n].dx - widget.width / 2;
      double kcy = points[n].dy - widget.height / 2;
      //LMAO - the vels aren't updating
      double dx = vels[n].dx;
      double dy = vels[n].dy;
      dx -= (kcx) * .005;
      dy -= (kcy) * .005;
      // vels[n].dx -= dx;
      // vels[n].dy -= dy;

      points[n] = Offset(points[n].dx + dx, points[n].dy + dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: animationController, builder: builder);
  }

  bool get fireShowing => animationController.value >= fireStart;

  void firePressed() {
    if (flameCt > 0 && flameCt < 20) {
      setState(() {
        flameCt -= 1;
      });
    }
  }

  void continueOn() {
    context.go('/scroll/1');
  }

  Widget builder(BuildContext builder, Widget? previous) {
    //TODO: You're supposed to do this off the graphics thread
    Size size = Size(widget.width, widget.height);
    Widget? button;
    if (flameCt == 0) {
      button = FilledButton(
          key: const Key('continueon'),
          onPressed: continueOn,
          child: const Text('Continue'));
    } else if (fireShowing) {
      button = FilledButton(
          key: const Key('putitout'),
          onPressed: firePressed,
          child: const Text('wtf put it out'));
    }
    // button ??= button = const FilledButton(
    //     key: const Key('blank'), onPressed: null, child: const Text('Blank'));
    Widget child = widget.width < 600
        ? TitleTextPhone(
            key: Key('TitlePhone${button == null ? '0' : '1'}'),
            size: size,
            child: button)
        : TitleTextWide(
            key: Key('TitleWide${button == null ? '0' : '1'}'),
            size: size,
            child: button);

    modPoints();
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRect(
          child: CustomPaint(
              size: Size(widget.width, widget.height),
              willChange: true,
              foregroundPainter: fireShowing
                  ? FirePainter(
                      anim: math.min(1, (animationController.value * 3) - 1),
                      flameCt: flameCt)
                  : null,
              painter: SplashPainter(
                points: points,
                anim: animationController.value * 3,
              ),
              child: child),
        ));
  }
}

class _Vel {
  double dx;
  double dy;
  _Vel()
      : dx = 0,
        dy = 0;
  _Vel.rand()
      : dx = rNG.nextDouble() * 2 - 1,
        dy = rNG.nextDouble() * 2 - 1 {
    double nrm = _nrm(dx, dy);
    dx /= nrm;
    dy /= nrm;
  }
}

double _nrm(double x, double y) {
  return math.sqrt((x * x) + (y * y));
}
