import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

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
    animationController.animateTo(1, duration: const Duration(seconds: 60));
    super.initState();
    points = getPoints();
    vels = List.generate(points.length, (i) => _Vel.rand());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  static const int pointAmt = 64;
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
              anim: animationController.value * 3,
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
      double angle = rNG.nextDouble() * math.pi * 2;

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
  _SplashPainter(
      {required this.points, required this.anim, required this.isDone});

  Color greenLines(double colorPt) {
    Color midColor = const Color(0xff06aa0e);
    if (colorPt < .5) {
      return Color.lerp(const Color(0xfffad906), midColor, colorPt * 2)!;
    } else {
      return Color.lerp(midColor, const Color(0xff027c12), (colorPt - .5) * 2)!;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawColor(const Color(0xff183151), BlendMode.src);
    // canvas.drawColor(harveyDarkColor, BlendMode.src);
    const double seaStart = .25;
    const double seaLength = .75;

    double colorPt = math.min(1, anim * 2 / 3);

    Color sky =
        Color.lerp(const Color(0xffc12121), const Color(0xFF1C1C43), colorPt)!;
    //0xff17324f
    //canvasColor = 0xFF060615
    Color sunset =
        Color.lerp(const Color(0xfff6900a), const Color(0xFF060615), colorPt)!;
    Color lines = greenLines(colorPt);
    //0xff192d7c
    Color earthColor = Color.lerp(primary, const Color(0xFF1D1D67),
        math.min(1, math.max(0, (anim - seaStart) / (seaLength))))!;

    Paint bg = Paint()
      ..blendMode = BlendMode.src
      // ..color = HarveyColor.shade4
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
    stroke = 1;
    //Draw all together
    Paint paint = Paint()
      // ..color = const Color(0xffffffff)
      ..color = lines
      // ..color = const Color(0xff268318)
      ..strokeWidth = stroke

      // ..blendMode = BlendMode.color
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPoints(ui.PointMode.lines, points, paint);

    drawFire(canvas, size, true);
  }

  void drawFire(Canvas canvas, Size size, bool front) {
    Offset center = Offset(size.width / 2, size.height / 2);

    //TODO: Get this to continue after the rest of the animation stops

    double fireStart = 1;
    double fireCreep =
        math.min(1, math.max(0, math.sqrt(anim - fireStart) * 1));
    if (anim > fireStart) {
      Paint firePaint = Paint()..color = planColor;
      // dev.log("Anim: $anim");
      bool lastFrame = anim >= 2.95;
      int flameCt = 4 + math.max(0, (anim - 2) * 2).round();
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
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
      : dx = rNG.nextDouble() * 2 - 1,
        dy = rNG.nextDouble() * 2 - 1 {
    double nrm = _nrm(dx, dy);
    dx /= nrm;
    dy /= nrm;
  }
}
