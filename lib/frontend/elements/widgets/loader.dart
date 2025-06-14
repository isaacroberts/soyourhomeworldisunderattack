import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

class _McKLoader extends StatefulWidget {
  const _McKLoader({super.key});

  @override
  State<_McKLoader> createState() => _McKLoaderState();
}

/*
    Animated 3 icons spinning.
    It did work decently and look pretty cool
    It wasn't the vibe at the time though.
 */

// const List<String> _icons = [
//   'circle_cross.svg',
//   'star_of_david.svg',
//   'anarchism.svg'
// ];
//
// const List<IconData> _iconDatum = [
//   RpgAwesome.anchor,
//   RpgAwesome.angel_wings,
//   RpgAwesome.all_for_one
// ];

//
class _McKLoaderState extends State<_McKLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 200,
        // color: Colors.blue,
        decoration: BoxDecoration(border: Border.all()),
        child: const Icon(
          RpgAwesome.bleeding_eye,
          size: 50,
          color: Colors.white,
        ));
  }
}

//ThreeRotatingDots from https://pub.dev/packages/loading_animation_widget

class TriWizardLoader extends StatefulWidget {
  final double size = 100;
  final Color color = Colors.white;

  const TriWizardLoader({
    super.key,
    // required this.color,
    // required this.size,
  });

  @override
  State<TriWizardLoader> createState() => _TriWizardLoaderState();
}

class _TriWizardLoaderState extends State<TriWizardLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static const int _duration = 833;

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

  int wrap(ix) => (ix + offset) % 3;

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double dotSize = size / 3;
    final double edgeOffset = (size - dotSize) / 2;

    // TODO: This needs to be changed so that ideally it's making a full rotation
    // and has 3 stops. That's something with tweens.

    const Interval firstDotsInterval = Interval(
      0,
      1,
      curve: Curves.easeInOut,
    );

    double dAngle = -2 * math.pi / 3;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, size / 12),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _BuildDot.first(
                color: color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: math.pi,
                endAngle: math.pi + dAngle,
                interval: firstDotsInterval,
                index: wrap(0),
              ),

              _BuildDot.first(
                color: color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: 5 * math.pi / 3,
                endAngle: 5 * math.pi / 3 + dAngle,
                interval: firstDotsInterval,
                index: wrap(1),
              ),

              _BuildDot.first(
                color: color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: 7 * math.pi / 3,
                endAngle: 7 * math.pi / 3 + dAngle,
                interval: firstDotsInterval,
                index: wrap(2),
              ),

              /// Next 3 dots
            ],
          ),
        ),
      ),
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
  final double dotOffset;
  final Color color;
  final double size;
  final bool first;
  final int index;

  const _BuildDot.first({
    super.key,
    required this.controller,
    required this.beginAngle,
    required this.endAngle,
    required this.interval,
    required this.dotOffset,
    required this.color,
    required this.size,
    required this.index,
  }) : first = true;

  const _BuildDot.second(
      {super.key,
      required this.controller,
      required this.beginAngle,
      required this.endAngle,
      required this.interval,
      required this.dotOffset,
      required this.color,
      required this.size,
      required this.index})
      : first = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: first
            ? controller.value <= interval.end
            : controller.value >= interval.begin,
        child: Transform.rotate(
          origin: Offset(0, -size * 1),
          angle: Tween<double>(
            begin: beginAngle,
            end: endAngle,
          )
              .animate(
                CurvedAnimation(parent: controller, curve: interval),
              )
              .value,
          child: Transform.rotate(
              angle: Tween<double>(
                begin: -beginAngle,
                end: -endAngle,
              )
                  .animate(CurvedAnimation(parent: controller, curve: interval))
                  .value,
              child: buildIcon()),
        ));
  }

  Widget buildIcon() {
    switch (index) {
      case 0:
        return Icon(
          Icons.public,
          size: size,
//0xff121318 121318
          color: const Color(0xff7866ff),
          // blendMode: BlendMode.plus,
        );

      case 1:
        return Icon(
          RpgAwesome.fire_symbol,
          size: size,
          color: const Color(0xff7867ff),
          // blendMode: BlendMode.plus,
        );

      case 2:
        return Icon(
          RpgAwesome.bleeding_eye,
          size: size,
          color: const Color(0xff7869ff),
          // blendMode: BlendMode.plus,
        );

      default:
        return Icon(
          RpgAwesome.burning_book,
          size: size,
        );
    }
  }
}
