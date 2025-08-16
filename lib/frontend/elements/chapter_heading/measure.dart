import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../backend/chapter.dart';
import 'heading_data.dart';

class ChapterHeaderMeasureSliver extends SingleChildRenderObjectWidget {
  /// All this does is wraps the HeadingBar to add a callback when the header becomes the current chapter
  final ChapterMainCallback? onBecomesMain;

  const ChapterHeaderMeasureSliver({
    super.key,
    required this.onBecomesMain,
    required super.child,
  });
  static ChapterHeaderMeasureSliver fromChapter(BuildContext context,
      {required Chapter chapter, Widget? child}) {
    return ChapterHeaderMeasureSliver(
        onBecomesMain:
            ChapterHeadingData.maybeOf(context)?.onChapterBecomesMain,
        child: child);
  }

  @override
  RenderProxySliver createRenderObject(BuildContext context) {
    Chapter? chapter = Chapter.maybeOf(context);
    return _RenderChapterHeaderMeasureSliver(
        chapter: chapter, onBecomesMain: onBecomesMain);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderProxySliver renderObject) {
    if (renderObject is _RenderChapterHeaderMeasureSliver) {
      Chapter? chapter = Chapter.maybeOf(context);
      if (chapter != renderObject.chapter) {
        renderObject.chapter = chapter;
        renderObject.markNeedsPaint();
        renderObject.markNeedsLayout();
      }
      if (onBecomesMain != renderObject.onBecomesMain) {
        renderObject.onBecomesMain = onBecomesMain;
        //The layout will immediately trigger onBecomesMain, if true.
        renderObject.markNeedsLayout();
      }
      super.updateRenderObject(context, renderObject);
    }
  }
}

class _RenderChapterHeaderMeasureSliver extends RenderProxySliver {
  Chapter? chapter;
  ChapterMainCallback? onBecomesMain;
  // bool wasMain = false;

  double lastScrollOffset = -1;

  _RenderChapterHeaderMeasureSliver(
      {required this.chapter, required this.onBecomesMain});

  @override
  void performLayout() {
    super.performLayout();

    if (onBecomesMain != null) {
      if (precedingScrollExtent != lastScrollOffset) {
        lastScrollOffset = precedingScrollExtent;
        onBecomesMain!(chapter, precedingScrollExtent);
      }
    }
  }

  //Typing speed

  double get scrollOffset => constraints.scrollOffset;
  double get precedingScrollExtent => constraints.precedingScrollExtent;
  double get overlap => constraints.overlap;
  double get remainingPaintExtent => constraints.remainingPaintExtent;
  double get crossAxisExtent => constraints.crossAxisExtent;
  double get viewportMainAxisExtent => constraints.viewportMainAxisExtent;
  double get remainingCacheExtent => constraints.remainingCacheExtent;
  double get cacheOrigin => constraints.cacheOrigin;
}
