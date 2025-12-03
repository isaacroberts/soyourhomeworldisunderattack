import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../parts/grand_swatch.dart';
import '../../parts/part.dart';

//ThreeRotatingDots from https://pub.dev/packages/loading_animation_widget

class SizedTriWizardLoader extends StatelessWidget {
  const SizedTriWizardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const TriWizardLoader(
      key: Key('ldr'),
      message: null,
    );
    return const SizedBox(
        key: Key('sisizezedLdr'),
        height: loaderSize,
        child: TriWizardLoader(
          key: Key('ldr'),
          message: null,
        ));
  }
}

const double loaderSize = 50;
const double dotSize = 33 * 2;
const double edgeOffset = 0; //(loaderSize - dotSize) / 2;

class TriWizardLoader extends StatelessWidget {
  final String? message;
  final Color? loaderColor;
  final Color? textColor;
  const TriWizardLoader(
      {super.key, required this.message, this.loaderColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    Part? part = Part.maybeOf(context);
    ThemeData theme = Theme.of(context);

    Color? bg = part?.primary.s1;
    Color loaderColor =
        this.loaderColor ?? part?.primary.sd ?? theme.colorScheme.primary;
    Color textColor = this.textColor ??
        part?.primary.sc ??
        theme.textTheme.labelLarge?.color ??
        theme!.colorScheme.onSurface;
    late Widget child;
    if (message == null) {
      child = _TriWizardLoader(
        loaderColor: loaderColor,
        key: const Key("Loader"),
      );
    } else {
      child = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: dotSize * 2 / 3),
                child: _TriWizardLoader(
                  loaderColor: loaderColor,
                  key: const Key("Loader"),
                )),
            Text(
              ' ${message!}  ',
              style: theme.textTheme.bodyLarge?.copyWith(color: textColor),
              textAlign: TextAlign.center,
            )
          ]);
    }
    child = Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(12),
        child: child);
    return child;
  }
}

class NoMessageTriWizardLoader extends StatelessWidget {
  final Color? loaderColor;
  final Color? textColor;
  const NoMessageTriWizardLoader({super.key, this.loaderColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    Color loaderColor =
        this.loaderColor ?? Theme.of(context).colorScheme.primary;

    return Center(
        child: _TriWizardLoader(
      loaderColor: loaderColor,
      key: const Key("Loader"),
    ));
  }
}

class _TriWizardLoader extends StatefulWidget {
  final Color loaderColor;

  const _TriWizardLoader({super.key, required this.loaderColor});

