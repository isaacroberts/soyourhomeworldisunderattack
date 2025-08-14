import 'dart:ui';

import 'package:flutter/material.dart';

class AppBarSizeDriver extends StatefulWidget {
  /// Shows second row when FlexibleSpace expands
  /// Unused
  const AppBarSizeDriver({
    super.key,
    required this.minExtent,
    required this.maxExtent,
    required this.builder,
  });

  final Widget Function(BuildContext context, Animation<double> anim) builder;
  final double minExtent;
  final double maxExtent;

  @override
  State<AppBarSizeDriver> createState() => _AppBarSizeDriverState();
}

class _AppBarSizeDriverState extends State<AppBarSizeDriver>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        value: 1, vsync: this, duration: const Duration(milliseconds: 30));
    super.initState();
  }

  @override
  void dispose() {
    animationController.stop(canceled: true);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(key: const Key("AppBarLayout"), builder: builder);
  }

  Widget builder(BuildContext context, BoxConstraints constraints) {
    final double deltaExtent = widget.maxExtent - widget.minExtent;

    double currentExtent = constraints.maxHeight;

    // 1.0 -> Expanded
    // 0.0 -> Collapsed to toolbar
    final double t = 1 -
        clampDouble(
          1.0 - (currentExtent - widget.minExtent) / deltaExtent,
          0.0,
          1.0,
        );

    animationController.animateTo(t,
        duration: const Duration(milliseconds: 120));
    return widget.builder(context, animationController.view);
  }
}
