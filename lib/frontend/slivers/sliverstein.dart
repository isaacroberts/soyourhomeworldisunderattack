import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class RenderSliverstein extends RenderSliverToBoxAdapter {
  double overscroll;

  double scrollPct = 0;

  RenderSliverstein({this.overscroll = 0});

  double updateOverscroll(double desiredExtent, double clampedExtent);

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);

    final double desiredExtent = switch (constraints.axis) {
      Axis.horizontal => child!.size.width,
      Axis.vertical => child!.size.height,
    };
    final double childExtent = clampHeight(desiredExtent);
    assert(childExtent <= desiredExtent);
    //Requested overscroll amount
    overscroll = updateOverscroll(desiredExtent, childExtent);
    assert(overscroll >= 0);
    //size from Overscroll
    final double paintedChildSize = _calculateOverscrollPaintExtent(
        from: 0, to: childExtent, overscroll: overscroll);

    final double cacheExtent = calculateCacheOffset(
      constraints,
      from: 0.0,
      to: childExtent,
    );

    final bool isVisible = constraints.remainingPaintExtent > 0;

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent + overscroll,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxScrollObstructionExtent: childExtent,
      maxPaintExtent: childExtent,
      crossAxisExtent: constraints.crossAxisExtent,
      hitTestExtent: paintedChildSize,
      visible: isVisible,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    //Who knows
    //If not, you need to copy & fix the rest from setChildParentData
    assert(constraints.axisDirection == AxisDirection.down);
    assert(constraints.growthDirection == GrowthDirection.forward);

    scrollPct = computeScrollPct();
    //Set paint offset
    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;
    childParentData.paintOffset = getChildPaintOffset();

    //set ScrollPt

    playWithScrollPct(scrollPct);
  }

  double computeScrollPct() {
    ///Entirely up to opinion, really
    if (overscroll == 0) {
      return 0;
    }
    if (constraints.scrollOffset <= 0) {
      //As widget scrolls up
      //TODO: Incorporate height, making this pixel-scale-accurate
      return -1 + constraints.remainingPaintExtent / overscroll;
      // scrollPct = .25 * constraints.remainingPaintExtent / childExtent;
    } else if (constraints.scrollOffset < overscroll) {
      return constraints.scrollOffset / overscroll;
    } else {
      //Finishes animating as sliver is halfway up screen
      return 1;
      // double passage = 1 - geometry!.paintExtent / overscroll;
      // return 1 + ui.clampDouble(passage, 0, 1);
    }
  }

  double clampHeight(double desiredHeight) {
    ///Must only go down
    return desiredHeight;
  }

  //For overriding
  void playWithScrollPct(double scrollPct) {
    //animationController.animateTo(scrollPct);
  }

  Offset getChildPaintOffset() {
    ///Decides where to draw
    ///The normal behavior:
    ///      x=0
    ///      y= min(0, -scrollOffset))
    ///
    /// Sliverstein behavior:
    ///      y = min(0, overscroll - scrollOffset),
    ///
    /// Parallax:
    ///     ???
    ///
    /// (constraints.scrollOffset )
    return Offset(
      0.0,
      math.min(0, overscroll - scrollOffset),
    );
  }

  double _calculateOverscrollPaintExtent(
      {required double from, required double to, required double overscroll}) {
    //Overscroll algorithm
    //This only works if its full size I think
    final double a = constraints.scrollOffset;
    final double b =
        constraints.scrollOffset + constraints.remainingPaintExtent;
    // the clamp on the next line is to avoid floating point rounding errors
    return ui.clampDouble(
      ui.clampDouble(to + overscroll, a, b) - ui.clampDouble(from, a, b),
      0.0,
      to,
    );
  }

  double get scrollOffset => constraints.scrollOffset;
  double get precedingScrollExtent => constraints.precedingScrollExtent;
  double get overlap => constraints.overlap;
  double get remainingPaintExtent => constraints.remainingPaintExtent;
  double get crossAxisExtent => constraints.crossAxisExtent;
  double get viewportMainAxisExtent => constraints.viewportMainAxisExtent;
  double get remainingCacheExtent => constraints.remainingCacheExtent;
  double get cacheOrigin => constraints.cacheOrigin;
}

class AnimatedSliverstein extends SliverToBoxAdapter {
  /// Drives some animation on the child widget
  final AnimationController animation;
  final double overscroll;
  const AnimatedSliverstein({
    super.key,
    required this.animation,
    this.overscroll = 1000,
    required super.child,
  });

  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) =>
      RenderAnimatedSliverstein(overscroll: overscroll, animation: animation);

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    if (renderObject is RenderAnimatedSliverstein) {
      renderObject.animation = animation;
    }
    super.updateRenderObject(context, renderObject);
  }
}

class RenderAnimatedSliverstein extends RenderSliverstein {
  AnimationController animation;

  RenderAnimatedSliverstein(
      {required super.overscroll, required this.animation});

  @override
  double updateOverscroll(d, h) {
    return overscroll;
  }

  @override
  void playWithScrollPct(double scrollPct) {
    animation.animateTo(scrollPct);
  }
}
