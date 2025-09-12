import 'dart:developer' as dev;
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soyourhomeworld/frontend/image/image_buttons.dart';

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

  final ImageHolder holder;

  Image buildImage(BuildContext context) {
    ///Image!
    return Image(
      key: const Key('Image!'),
      image: NetworkImage(
        holder.url,
      ),
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

    child = Stack(
      alignment: Alignment.bottomRight,
      children: [
        child,
        Positioned(
          top: standardImageHeight - 96 - 12,
          right: 12 + 3,
          child: ImageButtonRow(key: const Key('imgButtonRow'), holder: holder),
        )
      ],
    );

    // child = Tooltip(message: 'Portrait; Aspect=$aspectRatio', child: child);

    return _PortraitSliver(
        key: const Key('tallSliver'), holder: holder, child: child);
  }
}

class _PortraitSliver extends SliverToBoxAdapter {
  ///Wrapper for the RenderObject
  final ImageHolder holder;

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
  ColorHint? colorHint;
  double desiredHeight = 0;
  double height = 0;
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

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);

    desiredHeight = switch (constraints.axis) {
      Axis.horizontal => child!.size.width,
      Axis.vertical => child!.size.height,
    };
    height = math.min(portraitImgHeight, desiredHeight);
    //Requested overscroll amount
    overscroll = math.max(desiredHeight - height, 0);
    //size from Overscroll
    // final double paintedChildSize = _calculateOverscrollPaintExtent(
    //     from: 0, to: height, overscroll: overscroll);
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
      scrollExtent: height,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxScrollObstructionExtent: paintedChildSize,
      maxPaintExtent: height,
      crossAxisExtent: crossAxisExtent,
      hitTestExtent: paintedChildSize,
      visible: isVisible,
      hasVisualOverflow: height > remainingPaintExtent || scrollOffset > 0.0,
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
  }

  double computeScrollPct() {
    double appBar = 60;

    double availHeight = viewportMainAxisExtent - appBar;

    double t1 = constraints.remainingPaintExtent - height;
    double t2 = availHeight - height;

    // double pct = math.max(0, constraints.remainingPaintExtent - height) /
    //     math.max(1, viewportMainAxisExtent - appBar - height);
    double pct = (t2 - t1) / t2;

    // if (debugName.contains('smoke_hard')) {
    //smoke_hard.jpg is wrong, even though it's standard aspect. It may be slightly taller.
    //   dev.log(
    //       "$debugName: Scroll% $pct (remPntEx = $remainingPaintExtent)  = ($t1 / $t2)");
    // }
    pct = ui.clampDouble(pct, 0, 1);
    return pct;
  }

  Offset getChildPaintOffset() {
    double extra = desiredHeight - height;
    if (extra <= 0) {
      dev.log('$extra extra: $debugName');
      return const Offset(0, 0);
    }

    // if (debugName.contains('smoke_hard')) {
    //   dev.log(
    //       "$debugName: Scroll% $scrollPct rpe = $remainingPaintExtent height = $height");
    // }
//Because scrollOffset kicks in, it moves differently once it touches the top of the screen
    //TODO: Refactor to remove floating errors
    double yOffset = -extra * (1 - scrollPct);

    // yOffset = -ui.clampDouble(-yOffset, 0, extra);
    yOffset = math.min(yOffset, viewportMainAxisExtent - height);
    // yOffset = -scrollOffset;
    return Offset(0, yOffset);
    // return Offset(0, overscroll * (scrollPct) - scrollOffset);
    return Offset(0, -scrollOffset);
    return Offset(0, overscroll - scrollOffset);
  }

  @override
  void paint(PaintingContext context, Offset imageOffset) {
    double height = geometry!.paintExtent;

    Rect rect = Rect.fromLTWH(
        0, geometry!.paintOrigin, constraints.crossAxisExtent, height);

    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;
    double extra = math.max(desiredHeight - height, 0).toDouble();

    double yOffset = -extra * (1 - scrollPct);

    // super.paint(context, offset);
    layer = context.pushClipRect(
      //This allows animations
      true,
      imageOffset,
      rect,
      (context, offset) {
        context.paintChild(child!, Offset(0, yOffset) + imageOffset);
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
