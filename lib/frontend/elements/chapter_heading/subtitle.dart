import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/length_summary_widget.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/subtitle_components.dart';
import 'package:soyourhomeworld/frontend/theme/colors.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';

class ChapterHeadingSubtitle extends StatelessWidget {
  const ChapterHeadingSubtitle({required super.key});

  bool get center => false;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: center ? Alignment.center : Alignment.centerLeft,
        child: const SingleChildScrollView(
            key: Key("HeadingSubtitleTickerTape"),
            scrollDirection: Axis.horizontal,
            child: Padding(
                key: Key("heading_pad"),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: _SubtitleRow(key: Key("row")))));
  }

  Widget chapterNumber(BuildContext context) {
    Chapter? chapter = Chapter.maybeOf(context);
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
  const _SubtitleRow({super.key});

  Widget futuresRow(BuildContext context, Chapter chapter) {
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
              value: chapter.awaitSubtitle(),
              label: 'Subtitle',
              icon: null),
          FutureChip(
              key: const Key("Where"),
              value: chapter.awaitWhere(),
              label: 'Where',
              icon: Icons.public),
          FutureChip(
              key: const Key("When"),
              value: chapter.awaitWhen(),
              label: 'When',
              icon: Icons.access_time),
          _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
        ]);
  }

  Widget completedRow(BuildContext context, Chapter chapter) {
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
            value: chapter.data!.subtitle,
            label: 'Subtitle',
            icon: null),
        CurrentChip(
            key: const Key("Where"),
            value: chapter.data!.where,
            label: 'Where',
            icon: Icons.public),
        CurrentChip(
            key: const Key("When"),
            value: chapter.data!.when,
            label: 'When',
            icon: Icons.access_time),
        _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Chapter? chapter = Chapter.maybeOf(context);
    if (chapter == null) {
      //Assume it will always be null
      return nullChapterRow(context);
    }
    return ListenableBuilder(
        listenable: chapter!.loadNotifier, builder: builder);
  }

  Widget builder(BuildContext context, Widget? previousChild) {
    Chapter? chapter = Chapter.maybeOf(context);
    if (chapter == null) {
      return nullChapterRow(context);
    } else if (chapter.data == null) {
      return nullChapterRow(context);
      //These futures are causing every chapter to load at once
      return futuresRow(context, chapter);
    } else {
      return completedRow(context, chapter);
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

  final Chapter? chapter;

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
                  numDots: chapter?.data?.readingLength ?? 3,
                  dotSize: .5,
                  color: Primary.shadee,
                ))));
  }
}
