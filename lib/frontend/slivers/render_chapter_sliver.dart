import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/heading_data.dart';

import '../../../../backend/chapter.dart';
import '../parts/part.dart';

const bool squashForever = true;

// const double maxGrowPerUpdate = 0;
// const double maxShrinkPerUpdate = 0;

const double maxGrowPerUpdate = 3;
const double maxShrinkPerUpdate = 2;

class RenderChapterSliver extends RenderProxySliver {
  /// The idea is that this sliver is moved through the tree
  /// ChapterSliver(key: Chapter5, pos: next)
  /// -> ChapterSliver(key: Chapter5, pos: current)

  Chapter chapter;
  ChapterMainCallback? onBecomesMain;
  Part part;

  ///Used to check whether it's moving so fast that we should skip loading
  // ScrollPosition position;

  RenderChapterSliver(
      {required this.chapter,
      required this.part,
      required this.onBecomesMain,
      this.height = 0});
  double scrollExtent = 0;

  double height = 0;
  double desiredHeight = 0;
  double overscroll = 0;

  //paintExtent
  double drawnHeight = 0;

  //I don't think slivers are allowed to change their maxPaintExtent
  static const double _maxPaintExtent = 20000;

  double get scrollOffset => constraints.scrollOffset;
  double get precedingScrollExtent => constraints.precedingScrollExtent;
  double get overlap => constraints.overlap;
  double get remainingPaintExtent => constraints.remainingPaintExtent;
  double get crossAxisExtent => constraints.crossAxisExtent;
  double get viewportMainAxisExtent => constraints.viewportMainAxisExtent;
  double get remainingCacheExtent => constraints.remainingCacheExtent;
  double get cacheOrigin => constraints.cacheOrigin;

  void loadIfStillInCacheRange() async {
    //Give it a quarter second to see if we're scrolling past
    await Future.delayed(const Duration(milliseconds: 250));
//Check if it's already been loaded (this will be spawned multiple times)
    if (chapter.needsLoad) {
//Check cacheExtent
      final double cacheExtent =
          calculateCacheOffset(constraints, from: 0.0, to: height);

      if (cacheExtent > 0) {
        chapter.load();
      }
    }
  }

  bool get wantsDifferentHeight => (desiredHeight - height).abs() > 1;

  @override
  void performLayout() {
    // if (belowScreen()) {
    if (height == 0) {
      height = viewportMainAxisExtent;
    }
    //   // dev.log("Below ${chapter.id}");
    //   offscreenLayout();
    // } else {
    performReaderLayout();
    // }
  }

  void performReaderLayout() {
    final double origHeight = height;

    SliverConstraints childConstraints = SliverConstraints(
        axisDirection: constraints.axisDirection,
        growthDirection: constraints.growthDirection,
        userScrollDirection: constraints.userScrollDirection,
        scrollOffset: constraints.scrollOffset,
        precedingScrollExtent: constraints.precedingScrollExtent,
        overlap: constraints.overlap,
        remainingPaintExtent: height,
        crossAxisExtent: constraints.crossAxisExtent,
        crossAxisDirection: constraints.crossAxisDirection,
        viewportMainAxisExtent: constraints.viewportMainAxisExtent,
        remainingCacheExtent: constraints.remainingCacheExtent,
        cacheOrigin: constraints.cacheOrigin);

    child!.layout(childConstraints, parentUsesSize: true);

    //Size to what child wants
    desiredHeight = child!.geometry!.maxPaintExtent;

    //Minimum size
    desiredHeight = math.max(desiredHeight, 360);

    if (!squashForever) {
      if (desiredHeight > height + 1) {
        //Grow with more abandon than shrinking
        if (touchingBottom() || belowScreen()) {
          height = desiredHeight;
        } else if (onScreen()) {
          //This, at the very least, will only expand while scrolling. TODO: Test whether it's wicked fast on profile mode
          height = math.min(desiredHeight, height + maxGrowPerUpdate);
        }
      } else if (desiredHeight < height - 1) {
        //Only shrink to
        if (belowScreen()) {
          height = desiredHeight;
        } else if (touchingBottom()) {
          // Clip to paintExtent
          double pixelsBelow =
              math.max(0, height - scrollOffset - viewportMainAxisExtent);
          //This prevents it from jumping up suddenly
          double maxExtent = height - pixelsBelow;
          height = math.max(maxExtent, desiredHeight);
          // height = desiredHeight;
        } else if (onScreen()) {
          //Shrink by a few pixels. It's fun
          height = math.max(desiredHeight, height - maxShrinkPerUpdate);
        }
      }
    }

    overscroll = math.max(0, desiredHeight - height);
    scrollExtent = overscroll + height;

    // final double paintedChildSize =
    //     calculatePaintOffset(constraints, from: 0, to: height);
    //Overscrolling
    final double paintedChildSize = calculateOverscrollPaintExtent(
        from: 0, to: height, overscroll: overscroll);

    //Save for draw layer
    drawnHeight = paintedChildSize;

    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: height);

