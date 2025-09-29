import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../backend/chapter.dart';
import '../parts/part.dart';
import '../theme/layout_constants.dart';

class SliverReaderWidth extends SingleChildRenderObjectWidget {
  ///Also provides the BG color
  final Widget sliver;
  const SliverReaderWidth({required super.key, required this.sliver})
      : super(child: sliver);

  @override
  RenderObject createRenderObject(BuildContext context) {
    Part part = ChapterProvider.partOf(context);
    return RenderSliverReaderWidth(part: part);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    if (renderObject is RenderSliverReaderWidth) {
      Part part = ChapterProvider.partOf(context);

      if (part != renderObject.part) {
        renderObject.part = part;
        renderObject.markNeedsPaint();
      }
    }
    super.updateRenderObject(context, renderObject);
  }
}

class RenderSliverReaderWidth extends RenderProxySliver {
  Part part;
  double pad = 0;
  double width = 0;

  RenderSliverReaderWidth({required this.part});

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! SliverPhysicalParentData) {
      child.parentData = SliverPhysicalParentData();
    }
  }

  @override
  void performLayout() {
    assert(child != null);
    width = math.min(maxReaderWidth - 24, constraints.crossAxisExtent);
    pad = (constraints.crossAxisExtent - width) / 2;
    SliverConstraints fitWidth = constraints.copyWith(crossAxisExtent: width);
    child!.layout(fitWidth, parentUsesSize: true);
    geometry = child!.geometry;
    _updateCenterOffset();
  }

  @override
  double childCrossAxisPosition(covariant RenderObject child) {
    return pad;
  }

  /// Helper method to calculate left padding for centering
  /// and update the paintOffset.
  void _updateCenterOffset() {
    if (child != null) {
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        final parentConstraints = parent?.constraints;
        double? parentSize;
        if (parentConstraints is SliverConstraints) {
          parentSize = parentConstraints.crossAxisExtent;
        }
        if (parentSize != null) {
          final childConstraints = child!.constraints;
          final childSize = childConstraints.crossAxisExtent;
          double crossAxisPadding;
          if (child != null && child is RenderSliverConstrainedCrossAxis) {
            final childMaxExtent =
                (child! as RenderSliverConstrainedCrossAxis).maxExtent;
            crossAxisPadding = childSize - childMaxExtent;
          } else {
            crossAxisPadding = parentSize - childSize;
          }
          pad = crossAxisPadding / 2;
          parentData.paintOffset = Offset(pad, 0);
        }
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      if (false) {
        //Paint BG
        double top = geometry!.paintOrigin;
        double height = geometry!.paintExtent;
        Paint bg = Paint()..color = part.gutterColor;
        double gpad = pad - 12;
        //Left side
        context.canvas.drawRect(Rect.fromLTWH(0, top, gpad, height), bg);
        //Right side
        double right = constraints.crossAxisExtent;
        context.canvas
            .drawRect(Rect.fromLTWH(right - gpad, top, gpad, height), bg);
        //Paint page
        bg.color = part.pageColor;
        context.canvas
            .drawRect(Rect.fromLTWH(gpad, top, width + 24, height), bg);
      }
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        // Use the precomputed paintOffset from performLayout
        context.paintChild(child!, offset + Offset(pad, 0));
      }
    }
  }

  // Overriding hitTest to extend the hit area to the right side.
  @override
  bool hitTest(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    if (child == null) return false;

    // Adjust crossAxisPosition to the child's coordinate space by
    //subtracting horizontalPadding.
    final adjustedCrossAxisPosition = crossAxisPosition - pad;

    if (adjustedCrossAxisPosition < 0) {
      return false;
    }

    return child!.hitTest(
      result,
      mainAxisPosition: mainAxisPosition,
      crossAxisPosition: adjustedCrossAxisPosition,
    );
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    final childParentData = child.parentData;
    if (childParentData is SliverPhysicalParentData) {
      childParentData.applyPaintTransform(transform);
    }
  }

  @override
  bool get sizedByParent => false;
}
