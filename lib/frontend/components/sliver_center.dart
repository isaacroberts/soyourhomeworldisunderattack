import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SliverCenter extends SingleChildRenderObjectWidget {
  const SliverCenter({
    required Widget sliver,
    super.key,
    this.align = 0,
    this.maxExtent,
  }) : super(child: sliver);

  ///-1= Left, 0=Center, 1=Right
  final double align;
  final double? maxExtent;

  @override
  RenderSliver createRenderObject(BuildContext context) {
    return RenderSliverCenter(align: align, maxExtent: maxExtent);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverCenter renderObject) {
    //TODO: If checks
    renderObject.align = align;
    renderObject.maxExtent = maxExtent;
    super.updateRenderObject(context, renderObject);
  }
}

class RenderSliverCenter extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver> {
  //Set by widget
  double align;
  double? maxExtent;

  RenderSliverCenter({required this.align, required this.maxExtent});

  //Internal
  double? horizontalPadding;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! SliverPhysicalParentData) {
      child.parentData = SliverPhysicalParentData();
    }
  }

  @override
  void performLayout() {
    // Layout the child with the current constraints
    SliverConstraints childConstraints = constraints.copyWith(
        crossAxisExtent: maxExtent ?? constraints.crossAxisExtent);
    child!.layout(childConstraints, parentUsesSize: true);

    final childGeometry = child!.geometry;
    if (childGeometry != null) {
      // Update the center offset during layout so we don't recalc on each paint
      _updateCenterOffset();
      geometry = SliverGeometry(
        crossAxisExtent: childConstraints.crossAxisExtent,
        scrollExtent: childGeometry.scrollExtent,
        paintExtent: childGeometry.paintExtent,
        maxPaintExtent: childGeometry.maxPaintExtent,
        layoutExtent: childGeometry.layoutExtent,
      );
    }
  }

  /// Helper method to calculate left padding for centering
  /// and update the paintOffset.
  void _updateCenterOffset() {
    if (child != null) {
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        double parentSize = constraints.crossAxisExtent;
        // final parentConstraints = parent?.constraints;
        // double? parentSize;
        // if (parentConstraints is BoxConstraints) {
        //   parentSize = parentConstraints.maxWidth;
        // } else if (parentConstraints is SliverConstraints) {
        //   parentSize = parentConstraints.crossAxisExtent;
        // }
        if (parentSize != null) {
          final childConstraints = child!.constraints;
          final childSize = childConstraints.crossAxisExtent;
          double crossAxisPadding = parentSize - childSize;

          horizontalPadding = alignToPad(crossAxisPadding);
          parentData.paintOffset = Offset(horizontalPadding!, 0);
        }
      }
    }
  }

  double alignToPad(double totalSpace) {
    //TODO: Verify visually
    return totalSpace * ((align + 1) / 4);
    // if (align==-1) {
    //   return 0;
    // }
    // if (align==0) {
    //   return totalSpace/2;
    // }
    // else if (align==1) {
    //   return totalSpace;
    // }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        // Use the precomputed paintOffset from performLayout
        context.paintChild(child!, offset + Offset(horizontalPadding ?? 0, 0));
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
    if (child == null || horizontalPadding == null) return false;

    // Adjust crossAxisPosition to the child's coordinate space by
    //subtracting horizontalPadding.
    final adjustedCrossAxisPosition = crossAxisPosition - horizontalPadding!;

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
}
