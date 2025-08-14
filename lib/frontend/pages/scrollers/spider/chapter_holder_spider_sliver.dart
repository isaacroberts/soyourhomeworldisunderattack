import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/pages/readers/sliver_reader.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/spider_utils.dart';

import '../../../../backend/chapter_holder.dart';
import '../slivers/null_slivers.dart';
import 'chapter_spider_sliver.dart';

class ChapterHolderSpiderSliver extends StatefulWidget {
  ///Switches between loading widget and chapter widget
  ///In the future, could show errors as well,
  ///or, in debug mode, have buttons on info
  ///
  final ChapterHolder? chapter;
  final SpiderPos? spiderPos;
  const ChapterHolderSpiderSliver(
      {required super.key, required this.chapter, required this.spiderPos});

  @override
  State<ChapterHolderSpiderSliver> createState() =>
      _ChapterHolderSpiderSliverState();
}

class _ChapterHolderSpiderSliverState extends State<ChapterHolderSpiderSliver> {
  ChapterHolder? get chapter => widget.chapter;

  SpiderPos get spiderPos => widget.spiderPos ?? SpiderPos.dead;

  @override
  void initState() {
    //If not loaded; skip if null
    // if (!(chapter?.loaded() ?? true)) {
    //   //TODO: Remove delay
    //   dev.log("Schedule load ${chapter?.varName}");
    //   Future.delayed(const Duration(seconds: 3), load);
    // }
    super.initState();
  }

  void load() async {
    dev.log("Load chapter ${chapter?.varName}");
    chapter?.getOrLoadChapter().then(chapterUpdated, onError: onError);
  }

  void chapterUpdated(var t) {
    setState(() {});
  }

  void onError(exception, trace) {
    ErrorList.showError(exception, trace);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      //Not using ChapterSliver because chapter will presumably never not be null
      return const NullChapterSliver();
    } else if (chapter!.chapter == null) {
      return ChapterSpiderSliver(
          key: const Key("ChapterSliver"),
          chapter: chapter!,
          spiderPos: spiderPos,
          child: TriWizardLoader(message: chapter!.displayName));
    } else {
      return ChapterSpiderSliver(
          key: const Key("ChapterSliver"),
          chapter: chapter!,
          spiderPos: spiderPos,
          child: SliverReader(
              key: Key("header ${chapter?.key}"), chapterHolder: chapter));
    }
  }
}
