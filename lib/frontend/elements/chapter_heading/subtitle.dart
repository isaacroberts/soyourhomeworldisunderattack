import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/length_summary_widget.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/subtitle_components.dart';
import 'package:soyourhomeworld/frontend/theme/colors.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter_holder.dart';

class ChapterHeadingSubtitle extends StatelessWidget {
  final ChapterHolder? chapter;
  const ChapterHeadingSubtitle({required super.key, required this.chapter});

  bool get center => false;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: center ? Alignment.center : Alignment.centerLeft,
        child: SingleChildScrollView(
            key: const Key("HeadingSubtitleTickerTape"),
            scrollDirection: Axis.horizontal,
            child: Padding(
                key: const Key("heading_pad"),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: _SubtitleRow(key: const Key("row"), chapter: chapter))));
  }

  Widget chapterNumber(BuildContext context) {
    String tooltip = '${chapter?.id} / ${Book.maybeOf(context)?.chapterAmt}';
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Tooltip(
            message: tooltip,
            child: Chip(
                // avatar: Icon(RpgAwesome.book),
                label: Text('Chapter ${chapter?.id ?? '-'}'))));
  }

  Widget textButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: FilledButton(
          child: const Text('Filled'),
          onPressed: () {},
        ));
  }
}

class _SubtitleRow extends StatelessWidget {
  const _SubtitleRow({
    super.key,
    required this.chapter,
  });

  final ChapterHolder? chapter;
  Widget futuresRow(BuildContext context) {
    ///For waiting on chapter
    return Row(
        key: const Key("heading_row"),
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BookmarkButton(key: const Key("bookmark"), chapter: chapter),
          FutureChip(
              key: const Key("Subtitle"),
              value: chapter?.awaitSubtitle(),
              label: 'Subtitle',
              icon: null),
          FutureChip(
              key: const Key("Where"),
              value: chapter?.awaitWhere(),
              label: 'Where',
              icon: Icons.public),
          FutureChip(
              key: const Key("When"),
              value: chapter?.awaitWhen(),
              label: 'When',
              icon: Icons.access_time),
          _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
        ]);
  }

  Widget completedRow(BuildContext context) {
    ///No waiting on futures
    return Row(
      key: const Key("heading_row"),
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BookmarkButton(key: const Key("bookmark"), chapter: chapter),
        CurrentChip(
            key: const Key("Subtitle"),
            value: chapter!.chapter!.subtitle,
            label: 'Subtitle',
            icon: null),
        CurrentChip(
            key: const Key("Where"),
            value: chapter!.chapter!.where,
            label: 'Where',
            icon: Icons.public),
        CurrentChip(
            key: const Key("When"),
            value: chapter!.chapter!.when,
            label: 'When',
            icon: Icons.access_time),
        _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      return nullChapterRow(context);
    } else if (chapter?.chapter == null) {
      return nullChapterRow(context);
      //These futures are causing every chapter to load at once
      return futuresRow(context);
    } else {
      return completedRow(context);
    }
  }

  Widget nullChapterRow(BuildContext context) {
    ///Empty
    return const Row(
        key: Key("heading_row"),
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BookmarkButton(key: Key("bookmark"), chapter: null),
          _LengthSummaryWrap(key: Key("lsw"), chapter: null),
        ]);
  }
}

class _LengthSummaryWrap extends StatelessWidget {
  const _LengthSummaryWrap({
    required super.key,
    required this.chapter,
  });

  final ChapterHolder? chapter;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Chip(
            key: const Key("LSW_Chip"),
            label: SizedBox(
                width: 16,
                height: 20,
                child: LengthSummaryWidget(
                  numDots: chapter?.chapter?.readingLength ?? 3,
                  dotSize: .5,
                  color: Primary.shadee,
                ))));
  }
}
