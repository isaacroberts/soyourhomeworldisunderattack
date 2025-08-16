import 'package:flutter/material.dart';

import '../../../../backend/chapter.dart';
import 'render_chapter_sliver.dart';

class ChapterClampingSliver extends SingleChildRenderObjectWidget {
  final double initialHeight;

  const ChapterClampingSliver({
    super.key,
    this.initialHeight = 0,
    required super.child,
  });

  @override
  RenderChapterSliver createRenderObject(BuildContext context) {
    Chapter? chapter = Chapter.of(context);
    return RenderChapterSliver(chapter: chapter, height: initialHeight);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderChapterSliver renderObject) {
    renderObject.chapter = Chapter.of(context);

    super.updateRenderObject(context, renderObject);
  }
}
