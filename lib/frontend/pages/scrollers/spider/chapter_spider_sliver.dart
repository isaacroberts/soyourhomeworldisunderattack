import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/spider_utils.dart';

import '../../../../backend/chapter_holder.dart';
import '../slivers/load_sliver.dart';

class ChapterSpiderSliver extends SingleChildRenderObjectWidget {
  final ChapterHolder? chapter;

  final double initialHeight;
  final SpiderPos spiderPos;

  const ChapterSpiderSliver({
    super.key,
    required this.chapter,
    required this.spiderPos,
    this.initialHeight = 0,
    required super.child,
  });

  @override
  RenderSliverSingleBoxAdapter createRenderObject(BuildContext context) =>
      RenderChapterSliver(chapter: chapter, height: initialHeight);

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderChapterSliver renderObject) {
    renderObject.spiderPos = spiderPos;
    super.updateRenderObject(context, renderObject);
  }
}

class RenderChapterSliver extends RenderSliverSingleBoxAdapter {
  /// The idea is that this sliver is moved through the tree
  /// ChapterSliver(key: Chapter5, pos: next)
  /// -> ChapterSLiver(key: Chapter5, pos: current)

  final ChapterHolder? chapter;

  SpiderPos spiderPos = SpiderPos.dead;
  // double height = 0;

  RenderChapterSliver({required this.chapter, this.height = 0}) {
    chapter?.startedStream?.then(onStreamComplete);
    // dev.log("New RenderChapterSliver: $isLoader");
  }

  void onStreamComplete(b) {
    markNeedsLayout();
  }

  bool loadCalled = false;

  //TODO: For stability, this should be duplicated to a variable
  bool get isLoader => chapter?.showLoader ?? true;
  double scrollExtent = 0;

  double height;
  double desiredHeight = 0;
  double scrollPct = 0;

  bool fullyExpanded = false;

  bool squash = true;
  // double get height => notifier.height;
  // set height(double s) => notifier.height = s;

  //I don't think slivers are allowed to change their maxPaintExtent
  static const double _maxPaintExtent = 20000;

