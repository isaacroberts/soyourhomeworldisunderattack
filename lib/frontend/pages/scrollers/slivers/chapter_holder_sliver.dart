import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/bar.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/pages/readers/sliver_reader.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/chapter_sliver.dart';

import '../../../../backend/chapter_holder.dart';
import 'null_slivers.dart';

class ChapterHolderSliver extends StatefulWidget {
  ///Switches between loading widget and chapter widget
  ///In the future, could show errors as well,
  ///or, in debug mode, have buttons on info
  ///
  final ChapterHolder? chapter;
  const ChapterHolderSliver({required super.key, required this.chapter});

  @override
  State<ChapterHolderSliver> createState() => _ChapterHolderSliverState();
}

class _ChapterHolderSliverState extends State<ChapterHolderSliver> {
  ChapterHolder? get chapter => widget.chapter;

  @override
  void initState() {
    chapter?.loadNotifier.addListener(_chapterUpdated);
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
    chapter?.loadNotifier.addListener(_chapterUpdated);
  }

  void chapterUpdated(var t) {
    if (mounted) {
      setState(() {});
    }
  }

  void _chapterUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  void onError(exception, trace) {
    ErrorList.showError(exception, trace);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      //Not using ChapterSliver because chapter will presumably never not be null
      return const BlankChapterSliver();
    } else if (chapter!.chapter == null) {
      return SliverMainAxisGroup(slivers: [
        SliverHeader(
            key: const Key("LoadingHeader"), chapter: chapter, header: null),
        ChapterSliver(
            key: const Key("ChapterSliver"),
            chapter: chapter!,
            child: SliverToBoxAdapter(
                key: const Key("LoaderBox"),
                child: SizedBox(
                    height: 400,
                    child: Center(
                        child: TriWizardLoader(
                            key: const Key("Loader"),
                            message: chapter!.displayName)))))
      ]);
    } else {
      // return SliverOpacity(
      //     opacity: 1,
      //     key: const Key("ChapterSliver"),
      //     // chapter: chapter!,
      //     sliver: SliverReader(chapterHolder: chapter));
      return SliverMainAxisGroup(slivers: [
        SliverHeader(
            key: const Key("LoadingHeader"),
            chapter: chapter,
            header: chapter?.chapter?.header),
        ChapterSliver(
            key: const Key("ChapterSliver"),
            chapter: chapter!,
            child: SliverReader(
                key: Key("SliverReader_${chapter?.key}"),
                chapterHolder: chapter))
      ]);
    }
  }
}
