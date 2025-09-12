import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'fullscreen_wrap.dart';
import 'image_constants.dart';
import 'image_holder.dart';

class LandscapeSliver extends StatelessWidget {
  /// [===========================================]
  /// [                                           ]
  /// [                                           ]
  /// [              Wide!                        ]
  /// [              Landscape!                   ]
  /// [                                           ]
  /// [                                           ]
  /// [                                           ]
  /// [                                           ]
  /// [===========================================]
  final ImageHolder holder;

  const LandscapeSliver({
    required super.key,
    required this.holder,
  });

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

    double width = MediaQuery.sizeOf(context).width;

    if (width > 800) {
      child = ImageFullscreenWrapSliver(key: key, holder: holder, child: child);
    }

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
    const Radius imgRadius = Radius.elliptical(72, 12);
    if (bgHint != null) {
      Paint bg = Paint()
        ..color = bgHint
        ..style = PaintingStyle.fill;
      Rect bgRect = rect
          //Must follow image
          .shift(imageOffset);

      context.canvas.drawRect(bgRect.inflate(strokeWidth), bg);

      // RRect bgRR = RRect.fromRectAndRadius(bgRect, imgRadius);
      // context.canvas.drawRRect(bgRR.inflate(strokeWidth), bg);

      // Paint oo = Paint()
      //   ..color = colorHint!.foreColor!
      //   ..style = PaintingStyle.stroke
      //   ..strokeWidth = 1.5;
      // context.canvas.drawRRect(bgRR, oo);

      // context.canvas.drawOval(bgRect, bg);
    }
    //Starts from 0
    // rect = rect.shift(Offset(0, imgScrollIndicator));
    final Rect rectFromZero = Rect.fromLTWH(strokeWidth, 0,
        constraints.crossAxisExtent - strokeWidth * 2, geometry!.paintExtent);

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