  void performLoaderLayout() {
    final SliverConstraints constraints = this.constraints;

    double screenWidth = constraints.crossAxisExtent;
    double screenHeight = constraints.viewportMainAxisExtent;

    final double overscroll = screenHeight * .5;
    final double childExtent = screenHeight;

    final double paintedChildSize = calculateOverscrollPaintExtent(
        from: 0, to: constraints.remainingPaintExtent, overscroll: overscroll);

    BoxConstraints childConstraints =
        BoxConstraints.tightFor(width: screenWidth, height: loaderInsetHeight);
    child!.layout(childConstraints, parentUsesSize: false);

    height = screenHeight;
    scrollExtent = screenHeight + overscroll;
    desiredHeight = 0;

    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: screenHeight);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);

    geometry = SliverGeometry(
      scrollExtent: scrollExtent,
      paintExtent: paintedChildSize,
      layoutExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: _maxPaintExtent,
      maxScrollObstructionExtent: childExtent + overscroll,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: loaderInsetHeight > constraints.remainingPaintExtent ||
          constraints.scrollOffset > -loaderInsetHeight,
    );
    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;

    childParentData.paintOffset = Offset(
        0.0,
        //Y Offset

        //TODO: This infinity could probably be refactored out
        math.min(
            //Ensures loader goes above screen
            constraints.scrollOffset <= 0
                //Allows loader below bottom of screen
                ? double.infinity
                : paintedChildSize - loaderInsetHeight,
            //Centers
            (
                    //Avaible space
                    math.max(paintedChildSize, loaderInsetHeight)
                        //Space taken
                        -
                        loaderInsetHeight)
                //Center
                /
                2));
  }

  void layoutAboveScreen() {
    final SliverConstraints constraints = this.constraints;

    double screenHeight = constraints.viewportMainAxisExtent;
    child!.layout(
        BoxConstraints(
            minHeight: 400,
            maxHeight: double.infinity,
            minWidth: constraints.crossAxisExtent,
            maxWidth: constraints.crossAxisExtent),
        parentUsesSize: true);
    desiredHeight = child!.size.height;

    if (!squash) {
      squash = true;
      //Preserve height
    }

    double overscroll = math.max(scrollExtent - height, 0);
    // dev.log("overscroll: $overscroll");
    final double paintedChildSize = calculateOverscrollPaintExtent(
        from: 0, to: height, overscroll: overscroll);

    if (constraints.scrollOffset <= 0) {
      //As widget scrolls up
      scrollPct = 0;
      //TODO: Incorporate height, making this pixel-scale-accurate
      // scrollPct = -1 + constraints.remainingPaintExtent / overscroll;
      // scrollPct = .25 * constraints.remainingPaintExtent / childExtent;
    } else if (constraints.scrollOffset < overscroll) {
      scrollPct = constraints.scrollOffset / overscroll;
    } else {
      //Finishes animating as sliver is halfway up screen
      // double passage = 1 - paintedChildSize / overscroll  ;
      scrollPct = 1;
    }
    // dev.log("ScrollPct: $scrollPct");

    // final double paintedChildSize =
    //     calculatePaintOffset(constraints, from: 0.0, to: height);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: height);

    // assert(paintedChildSize.isFinite);
    // assert(paintedChildSize >= 0.0);

    geometry = SliverGeometry(
      scrollExtent: scrollExtent,
      paintExtent: paintedChildSize,
      paintOrigin: 0,
      layoutExtent: paintedChildSize,

      // paintOrigin: -desiredHeight + height,
      // maxScrollObstructionExtent: scrollExtent,
      cacheExtent: cacheExtent,
      maxPaintExtent: _maxPaintExtent,
      // hitTestExtent: height,

      hasVisualOverflow: true,
      // hasVisualOverflow: height > constraints.remainingPaintExtent ||
      //     constraints.scrollOffset > 0.0,
    );
    //Aligns child along bottom

    // setChildParentData(child!, constraints, geometry!);
    // dev.log("Laid out squash");

    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;

    childParentData.paintOffset = Offset(
      0.0,
      -constraints.scrollOffset,
    );
    // childParentData
    //     .applyPaintTransform(Matrix4.translationValues(0, -missingPixels, 0));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null && geometry!.visible) {
      final SliverPhysicalParentData childParentData =
          child!.parentData! as SliverPhysicalParentData;
      if (squash && desiredHeight > height) {
        Offset pOffset = Offset(0,
            scrollPct * (-desiredHeight + height) - constraints.scrollOffset);
        // dev.log("Paint squashed @ Offset $pOffset");
        context.paintChild(child!, pOffset);
      } else {
        context.paintChild(child!, offset + childParentData.paintOffset);
      }
    }
  }

  void performReaderLayout() {
    final SliverConstraints constraints = this.constraints;
    if (squash) {
      squash = false;
      // dev.log("Squash off");
    }
    fullyExpanded = true;
    BoxConstraints childConstraints = BoxConstraints(
        minHeight: 400,
        maxHeight: double.infinity,
        minWidth: constraints.crossAxisExtent,
        maxWidth: constraints.crossAxisExtent);

    child!.layout(childConstraints, parentUsesSize: true);

    //Size to what child wants
    final double childExtent = child!.size.height;

    // dev.log("Widget sized to height: $childExtent");

    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    scrollExtent = childExtent;
    height = childExtent;
    desiredHeight = childExtent;

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);

    // dev.log("Layout: childExtent = $childExtent");
    geometry = SliverGeometry(
      scrollExtent: scrollExtent,
      paintExtent: paintedChildSize,
      layoutExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: _maxPaintExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);

    // dev.log("Laid out free");
  }

  @override
  void performLayout() {
    if (isLoader) {
      squash = false;
      // dev.log("Loader...");
      performLoaderLayout();
      return;
    } else {
      // double screenHeight = constraints.viewportMainAxisExtent;

      bool aboveScreen = constraints.scrollOffset > 0;

      // dev.log(
      //     "Scroll ${constraints.scrollOffset} Above=$aboveScreen this=$this");

      if (aboveScreen && !fullyExpanded) {
        //Squashes to fit current height, to prevent jumps
        return layoutAboveScreen();
      } else {
        //Lays out in full
        performReaderLayout();
      }
    }
  }

  double calculateOverscrollPaintExtent(
      {required double from, required double to, required double overscroll}) {
    //Overscroll algorithm
    final double a = constraints.scrollOffset;
    final double b =
        constraints.scrollOffset + constraints.remainingPaintExtent;
    // the clamp on the next line is to avoid floating point rounding errors
    return ui.clampDouble(
      ui.clampDouble(to + overscroll, a, b) - ui.clampDouble(from, a, b),
      0.0,
      constraints.remainingPaintExtent,
    );
  }

  @override
  bool get ensureSemantics => true;
}

class ChapterSliverParentData extends ParentData {}
