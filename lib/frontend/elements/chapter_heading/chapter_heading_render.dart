import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlexibleWidthSubtitle extends SingleChildRenderObjectWidget {
  const FlexibleWidthSubtitle({
    super.key,
    required this.relativeWidth,
    required super.child,
  });

  final double relativeWidth;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderFlexibleWidthSubtitle(
      relativeWidth: relativeWidth,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderProxyBoxWithHitTestBehavior renderObject,
  ) {
    if (renderObject is _RenderFlexibleWidthSubtitle) {
      renderObject.relativeWidth = relativeWidth;
      renderObject.markNeedsLayout();
    }
  }
}

class _RenderFlexibleWidthSubtitle extends RenderProxyBoxWithHitTestBehavior {
  _RenderFlexibleWidthSubtitle({required this.relativeWidth});

  double get childWidth => child?.size.width ?? -1;
  double relativeWidth;
  double get cornerWidth => (1 - relativeWidth) / 2;

  @override
  void layout(Constraints constraints, {bool parentUsesSize = false}) {
    super.layout(constraints, parentUsesSize: true);
    // childWidth = child!.size.width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return childWidth;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return 0;
  }

  @override
  // TODO: implement paintBounds
  Rect get paintBounds => Rect.fromLTWH(
      cornerWidth * childWidth, 0, relativeWidth * childWidth, size.height);

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null || relativeWidth == 0) {
      return;
    }
    Rect rect = paintBounds;

    if (layer is ClipRectLayer) {
      layer = context.pushClipRect(
          child!.needsCompositing, offset, rect, child!.paint,
          oldLayer: layer as ClipRectLayer?, clipBehavior: Clip.hardEdge);
    } else if (layer is OffsetLayer) {
      context.pushClipRect(child!.needsCompositing, offset, rect, child!.paint,
          oldLayer: null, clipBehavior: Clip.hardEdge);
    } else {
      layer ??= context.pushClipRect(
          child!.needsCompositing, offset, rect, child!.paint,
          oldLayer: null, clipBehavior: Clip.hardEdge);
    }
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    config.headingLevel = 2;
    //TODO: We could put the text & copy in here
    // config.onCopy = ()=> ()
    super.describeSemanticsConfiguration(config);
  }
// @override
// void paint(PaintingContext context, Offset offset) {
//   if (child == null) {
//     return;
//   }
//   if (relativeWidth <= 0) {
//     layer = null;
//     return;
//   }
//   assert(needsCompositing);
//   layer = context.pu(
//     offset,
//     (opacity * 255).round(),
//     super.paint,
//     oldLayer: layer as OpacityLayer?,
//   );
//   assert(() {
//     layer!.debugCreator = debugCreator;
//     return true;
//   }());
// }
}
