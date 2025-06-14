import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';

import '../../../backend/utils.dart';

class SplashBgWidget extends StatefulWidget {
  final Widget? child;
  final double width;
  final double height;
  const SplashBgWidget({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  State<SplashBgWidget> createState() => _SplashBgWidgetState();
}

class DoneSplashBgWidget extends StatefulWidget {
  final Widget? child;
  final double width;
  final double height;
  const DoneSplashBgWidget({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  State<DoneSplashBgWidget> createState() {
    return _DoneSplashBgWidgetState();
  }
}

class _SplashBgWidgetState extends State<SplashBgWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late final List<Offset> points;
  late final List<_Vel> vels;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animationController.animateTo(100, duration: const Duration(hours: 1));
    super.initState();

    points = getPoints();
    vels = List.generate(points.length, (i) => _Vel.rand());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  static const int pointAmt = 200;
  List<Offset> getPoints() {
    List<Offset> points = [];
    for (int n = 0; n < pointAmt; n++) {
      double x = RNG.nextDouble();
      // x = math.sin(x);
      double y = RNG.nextDouble();
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

      points[n] = Offset(points[n].dx + dx, points[n].dy + dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: animationController, builder: builder);
  }

  Widget builder(BuildContext builder, Widget? previous) {
    modPoints();
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRect(
            child: CustomPaint(
          size: Size(widget.width, widget.height),
          willChange: true,
          painter: _SplashPainter(
              points: points,
              anim: animationController.value,
              isDone: isDone()),
          child: widget.child,
        )));
  }
}

class _DoneSplashBgWidgetState extends State<DoneSplashBgWidget> {
  late final List<Offset> points;

  @override
  void initState() {
    super.initState();
    points = createDonePoints();
  }

  List<Offset> createDonePoints() {
    List<Offset> points = [];
    for (int n = 0; n < _SplashBgWidgetState.pointAmt; ++n) {
      double radius = 200;
      double angle = RNG.nextDouble() * math.pi * 2;

      double x = widget.width / 2 + radius * math.sin(angle);
      double y = widget.height / 2 + radius * math.cos(angle);

      points.add(Offset(x, y));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRect(
            child: CustomPaint(
          size: Size(widget.width, widget.height),
          willChange: true,
          painter: _SplashPainter(points: points, anim: 0, isDone: true),
          child: widget.child,
        )));
  }
}

class _SplashPainter extends CustomPainter {
  final List<Offset> points;
  final bool isDone;
  final double anim;
  const _SplashPainter(
      {required this.points, required this.anim, required this.isDone});

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawColor(const Color(0xff183151), BlendMode.src);
    canvas.drawColor(harveyDarkColor, BlendMode.src);

    //Draw all together
    Paint paint = Paint()
      // ..color = const Color(0xffffffff)
      ..color = rachelDarkColor
      // ..color = const Color(0xff268318)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPoints(PointMode.lines, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !isDone;
  }
}

double _nrm(double x, double y) {
  return math.sqrt((x * x) + (y * y));
}

class _Vel {
  double dx;
  double dy;
  _Vel()
      : dx = 0,
        dy = 0;
  _Vel.rand()
      : dx = RNG.nextDouble() * 2 - 1,
        dy = RNG.nextDouble() * 2 - 1 {
    double nrm = _nrm(dx, dy);
    dx /= nrm;
    dy /= nrm;
  }
}
