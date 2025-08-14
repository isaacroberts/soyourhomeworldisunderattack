import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/chapter_holder_sliver.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/spider/spider_next_sliver.dart';

import '../../../../backend/book.dart';
import 'chapter_spider.dart';

class SpiderSliverScroller extends StatefulWidget {
  // final ChapterSpider spider;
  const SpiderSliverScroller({super.key});

  @override
  State<SpiderSliverScroller> createState() => _SpiderSliverScrollerState();
}

class _SpiderSliverScrollerState extends State<SpiderSliverScroller> {
  //The ChapterSpider is essentially a controller
  late final ChapterSpider spider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    dev.log("DidChange");
    super.didChangeDependencies();
    spider = ChapterSpider(book: Book.of(context));
    spider.addListener(spiderBellRang);
  }

  @override
  void didUpdateWidget(covariant SpiderSliverScroller oldWidget) {
    dev.log("didUpdateWidget");
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    spider.removeListener(spiderBellRang);
    spider.dispose();
    super.dispose();
  }

  void spiderBellRang() {
    dev.log("** **");
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: const Color(0x2affff00),
            height: 200,
            child: Text(spider.previous?.displayName ?? 'null'),
          ),
        ),
        // ChapterHolderSliver(key: Key('previous'), chapter: spider.previous),
        ChapterHolderSliver(key: const Key('current'), chapter: spider.current),
        SpiderNextSliver(
          key: const Key('next'),
          chapter: spider.next,
          spider: spider,
        ),
        // ChapterHolderSliver(key: Key('next'), chapter: spider.next),
      ],
    );
  }
}
