import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/title/splash_bg.dart';

class SplashBgWidget extends StatefulWidget {
  final double width;
  final double height;
  const SplashBgWidget({
    required super.key,
    required this.width,
    required this.height,
  });

  @override
  State<SplashBgWidget> createState() => _SplashBgWidgetState();
}

class _SplashBgWidgetState extends State<SplashBgWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        debugLabel: 'TitleAnim',
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
        painter: SplashPainter(
          anim: animationController.value * 2,
        ));
  }
}