    //If sliver within cache range
    if (cacheExtent > 0) {
      //If needs load
      if (chapter.needsLoad) {
        //Give it some time, to see if object is still in view, or it it's scrolling past
        loadIfStillInCacheRange();
      }
    }
    //Tell scaffold that its on screen

    if (onBecomesMain != null && halfOfScreen()) {
      onBecomesMain!(chapter);
    }

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);

    //TODO: Cache if within cache range

    geometry = SliverGeometry(
      scrollExtent: scrollExtent,
      paintExtent: paintedChildSize,
      // paintOrigin: overlap,
      layoutExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: _maxPaintExtent,
      hitTestExtent: paintedChildSize,
      visible: onScreen(),
      //TODO: !fillingScreen
      hasVisualOverflow: desiredHeight > height ||
          height > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );

    if (origHeight != height) {
      // dev.log("Chp${chapter.id} ${chapter.varName} $origHeight -> $height");
    }

    child!.parentData = SliverPhysicalParentData();
    // (child!.parentData as SliverPhysicalParentData).paintOffset =
    //     Offset(0, -y);
  }

  void offscreenLayout() {
    geometry = SliverGeometry(
      scrollExtent: viewportMainAxisExtent,
      paintExtent: 0,
      layoutExtent: 0,
      cacheExtent: 0,
      maxPaintExtent: _maxPaintExtent,
      visible: false,
      //TODO: !fillingScreen
      hasVisualOverflow: desiredHeight > height ||
          height > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
  }

  bool aboveScreen() {
    //Confirmed right
    return constraints.scrollOffset > height + overscroll;
  }

  bool onScreen() {
    return constraints.remainingPaintExtent > 0 && !aboveScreen();
  }

  bool fillingScreen() {
    //TODO: WRONG!
    //When the sliver is above the screen, this will be > viewportExtent
    return scrollOffset < height &&
        constraints.remainingPaintExtent >=
            constraints.viewportMainAxisExtent &&
        !aboveScreen();
  }

  bool belowScreen() {
    //Confirmed right
    return constraints.scrollOffset == 0 &&
        constraints.remainingPaintExtent == 0;
  }

  bool touchingBottom() {
    //Right
    return scrollOffset <= height - viewportMainAxisExtent &&
        remainingPaintExtent > 0 &&
        !aboveScreen();
  }

  bool halfOfScreen() {
    return drawnHeight > viewportMainAxisExtent * .66 &&
        drawnHeight > viewportMainAxisExtent - 100;
  }

  bool nearBottom(double range) {
    return scrollOffset <= height - viewportMainAxisExtent + range &&
        remainingPaintExtent > range &&
        !aboveScreen();
  }

  bool oob() {
    return false;
  }

  bool scrollingDown() {
    return constraints.userScrollDirection == ScrollDirection.reverse;
  }

  bool scrollingUp() {
    return constraints.userScrollDirection == ScrollDirection.forward;
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
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    assert(child == this.child);
    final SliverPhysicalParentData childParentData =
        child.parentData! as SliverPhysicalParentData;

    // if (drawFromBottom) {
    //   double pixelsBelow = height - desiredHeight;
    //
    //   transform.add(Matrix4.translationValues(0, -pixelsBelow, 0));
    // }
    childParentData.applyPaintTransform(transform);
  }

  Rect calculateClipRect() {
    // double drawnHeight =
    // calculatePaintOffset(constraints, from: 0, to: height);
    return Rect.fromLTWH(0, math.max(0, geometry!.paintOrigin),
        constraints.crossAxisExtent, drawnHeight);
  }

  bool get drawFromBottom =>
      wantsDifferentHeight && onScreen() && !touchingBottom();

  @override
  double childMainAxisPosition(covariant RenderObject child) {
    return desiredHeight - height;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    } else {
      Rect rect = calculateClipRect();

      //Fill BG to remove transparency
      if (onScreen()) {
        Paint bg = Paint()..color = part.canvasColor;
        context.canvas
            .drawRect(offset & Size(crossAxisExtent, drawnHeight), bg);
      }
      if (isRepaintBoundary) {
        //This won't clip
        context.paintChild(child!, offset);
      } else {
        layer = context.pushClipRect(
          true,
          offset,
          rect,
          (context, offset) {
            //This allows animations
            context.paintChild(child!, offset);
          },
        );
      }
/*
      if (squashForever) {
        //Fill gutter below page
        if (desiredHeight < height) {
          Paint bg = Paint()..color = part.primary.s1;
          Rect gutter = Rect.fromLTRB(0, offset.dy + desiredHeight,
              crossAxisExtent, offset.dy + height);
          context.canvas.drawRect(gutter.intersect(rect), bg);
        }
      }
*/
      if (!squashForever) {
        //Halo to show extra content
        if ((desiredHeight > height)) {
          //White = text clipped

          drawHalo(context,
              offset: offset, start: part.underflowHalo.withAlpha(50));
        }

        //Dark halo to show it wants to shorten
        if ((desiredHeight < height)) {
          drawHalo(context, offset: offset, start: part.primary.s1);
        }
      }
    }
  }

  void drawHalo(PaintingContext context,
      {required Offset offset, required Color start}) {
    double drawLine = offset.dy + drawnHeight;
    //Halo shrinks as it gets closer
    final double haloHeight = math.min(72, (desiredHeight - height).abs());
    if (haloHeight <= 0) {
      return;
    }
    //Don't draw along bottom
    if (!touchingBottom()) {
      Paint grad = Paint()
        ..shader = ui.Gradient.linear(
            Offset(0, drawLine - haloHeight),
            Offset(0, drawLine),
            [start.withAlpha(0), start.withAlpha(128), start],
            [0, .75, 1]);
      context.canvas.drawRect(
          Rect.fromLTRB(0, drawLine - haloHeight, crossAxisExtent, drawLine),
          grad);
    } else {
      double offset = height - scrollOffset - viewportMainAxisExtent;
      //Draw overlap below screen
      // double offset = -remainingPaintExtent + height;
      //If overlap < 100px
      if (offset < haloHeight) {
        //Shift drawn line
        double bot = drawLine + offset;
        double top = drawLine + offset - haloHeight;

        Paint grad = Paint()
          ..shader = ui.Gradient.linear(Offset(0, top), Offset(0, bot),
              [start.withAlpha(0), start.withAlpha(128), start], [0, .75, 1]);
        context.canvas
            .drawRect(Rect.fromLTRB(0, top, crossAxisExtent, bot), grad);
      }
    }
  }

  // =========== Boilerplate =============
  @override
  ui.Rect get semanticBounds => calculateClipRect();
  // @override // TODO: implement alwaysNeedsCompositing
  // bool get alwaysNeedsCompositing => true;
  @override
  bool hitTestChildren(SliverHitTestResult result,
      {required double mainAxisPosition, required double crossAxisPosition}) {
    Rect clipRect = calculateClipRect();
    return child != null &&
        child!.geometry!.hitTestExtent > 0 &&
        mainAxisPosition > (geometry!.paintOrigin) &&
        mainAxisPosition < (geometry!.paintOrigin + clipRect.height) &&
        child!.hitTest(
          result,
          mainAxisPosition: mainAxisPosition,
          crossAxisPosition: crossAxisPosition,
        );
  }

  @override
  bool hitTestSelf(
      {required double mainAxisPosition, required double crossAxisPosition}) {
    //TODO: If user clicks on halo
    // if (desiredHeight < height) {
    //   dev.log("Clicked: $mainAxisPosition");
    //
    //   dev.log("Height ready to expand");
    //   if (mainAxisPosition > height - 100) {
    //     //Expand
    //     height = desiredHeight;
    //     markNeedsLayout();
    //     markNeedsPaint();
    //     return true;
    //   }
    // }
    return false;
  }

  @override
  bool paintsChild(covariant RenderObject child) {
    return onScreen();
  }

  @override
  double childCrossAxisPosition(covariant RenderObject child) {
    return 0;
  }

  @override
  ui.Size getAbsoluteSize() {
    return ui.Size(crossAxisExtent, height);
  }

  // @override
  // ui.Rect get paintBounds => calculateClipRect();

  @override
  double? childScrollOffset(covariant RenderObject child) {
    return 0;
  }

  void copyChapter() {
    chapter.data?.copyText();
  }

  @override
  //Ensures accessibility I think
  bool get ensureSemantics => true;

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.headingLevel = 1;
    config.isReadOnly = true;
    //Americans only
    //I guess this may fuck up the hebrew
    config.textDirection = TextDirection.ltr;
    // config.textSelection = TextSelection.(baseOffset: baseOffset, extentOffset: extentOffset)
    config.label = 'Chapter ${chapter.varName}';
    config.onCopy = copyChapter;
    config.onCut = copyChapter;
  }

  @override // TODO: implement alwaysNeedsCompositing
  bool get alwaysNeedsCompositing => child?.alwaysNeedsCompositing ?? false;
  @override
  // TODO: implement needsCompositing
  bool get needsCompositing => child?.needsCompositing ?? false;

  @override
  //Must be false - otherwise the repaintBoundary throws assertions on Clip
  bool get isRepaintBoundary => false;

  @override
  void reassemble() {
    //Marks as needing a total relayout
    // height = 0;
    desiredHeight = 0;
    // scrollExtent = 0;
    drawnHeight = 0;
    super.reassemble();
  }

  @override
  void adoptChild(RenderObject child) {
    desiredHeight = 0;
    drawnHeight = 0;
    super.adoptChild(child);
  }

  @override
  void dropChild(RenderObject child) {
    desiredHeight = 0;
    drawnHeight = 0;
    super.dropChild(child);
  }
}