  @override
  State<_TriWizardLoader> createState() => _TriWizardLoaderState();
}

class SlamCurve extends Curve {
  const SlamCurve();
  @override
  double transform(double t) {
    return -math.sin(t * math.pi * 2) -
        .24 * math.sin(t * math.pi * 4) -
        .08 * math.sin(t * math.pi * 8);
    // t *= 2;
    // if (t >= 1) {
    //   return 1;
    // }
    // return t;
  }
}

class _TriWizardLoaderState extends State<_TriWizardLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static const int _duration = 2 * 930;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _duration),
    )..repeat();
    // _animationController.addListener(animListener);
  }

  // void animListener() {
  //   if (_animationController.lastElapsedDuration?.inMilliseconds < lastMs) {}
  // }

  int get offset =>
      ((_animationController.lastElapsedDuration?.inMilliseconds ?? 0) /
              (_duration))
          .floor();

  //The sign must be flipped when dAngle is
  int wrap(ix) => (ix - offset) % 3;

  @override
  Widget build(BuildContext context) {
    const double pi = 3.1415926535897932384;

    const Interval firstDotsInterval = Interval(
      0, 1,
      // curve: Curves.linear
      // curve: Curves.linear
      // curve: Curves.slowMiddle,
      curve: SlamCurve(),
      // curve: Curves.ease,
    );

    const double dAngle = 2 * pi / 3;
    math.sin;
    return SizedBox(
      width: loaderSize + 24,
      height: loaderSize + 24,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            // double whorl =
            //     -.333 * math.sin(_animationController.value * math.pi * 2);
            const double whorl = 0; //math.pi + math.pi * 2 / 3;
            return Transform.translate(
              offset: const Offset(dotSize / 2, loaderSize - 12),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _BuildDot.first(
                    key: const Key("Dot1"),
                    color: widget.loaderColor,
                    controller: _animationController,
                    beginAngle: pi + whorl,
                    endAngle: pi + dAngle + whorl,
                    interval: firstDotsInterval,
                    index: wrap(0),
                  ),
                  _BuildDot.first(
                    key: const Key("Dot2"),
                    color: widget.loaderColor,
                    controller: _animationController,
                    beginAngle: 5 * pi / 3 + whorl,
                    endAngle: 5 * pi / 3 + dAngle + whorl,
                    interval: firstDotsInterval,
                    index: wrap(1),
                  ),
                  _BuildDot.first(
                    key: const Key("Dot3"),
                    color: widget.loaderColor,
                    controller: _animationController,
                    beginAngle: 7 * pi / 3 + whorl,
                    endAngle: 7 * pi / 3 + dAngle + whorl,
                    interval: firstDotsInterval,
                    index: wrap(2),
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _BuildDot extends StatelessWidget {
  final AnimationController controller;
  final double beginAngle;
  final double endAngle;
  final Interval interval;
  final Color color;
  final int index;

  const _BuildDot.first({
    super.key,
    required this.controller,
    required this.beginAngle,
    required this.endAngle,
    required this.interval,
    required this.color,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    GrandSwatch? primary = Part.maybeOf(context)?.primary;

    return Transform.rotate(
      origin: const Offset(0, -loaderSize * 1),
      alignment: const Alignment(0, -1),
      angle: Tween<double>(
        begin: beginAngle,
        end: endAngle,
      )
          .animate(
            CurvedAnimation(parent: controller, curve: interval),
          )
          .value,
      child: Transform.rotate(
          alignment: const Alignment(0, -1),
          angle: Tween<double>(
            begin: -beginAngle,
            end: -endAngle,
          ).animate(CurvedAnimation(parent: controller, curve: interval)).value,
          child: Container(
              width: dotSize * .75,
              height: dotSize * .75,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary?.s9,
                  border:
                      Border.all(color: primary?.sd ?? Colors.black, width: 1),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-6, 12),
                        color: primary?.s1 ?? Color(0xff000000),
                        spreadRadius: 0,
                        blurRadius: 0)
                  ]),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              alignment: Alignment.center,
              child: getIcon(context))),
    );
  }

  Widget getIcon(BuildContext context) {
    //The RpgAwesome icons take too long to register visually.
    //Normally, the user only sees the icon for a fraction of a second.
    // RpgAwesome.burning_book
    // RpgAwesome.fire_symbol,
    // RpgAwesome.bleeding_eye,
    GrandSwatch? primary = Part.maybeOf(context)?.primary;
    // GrandSwatch? primary;
    switch (index) {
      case 0:
        // return Symbols.houseboat;
        // return Symbols.vpn_lock;
        return Icon(Symbols.globe, size: dotSize / 2, color: color);
      case 1:
        return Icon(Symbols.mode_heat,
            fill: 0, size: dotSize * 1 / 2, color: color);
        return Icon(Symbols.houseboat, size: dotSize, color: color);
        // return Symbols.crisis_alert;
        return Icon(Symbols.e911_emergency_rounded,
            size: dotSize, color: color);
      default:
        // return Symbols.houseboat;
        // return Symbols.mode_fan_off_sharp;
        // return Symbols.mode_h
        // return Symbols.rocket;
        return Icon(Symbols.security, size: dotSize * 1.1 / 2, color: color);

        return Icon(Symbols.productivity, size: dotSize, color: color);
        return Icon(Symbols.sword_rose, size: dotSize, color: color);
    }
  }
}
