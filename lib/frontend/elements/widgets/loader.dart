import 'package:flutter/material.dart';
// import 'package:soyourhomeworld/frontend/elements/widgets/deferred_icon.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

//ThreeRotatingDots from https://pub.dev/packages/loading_animation_widget

class SizedTriWizardLoader extends StatelessWidget {
  const SizedTriWizardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        key: Key('sizedLdr'),
        height: 300,
        child: TriWizardLoader(
          key: Key('ldr'),
          message: null,
        ));
  }
}

class TriWizardLoader extends StatelessWidget {
  final String? message;
  final Color? loaderColor;
  final Color? textColor;
  const TriWizardLoader(
      {super.key, required this.message, this.loaderColor, this.textColor});
  static const double size = 100;

  @override
  Widget build(BuildContext context) {
    Color loaderColor =
        this.loaderColor ?? Theme.of(context).colorScheme.primary;
    Color textColor = this.textColor ??
        Theme.of(context).textTheme.labelLarge?.color ??
        Theme.of(context).colorScheme.onSurface;

    if (message == null) {
      return Center(
          child: _TriWizardLoader(
        loaderColor: loaderColor,
        textColor: textColor,
        key: const Key("Loader"),
      ));
    } else {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            // const CircularProgressIndicator(),
            _TriWizardLoader(
              loaderColor: loaderColor,
              textColor: textColor,
              key: const Key("Loader"),
            ),
            Text(
              message!,
              textAlign: TextAlign.center,
            )
          ]));
    }
  }
}

class NoMessageTriWizardLoader extends StatelessWidget {
  final Color? loaderColor;
  final Color? textColor;
  const NoMessageTriWizardLoader({super.key, this.loaderColor, this.textColor});
  static const double size = 100;

  @override
  Widget build(BuildContext context) {
    Color loaderColor =
        this.loaderColor ?? Theme.of(context).colorScheme.primary;

    return Center(
        child: _TriWizardLoader(
      loaderColor: loaderColor,
      textColor: const Color(0xff000000),
      key: const Key("Loader"),
    ));
  }
}

class _TriWizardLoader extends StatefulWidget {
  final Color loaderColor;
  final Color textColor;

  const _TriWizardLoader(
      {super.key, required this.loaderColor, required this.textColor});

  @override
  State<_TriWizardLoader> createState() => _TriWizardLoaderState();
}

class _TriWizardLoaderState extends State<_TriWizardLoader>
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
                color: widget.loaderColor,
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
                color: widget.loaderColor,
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
                color: widget.loaderColor,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: 7 * pi / 3,
                endAngle: 7 * pi / 3 + dAngle,
                interval: firstDotsInterval,
                index: wrap(2),
              ),
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
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: controller.value <= interval.end,
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

  int getIconIndex() {
    switch (index) {
      case 0:
        //RpgAwesome.burning_book
        return 78;
      case 1:
        // RpgAwesome.fire_symbol,
        return 194;
      case 2:
        // RpgAwesome.bleeding_eye,
        return 51;
      default:
//RpgAwesome.fireball_sword
        return 196;
    }
  }

  Widget buildIcon() {
    // const Color color = Color(0xff7866ff);
    return Icon(
      RpgAwesome.values[getIconIndex()],
      size: size,
      color: color,
      // blendMode: BlendMode.plus,
    );
  }
}
