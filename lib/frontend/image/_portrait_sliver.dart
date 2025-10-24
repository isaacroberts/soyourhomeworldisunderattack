import 'dart:developer' as dev;
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:soyourhomeworld/frontend/image/image_buttons.dart';

import '../theme/layout_constants.dart';
import 'image_constants.dart';
import 'image_holder.dart';

class PortraitSliver extends StatelessWidget {
  ///This under-scroller is better for "vibe"
  ///images that don't mean anything, like the
  ///whiskey image.
  ///
  /// Images should be labelled in text as BG, and should be tall

  /// [==================]
  /// [                  ]
  /// [                  ]
  /// [    Tall!         ]
  /// [    Portrait!     ]
  /// [                  ]
  /// [                  ]
  /// [                  ]
  /// [                  ]
  /// [==================]
  const PortraitSliver({
    required super.key,
    required this.holder,
  });

  final StdImageHolder holder;

  Image buildImage(BuildContext context) {
    ///Image!
    double width = MediaQuery.sizeOf(context).width;
    return Image(
      image: holder.getImageProvider(),
      key: const Key('Image!'),
      width: width,
      loadingBuilder: holder.loadingBuilder,
      errorBuilder: holder.errorBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    // double aspectRatio = holder.aspectRatio ?? 1;
    Widget child = buildImage(context);
    child =
        FittedBox(key: const Key('fit'), fit: BoxFit.fitWidth, child: child);

    // Size size = MediaQuery.sizeOf(context);
    // double maxHeight = standardImageHeight;
    // double width = size.width;
    // double height = width / aspectRatio;
    //
    // if (height > maxHeight) {
    //   height = maxHeight;
    //   width = maxHeight * aspectRatio;
    // }

    // child = Stack(
    //   alignment: Alignment.bottomRight,
    //   children: [
    //     child,
    //     Positioned(
    //       top: standardImageHeight - 96 - 12,
    //       right: 12 + 3,
    //       child: ImageButtonRow(key: const Key('imgButtonRow'), holder: holder),
    //     )
    //   ],
    // );

    // child = Tooltip(message: 'Portrait; Aspect=$aspectRatio', child: child);
    child = SliverToBoxAdapter(child: child);
    // child = _PortraitSliver(
    //     key: const Key('tallSliver'), holder: holder, child: child);
    child = SliverStack(
      positionedAlignment: Alignment.bottomRight,
      children: [
        child,
        // SliverToBoxAdapter(
        //   child: ImageButtonRow(key: const Key('imgButtons'), holder: holder),
        // )
        SliverPositioned(
            bottom: 12,
            right: 12,
            child: ImageButtonRow(key: const Key('imgButtons'), holder: holder))
      ],
    );
    return child;
  }
}

class _PortraitSliver extends SliverToBoxAdapter {
  ///Wrapper for the RenderObject
  final StdImageHolder holder;

  const _PortraitSliver(
      {required this.holder, required super.key, required super.child});
  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) {
    return _PortraitRenderSliver(
        debugName: holder.displayUrl,
        aspectRatio: holder.aspectRatio ?? 1,
        colorHint: holder.colorHint);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    if (renderObject is _PortraitRenderSliver) {
      renderObject.debugName = holder.displayUrl;
      double aspectRatio = holder.aspectRatio ?? 1;
      if (aspectRatio != renderObject.aspectRatio) {
        renderObject.aspectRatio = aspectRatio;
        renderObject.markNeedsLayout();
      }
      if (holder.colorHint != renderObject.colorHint) {
        renderObject.colorHint = holder.colorHint;
        renderObject.markNeedsPaint();
      }
    }
    super.updateRenderObject(context, renderObject);
  }
}

const double lPad = 12;
const double appBar = 60;
const double portraitImgHeight = 360;

class _PortraitRenderSliver extends RenderSliverToBoxAdapter {
  String debugName;

  ///width/height
  double aspectRatio;
  // double screenAspectRatio = 0;
  ColorHint? colorHint;
  double desiredHeight = 0;
  double height = 0;
  double width = 0;
  double overscroll = 0;
  double scrollPct = 0;

  _PortraitRenderSliver(
      {required this.aspectRatio,
      required this.colorHint,
      required this.debugName});

  double clampHeight(double desiredExtent) {
    desiredHeight = desiredExtent;
    height = math.min(desiredExtent, portraitImgHeight);
    return height;
  }

  double get drawnWidth => math.min(width, crossAxisExtent);
  double get lPad => math.min(0, (crossAxisExtent - width) / 2);

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    width = crossAxisExtent;
    desiredHeight = width / aspectRatio;

    final double maxHeight = viewportMainAxisExtent;
    if (desiredHeight > maxHeight) {
      height = maxHeight;
      //TODO: Probably want a second mode, which only does overscroll
      overscroll = desiredHeight - maxHeight;
      // overscroll = 0;
    } else {
      height = desiredHeight;
      overscroll = 0;
    }

    //It needs the entire height to render in, unless you want to tell it to clip at a starting point
    final BoxConstraints childConstraints =
        BoxConstraints.tightFor(width: width, height: desiredHeight);
    child!.layout(childConstraints, parentUsesSize: false);

    //Requested overscroll amount

    //size from Overscroll
    // final double paintedChildSize =
    //     _calculateOverscrollPaintExtent(from: 0, to: height, overscroll: 0);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0, to: height);
    final double cacheExtent = calculateCacheOffset(
      constraints,
      from: 0.0,
      to: height,
    );

