import 'package:flutter/material.dart';

import '../../../../backend/book.dart';
import '../../../../backend/chapter.dart';
import '../../parts/gn_colors.dart';
import '../length_summary_widget.dart';
import '../noir/subtitle_components.dart';

class GnChapterHeadingSubtitle extends StatelessWidget {
  const GnChapterHeadingSubtitle({required super.key});

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
            value: chapter.extra!.subtitle ?? 'Subtitle',
            label: 'Subtitle',
            icon: null),
        CurrentChip(
            key: const Key("Where"),
            value: chapter.extra!.where ?? 'Where',
            label: 'Where',
            icon: Icons.public),
        CurrentChip(
            key: const Key("When"),
            value: chapter.extra!.when,
            label: 'When',
            icon: Icons.access_time),
        _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
        const SizedBox(width: 12),
        FilledButton(onPressed: () {}, child: const Text('FilledButton')),
        const SizedBox(width: 12),
        OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
        const SizedBox(width: 12),
        ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
        const SizedBox(width: 12),
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
        listenable: chapter.loadNotifier, builder: builder);
  }

  Widget builder(BuildContext context, Widget? previousChild) {
    Chapter? chapter = Chapter.maybeOf(context);
    if (chapter == null || chapter.data == null) {
      return nullChapterRow(context);
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
                  color: GnPrimary.shaded,
                ))));
  }
}
