import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/chapter_social_footer.dart';
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';
import 'package:soyourhomeworld/frontend/readers/sliver_reader.dart';
import 'package:soyourhomeworld/frontend/slivers/clamping_sliver.dart';
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

  Part getPartData(PartId part) {
    if (!partReady(part)) {
      if (partNeedsLoad(part)) {
        loadPart(part).then(chapterUpdated);
      }
      //Is this heavy, making new elements?
      return const PartNoir();
    } else {
      return getPartImmediate(part);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      //Chapter will presumably always be null
      return const BlankChapterSliver(
        key: Key('BlankChapter'),
      );
    }

    late Widget sliver;
    if (chapter!.data == null) {
      sliver = LoadSliver(
        key: const Key("UnpackingLoad"),
        chapterTitle: chapter!.displayName,
      );
    } else {
      sliver = const SliverReader(key: Key('Reader'));
    }

    sliver = SliverMainAxisGroup(slivers: [
      //AppBar
      const SliverHeader(key: Key("Header")),
      //Body
      SliverReaderWidth(key: const Key("width"), sliver: sliver),
      //SocialMediaFooter
      const ChapterSocialFooter(
        key: Key('SocialFooter'),
      )
    ]);
    sliver = ChapterClampingSliver(key: const Key("Clamp"), sliver: sliver);
    if (chapter != null) {
      final Part partData = getPartData(chapter!.info.partId);

      sliver = ChapterProvider(
          key: Key("Chp${chapter!.key}"),
          chapter: chapter!,
          part: partData,
          child: sliver);
    }
    return sliver;
  }
}
