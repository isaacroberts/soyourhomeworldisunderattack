import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/pages/readers/sliver_reader.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/null_slivers.dart';

import '../../../../backend/chapter_holder.dart';
import 'chapter_spider.dart';

class SpiderNextSliver extends StatelessWidget {
  final ChapterHolder? chapter;
  final ChapterSpider spider;

  const SpiderNextSliver(
      {super.key, required this.chapter, required this.spider});

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      return const BlankChapterSliver();
    } else if (chapter!.chapter == null) {
      return _NextSliver(
          key: Key('NextSliver_${chapter!.id}'),
          spider: spider,
          child: TriWizardLoader(message: chapter!.displayName));
    } else {
      return _NextSliver(
          key: Key('NextSliver_${chapter!.id}'),
          spider: spider,
          child: SliverReader(
              key: Key("SliverReader_${chapter!.id}"), chapterHolder: chapter));
    }
  }
}

class _NextSliver extends SliverToBoxAdapter {
  final ChapterSpider spider;

  const _NextSliver(
      {required super.key, required this.spider, required super.child});

  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) {
    return _RenderNextSliver(spider: spider);
  }
}

class _RenderNextSliver extends RenderSliverToBoxAdapter {
  final ChapterSpider spider;
  _RenderNextSliver({required this.spider, super.child});

  @override
  void performLayout() {
    if (constraints.scrollOffset > 0) {
      spider.goDown();
    }
    super.performLayout();
  }
}
