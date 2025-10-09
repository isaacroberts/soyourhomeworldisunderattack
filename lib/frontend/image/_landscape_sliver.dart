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
    child = FittedBox(key: const Key('fit'), fit: BoxFit.cover, child: child);

    child = SizedBox(
        key: const Key('imgSize'),
        width: standardImageHeight * aspectRatio,
        height: standardImageHeight,
        child: child);

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
  double desiredHeight = 0;
  double height = 0;

  _LandscapeRenderSliver({required this.aspectRatio, required this.colorHint});

  @override
  void paint(PaintingContext context, Offset imageOffset) {
    double height = geometry!.paintExtent;

    const double strokeWidth = 3;

    Rect rect = Rect.fromLTWH(strokeWidth, geometry!.paintOrigin,
        constraints.crossAxisExtent - strokeWidth * 2, height);

    bool touchingBottom = geometry!.paintOrigin + geometry!.paintExtent >
        constraints.viewportMainAxisExtent;
    // Color? b1Hint = colorHint?.bgColor;
    // Color? b2Hint = colorHint?.outlineColor;
    // Color? bgHint =
    //     Color.lerp(b1Hint, b2Hint, ui.clampDouble(scrollPct * 1.4 - .2, 0, 1));
    Color? bgHint = colorHint?.bgColor;
    const Radius imgRadius = Radius.circular(36);
    if (bgHint != null) {
      Paint bg = Paint()
        ..color = bgHint
        ..style = PaintingStyle.fill;
      Rect bgRect = rect
          //Must follow image
          .shift(imageOffset);

      context.canvas.drawRect(bgRect.inflate(strokeWidth), bg);
    }
    //Changing this to stdHeight instead of paintExtent prevents the bottom of the RRect from curving when the image is halfway on the bottom of the screen
    final Rect rectFromZero = Rect.fromLTWH(strokeWidth, 0,
        constraints.crossAxisExtent - strokeWidth * 2, standardImageHeight);

    RRect rrect = touchingBottom
        ? RRect.fromRectAndCorners(rectFromZero,
            topRight: imgRadius, topLeft: imgRadius)
        : RRect.fromRectAndRadius(rectFromZero, imgRadius);

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
}
