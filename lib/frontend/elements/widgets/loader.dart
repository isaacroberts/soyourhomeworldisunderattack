import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

//ThreeRotatingDots from https://pub.dev/packages/loading_animation_widget

class TriWizardLoader extends StatefulWidget {
  static const double size = 100;
  static const Color color = Colors.white;
  final String? text;

  const TriWizardLoader({super.key, required this.text});

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
    const double dotSize = TriWizardLoader.size / 3;
    const double edgeOffset = (TriWizardLoader.size - dotSize) / 2;
    const double pi = 3.1415926535897932384;

    // TODO: This needs to be changed so that ideally it's making a full rotation
    // and has 3 stops. That's something with tweens.

    const Interval firstDotsInterval = Interval(
      0,
      1,
      curve: Curves.easeInOut,
    );

    const double dAngle = -2 * pi / 3;

    return SizedBox(
      width: TriWizardLoader.size,
      height: TriWizardLoader.size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Transform.translate(
          offset: const Offset(0, TriWizardLoader.size / 12),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _BuildDot.first(
                key: const Key("Dot1"),
                color: TriWizardLoader.color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: pi,
                endAngle: pi + dAngle,
                interval: firstDotsInterval,
                index: wrap(0),
              ),

              _BuildDot.first(
                key: const Key("Dot2"),
                color: TriWizardLoader.color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: 5 * pi / 3,
                endAngle: 5 * pi / 3 + dAngle,
                interval: firstDotsInterval,
                index: wrap(1),
              ),

              _BuildDot.first(
                key: const Key("Dot3"),
                color: TriWizardLoader.color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: 7 * pi / 3,
                endAngle: 7 * pi / 3 + dAngle,
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
