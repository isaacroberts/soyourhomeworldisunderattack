import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/readers/sliver_reader.dart';
import 'package:soyourhomeworld/frontend/slivers/clamping_sliver.dart';
import 'package:soyourhomeworld/frontend/slivers/load_sliver.dart';
import 'package:soyourhomeworld/frontend/slivers/sliver_reader_width.dart';

import '../../../../backend/chapter.dart';
import '../../../../backend/part_id.dart';
import '../elements/chapter_heading/sliver_header.dart';
import '../parts/all_parts.dart';
import '../parts/part.dart';
import 'null_slivers.dart';

class ChapterSliver extends StatefulWidget {
  ///Switches between loading widget and chapter widget
  ///In the future, could show errors as well,
  ///or, in debug mode, have buttons on info
  ///
  final Chapter? chapter;
  const ChapterSliver({required super.key, required this.chapter});

  @override
  State<ChapterSliver> createState() => _ChapterSliverState();
}

class _ChapterSliverState extends State<ChapterSliver> {
  Chapter? get chapter => widget.chapter;

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
    } else if (chapter!.data == null) {
      PartId part = chapter!.info.partId;
      if (!partReady(part)) {
        if (partNeedsLoad(part)) {
          loadPart(part).then(chapterUpdated);
        }
        return ChapterLoadSliver(
            key: const Key("LoadSliver"), chapterTitle: chapter!.displayName);
      } else {
        Part partData = getPartImmediate(part);
        return ChapterProvider(
            key: Key("Chp${chapter!.key}"),
            chapter: chapter!,
            part: partData,
            child: SliverMainAxisGroup(slivers: [
              const SliverHeader(key: Key("Header")),
              ChapterClampingSliver(
                  key: const Key("ClampingSliver"),
                  sliver: SliverReaderWidth(
                      key: const Key("width"),
                      sliver: SliverToBoxAdapter(
                          child: SizedBox(
                              key: const Key('height'),
                              height: 600,
                              child: Center(
                                  key: const Key('center'),
                                  child: TriWizardLoader(
                                      key: const Key("Loader"),
                                      message: chapter!.displayName)))))),
            ]));
      }
    } else {
      PartId part = chapter!.info.partId;
      if (!partReady(part)) {
        if (partNeedsLoad(part)) {
          loadPart(part).then(chapterUpdated);
        }
        return ChapterLoadSliver(
            key: const Key('LoadSliver'), chapterTitle: chapter!.displayName);
      } else {
        Part partData = getPartImmediate(part);

        return ChapterProvider(
            key: Key("Chp${chapter!.key}"),
            chapter: chapter!,
            part: partData,
            child: const SliverMainAxisGroup(slivers: [
              SliverHeader(key: Key("Header")),
              ChapterClampingSliver(
                  key: Key("ClampingSliver"),
                  sliver: SliverReaderWidth(
                      key: Key("width"),
                      sliver: SliverReader(
                        key: Key("SliverReader"),
                      ))),
              // SliverToBoxAdapter(
              //     child: NoirSocialMediaFooter(
              //   key: Key("Footer"),
              // )),
            ]));
      }
    }
  }
}
