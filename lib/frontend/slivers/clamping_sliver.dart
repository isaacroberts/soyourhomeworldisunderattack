import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/heading_data.dart';

import '../../../../backend/chapter.dart';
import 'render_clamping_sliver.dart';

class ChapterClampingSliver extends SingleChildRenderObjectWidget {
  final double initialHeight;

  const ChapterClampingSliver({
    super.key,
    this.initialHeight = 0,
    required Widget sliver,
  }) : super(child: sliver);

  @override
  RenderClampingSliver createRenderObject(BuildContext context) {
    ChapterProvider provider = ChapterProvider.of(context);

    ChapterHeadingData? headingData = ChapterHeadingData.maybeOf(context);

    return RenderClampingSliver(
        chapter: provider.chapter!,
        part: provider.part,
        onBecomesMain: headingData?.onChapterBecomesMain,
        height: initialHeight);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderClampingSliver renderObject) {
    ChapterProvider provider = ChapterProvider.of(context);

    if (renderObject.chapter != provider.chapter) {
      renderObject.chapter = provider.chapter!;
      renderObject.markNeedsLayout();
      // renderObject.markNeedsPaint();
    }
    if (renderObject.part != provider.part) {
      renderObject.part = provider.part;
      // renderObject.markNeedsLayout();
      renderObject.markNeedsPaint();
    }
    super.updateRenderObject(context, renderObject);
  }
}
