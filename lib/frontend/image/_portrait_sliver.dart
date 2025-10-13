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
    double aspectRatio = holder.aspectRatio ?? 1;
    Widget child = buildImage(context);
    child = FittedBox(key: const Key('fit'), fit: BoxFit.cover, child: child);

    Size size = MediaQuery.sizeOf(context);
    double maxHeight = standardImageHeight;
    double width = size.width;
    double height = width / aspectRatio;

    if (height > maxHeight) {
      height = maxHeight;
      width = maxHeight * aspectRatio;
    }

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

    child = _PortraitSliver(
        key: const Key('tallSliver'), holder: holder, child: child);
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
    // TODO: implement updateRenderObject
    super.updateRenderObject(context, renderObject);
  }
}

const double lPad = 12;
const double appBar = 60;
const double portraitImgHeight = 360;

class _PortraitRenderSliver extends RenderSliverToBoxAdapter {
  ///width/height
  String debugName;
  double aspectRatio;
  double screenAspectRatio = 0;
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

    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);

    screenAspectRatio = crossAxisExtent / (viewHeight);

    desiredHeight = child!.size.height;
    //TODO: Should images be scaled down?
    width = child!.size.width;

    height = math.min(portraitImgHeight, desiredHeight);
    //Requested overscroll amount
    overscroll =
        math.max(desiredHeight - viewportMainAxisExtent - appBarSize, 0);
    overscroll = 0;
    //size from Overscroll
    final double paintedChildSize = _calculateOverscrollPaintExtent(
        from: 0, to: height, overscroll: overscroll);
    // final double paintedChildSize =
    //     calculatePaintOffset(constraints, from: 0, to: height);
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
    double availHeight = viewHeight;

    if (availHeight <= height) {
      return 0;
    }

    //Consumed space on screen
    double t1 =
        // remaining size on screen
        math.max(0, remainingPaintExtent - height)
        //Height of image
        ;
    //Total extra space on screen
    double t2 = availHeight - height + overscroll;

    scrollPct = t1 / t2;

    // scrollPct = math.min(1, scrollPct);
    // scrollPct = math.max(0, scrollPct);
    // scrollPct = ui.clampDouble(scrollPct, 0, 1);
    // if (scrollPct >= -1 && scrollPct < 2) {
    //   dev.log('%[$debugName]=$scrollPct');
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
    if (desiredHeight <= height) {
      //Image is already sized and will not move
      // dev.log("\tImg sized");
      return 0;
    }
    if (remainingPaintExtent <= 0) {
      return 0;
    }
// @ %=1, yOffset=0
    //@ %=0, yOffset = desiredHeight-height

    //Simplify the coding
    //When first seen, the image bottom should be aligned with the bottom of the viewport
    double initialExtent = appBarSize;
    double endExtent = viewportMainAxisExtent - desiredHeight;
    //Once scroll all the way up, the image top should be just under the appBar
    // double endExtent = appBarSize;
    return initialExtent + scrollPct * (endExtent - initialExtent);
  }

  @override
  void paint(PaintingContext context, Offset imageOffset) {
    double height = geometry!.paintExtent;

    Rect rect = Rect.fromLTWH(
        0, geometry!.paintOrigin, constraints.crossAxisExtent, height);

    //Ensure if image is drawn oddly that bg is covered
    Paint bgCover = Paint()
      ..color = colorHint?.bgColor ?? const Color(0x22000000)
      ..style = PaintingStyle.fill;
    context.canvas.drawRect(rect.shift(imageOffset), bgCover);

    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;

    layer = context.pushClipRect(
      //Images don't need compositing
      false,
      imageOffset,
      rect,
      (context, offset) {
        // offset += childParentData.paintOffset;
        context.paintChild(child!, childParentData.paintOffset);
      },
    );
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