    final bool isVisible = constraints.remainingPaintExtent > 0;

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);

    geometry = SliverGeometry(
      scrollExtent: height + overscroll,
      paintExtent: paintedChildSize,
      layoutExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxScrollObstructionExtent: paintedChildSize + overscroll,
      maxPaintExtent: height,
      crossAxisExtent: drawnWidth,
      hitTestExtent: paintedChildSize,
      // visible: remainingPaintExtent > 0,
      visible: isVisible,
      hasVisualOverflow: false,
      // hasVisualOverflow: height > remainingPaintExtent || scrollOffset > 0.0,
    );
    //Who knows
    //If not, you need to copy & fix the rest from setChildParentData
    assert(constraints.axisDirection == AxisDirection.down);
    assert(constraints.growthDirection == GrowthDirection.forward);
    //set ScrollPt

    scrollPct = computeScrollPct();
    //Set paint offset

    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;
    childParentData.paintOffset = getChildPaintOffset();
    child!.parentData = childParentData;
  }

  double computeScrollPct() {
    if (remainingPaintExtent <= 0) {
      return 0;
    }
    if (scrollOffset > height) {
      //Above screen
      return 1;
    }
    double availHeight = viewportMainAxisExtent;

    //In situations where the image is bigger than the screen, we should use a different metric
    // if (availHeight <= height) {
    //   return 0;
    // }

    //Consumed space on screen
    double t1 =
        // remaining size on screen
        math.max(0, remainingPaintExtent);
    //Total extra space on screen
    double t2 = availHeight + overscroll;

    scrollPct = t1 / t2;

    // scrollPct = math.min(1, scrollPct);
    // scrollPct = math.max(0, scrollPct);
    // scrollPct = ui.clampDouble(scrollPct, 0, 1);
    // if (scrollPct >= -1 && scrollPct < 2) {
    dev.log('%[$debugName]=$scrollPct');
    // }
    scrollPct = ui.clampDouble(scrollPct, 0, 1);
    return scrollPct;
  }

  Offset getChildPaintOffset() {
    double yOffset = getChildYOffset();

    // yOffset -= geometry!.paintOrigin;

    // dev.log("y[$debugName]=$yOffset overlap=$overlap");

    // yOffset = math.max(appBarSize, yOffset);
    // yOffset = math.min(yOffset, viewportMainAxisExtent - height);
    // yOffset = ui.clampDouble(
    //     yOffset,
    //     //Minimum below screen
    //     -height,
    //     //minimum above screen
    //     appBarSize);

    return Offset(lPad, yOffset);
  }

  double getChildYOffset() {
    // if (desiredHeight <= height) {
    //   //Image is already sized and will not move
    //   // dev.log("\tImg sized");
    //   return 0;
    // }

    //The height that the image already would be displayed at, based on the rpe(?)
    //The code is replicating this because it's not scroll up to negative
    // return 0;
    double naturalHeight =
        math.max(0, viewportMainAxisExtent - constraints.remainingPaintExtent) -
            scrollOffset;
    return naturalHeight;

    return naturalHeight + overscroll * (scrollPct);

    double amountSpaceToScroll = viewHeight - height;

    return amountSpaceToScroll * scrollPct;

    if (remainingPaintExtent <= 0) {
      return 0;
    }

// @ %=1, yOffset=0
    //@ %=0, yOffset = desiredHeight-height

    //Simplify the coding
    //When first seen, the image bottom should be aligned with the bottom of the viewport
    double initialExtent = viewportMainAxisExtent - desiredHeight;
    // dev.log('$debugName % = $scrollPct');
    double endExtent = appBarSize;
    //Once scroll all the way up, the image top should be just under the appBar
    // double endExtent = appBarSize;
    return initialExtent + (1 - scrollPct) * (endExtent - initialExtent);
  }

  @override
  void paint(PaintingContext context, Offset imageOffset) {
    // double height = geometry!.paintExtent;

    Rect rect = Rect.fromLTWH(0, 0, constraints.crossAxisExtent, height);

    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;

    //I say
    Offset myOffset = childParentData.paintOffset;

    //Ensure if image is drawn oddly that bg is covered
    Paint bgCover = Paint()
      ..color = colorHint?.outlineColor ?? const Color(0x22000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    layer = context.pushClipRect(
      //Images don't need compositing
      false,
      myOffset,
      rect,
      (context, offset) {
        // offset += childParentData.paintOffset;
        // context.paintChild(child!, imageOffset);

        context.paintChild(child!, offset);
      },
    );

    Rect testRect =
        Rect.fromLTWH(0, imageOffset.dy, width, geometry!.layoutExtent);
    // context.canvas.drawRect(rect.shift(imageOffset).deflate(3), bgCover);
    context.canvas.drawRect(testRect.deflate(3), bgCover);
  }

  // ===== Utility ===================

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
      from,
      to,
    );
  }

  ///viewportMainAxisExtent - appBarSize
  double get viewHeight => constraints.viewportMainAxisExtent - appBarSize;
  double get scrollOffset => constraints.scrollOffset;
  double get precedingScrollExtent => constraints.precedingScrollExtent;
  double get overlap => constraints.overlap;
  double get remainingPaintExtent => constraints.remainingPaintExtent;
  double get crossAxisExtent => constraints.crossAxisExtent;
  double get viewportMainAxisExtent => constraints.viewportMainAxisExtent;
  double get remainingCacheExtent => constraints.remainingCacheExtent;
  double get cacheOrigin => constraints.cacheOrigin;
}
