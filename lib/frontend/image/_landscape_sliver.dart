import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'base_image_holder.dart';
import 'image_buttons.dart';
import 'image_constants.dart';
import 'image_holder.dart';

class LandscapeSliver extends StatelessWidget {
  /// [===========================================]
  /// [                                           ]
  /// [                                           ]
  /// [                                           ]
  /// [              Wide!                        ]
  /// [              Landscape!                   ]
  /// [                                           ]
  /// [                                           ]
  /// [                                           ]
  /// [===========================================]
  final StdImageHolder holder;

  const LandscapeSliver({
    required super.key,
    required this.holder,
  });

  Image buildImage(BuildContext context) {
    ///Image!
    double width = MediaQuery.sizeOf(context).width;

    return Image(
      image: holder.getImageProvider(),
      key: const Key('Image!'),

      width: width,

      //TODO: Doesn't this need a frameBuilder
      loadingBuilder: holder.loadingBuilder,
      errorBuilder: holder.errorBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = buildImage(context);
    double aspectRatio = holder.aspectRatio ?? 1;
    child = FittedBox(
        key: const Key('fit'),
        fit: BoxFit.fitWidth,
        alignment: Alignment.center,
        child: child);

    // child = SizedBox(
    //     key: const Key('imgSize'),
    //     width: standardImageWidth,
    //     height: standardImageWidth / aspectRatio,
    //     child: child);

    child = LandscapeFrameSliver(
        key: const Key('landscape'), holder: holder, child: child);
    child = SliverStack(
      key: const Key('ImgButtonStack'),
      positionedAlignment: Alignment.bottomRight,
      children: [
        child,
        SliverPositioned(
            key: const Key('ButtonPos'),
            bottom: 12,
            right: 12,
            child: ImageButtonRow(key: const Key('imgButtons'), holder: holder))
      ],
    );

    return child;
  }
}

class LandscapeFrameSliver extends SliverToBoxAdapter {
  ///Wrapper for the RenderObject
  final ImageHolder holder;

  const LandscapeFrameSliver(
      {required this.holder, required super.key, required super.child});
  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) {
    return _LandscapeRenderSliver(
        aspectRatio: holder.aspectRatio ?? 1, colorHint: holder.colorHint);
  }
}

const double lPad = 12;

class _LandscapeRenderSliver extends RenderSliverToBoxAdapter {
  ///width/height
  double aspectRatio;
  ColorHint? colorHint;
  // double desiredHeight = 0;
  // double height = 0;
  static const double strokeWidth = 1;
  static const double radiusAmt = 24;
  static const Radius imgRadius = Radius.circular(24);

  _LandscapeRenderSliver({required this.aspectRatio, required this.colorHint});

  @override
  void performLayout() {
    if (child == null) {
      return;
    }
    final double width = constraints.crossAxisExtent - strokeWidth * 2;
    final double childHeight = width / aspectRatio;
    final double height = childHeight + strokeWidth * 2 + radiusAmt * 2;
    BoxConstraints childConstraints =
        BoxConstraints.tight(Size(width, childHeight));
    child!.layout(childConstraints, parentUsesSize: false);

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
      layoutExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxScrollObstructionExtent: paintedChildSize,
      maxPaintExtent: height,
      crossAxisExtent: constraints.crossAxisExtent,
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

    //Set paint offset
    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;
    childParentData.paintOffset =
        const Offset(strokeWidth, strokeWidth + radiusAmt);
    child!.parentData = childParentData;
  }

  @override
  void paint(PaintingContext context, Offset imageOffset) {
    double height = geometry!.paintExtent;

    Rect rect = Rect.fromLTWH(strokeWidth, geometry!.paintOrigin,
        constraints.crossAxisExtent - strokeWidth * 2, height);

    //TODO: It's unclear if paintOrigin should be included in this
    // double bottomTouch = imageOffset.dy +
    //     geometry!.paintOrigin +
    //     geometry!.paintExtent -
    //     constraints.viewportMainAxisExtent;
    bool touchingBottom =
        imageOffset.dy + geometry!.paintOrigin + geometry!.paintExtent >=
            constraints.viewportMainAxisExtent;
    // dev.log(
    //     "Img touchingBottom: ${imageOffset.dy} + ${geometry!.paintOrigin} + ${geometry!.paintExtent} >= ${constraints.viewportMainAxisExtent} = $touchingBottom amt = $bottomTouch");
    // Color? b1Hint = colorHint?.bgColor;
    // Color? b2Hint = colorHint?.outlineColor;
    // Color? bgHint =
    //     Color.lerp(b1Hint, b2Hint, ui.clampDouble(scrollPct * 1.4 - .2, 0, 1));

    final Rect rectFromZero = Rect.fromLTWH(
        strokeWidth,
        radiusAmt + strokeWidth,
        constraints.crossAxisExtent - strokeWidth * 2,
        geometry!.paintExtent - radiusAmt * 2);

    RRect rrect = touchingBottom
        ? RRect.fromRectAndCorners(rectFromZero,
            topRight: imgRadius, topLeft: imgRadius)
        : RRect.fromRectAndRadius(rectFromZero, imgRadius);

    Color? bgHint = colorHint?.bgColor;
    if (bgHint != null) {
      Paint bg = Paint()
        ..color = bgHint
        ..style = PaintingStyle.fill;
      Rect bgRect = Rect.fromLTWH(0, imageOffset.dy,
          constraints.crossAxisExtent, geometry!.paintExtent);

      // context.canvas.drawRect(bgRect, bg);
    }
    bgHint = colorHint?.outlineColor;
    if (bgHint != null) {
      Paint outline = Paint()
        ..color = bgHint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      context.canvas.drawRRect(rrect.shift(imageOffset), outline);
    }
    //Changing this to stdHeight instead of paintExtent prevents the bottom of the RRect from curving when the image is halfway on the bottom of the screen

    final SliverPhysicalParentData childParentData =
        child!.parentData! as SliverPhysicalParentData;
    // super.paint(context, offset);
    layer = context.pushClipRRect(
      //This allows animations
      true,
      imageOffset,
      rect,
      rrect,
      (context, offset) {
        context.paintChild(child!, offset + childParentData.paintOffset);
      },
    );
  }

  @override
  bool hitTestChildren(SliverHitTestResult result,
      {required double mainAxisPosition, required double crossAxisPosition}) {
    assert(geometry!.hitTestExtent > 0.0);
    if (child != null) {
      return hitTestBoxChild(
        BoxHitTestResult.wrap(result),
        child!,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: crossAxisPosition,
      );
    }
    return false;
  }

  @override
  bool hitTestSelf(
      {required double mainAxisPosition, required double crossAxisPosition}) {
    //Does not accept clicks
    return false;
  }
}
