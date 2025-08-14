import 'package:flutter/material.dart';

import '../../../../backend/chapter_holder.dart';
import 'render_chapter_sliver.dart';

class ChapterSliver extends SingleChildRenderObjectWidget {
  final ChapterHolder chapter;

  final double initialHeight;

  const ChapterSliver({
    super.key,
    required this.chapter,
    this.initialHeight = 0,
    required super.child,
  });

  @override
  RenderChapterSliver createRenderObject(BuildContext context) =>
      RenderChapterSliver(chapter: chapter, height: initialHeight);

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderChapterSliver renderObject) {
    super.updateRenderObject(context, renderObject);
  }
}
