import 'package:flutter/material.dart';

const Duration _defaultDelay = Duration(milliseconds: 150);
const Duration _defaultDuration = Duration(milliseconds: 500);

class FadeIn extends StatefulWidget {
  ///Fades in widget once, after delay

  ///Widget to fade in
  final Widget child;
  final Duration delay;
  final Duration duration;
  const FadeIn({
    required super.key,
    //delay
    this.delay = _defaultDelay,
    //duration
    this.duration = _defaultDuration,
    //widget to fade in
    required this.child,
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
    Future.delayed(widget.delay, startAnimation);
  }

  void startAnimation() {
    controller.animateTo(1, duration: widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.isAnimating && controller.value >= 1) {
      return widget.child;
    } else {
      return FadeTransition(
          key: const Key('fade'),
          opacity: controller.view,
          child: widget.child);
    }
  }
}
