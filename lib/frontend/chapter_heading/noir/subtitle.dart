import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/length_summary_widget.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/noir/subtitle_components.dart';

import '../../../../backend/book.dart';
import '../../../../backend/chapter.dart';
import '../../../../backend/chapter_data.dart';
import '../../parts/noir_colors.dart';
import '../../parts/part.dart';

class ChapterHeadingSubtitle extends StatelessWidget
    implements PreferredSizeWidget {
  const ChapterHeadingSubtitle({required super.key});

  bool get center => false;

  @override
  Widget build(BuildContext context) {
    ChapterProvider provider = ChapterProvider.of(context);

    Chapter? chapter = provider.chapter;
    late Widget scrollRow;
    if (chapter?.extra?.hasAnyChips ?? false || chapter?.extra?.what != null) {
      scrollRow = const Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
              key: Key("HeadingSubtitleTickerTape"),
              scrollDirection: Axis.horizontal,
              child: Padding(
                  key: Key("heading_pad"),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  child: _SubtitleRow(key: Key("row")))));
    } else {
      //Add just copy button
      scrollRow = const Align(
          alignment: Alignment.centerLeft,
          child: _CopyTextButton(key: Key("copyButton")));
      // scrollRow = const Padding(
      //     key: Key("heading_pad"),
      //     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      //     child: _SubtitleRow(key: Key("row")));
    }
    //TODO: Extract

    scrollRow = Row(
      key: const Key('subtRow'),
      children: [
        // BookmarkButton(key: const Key('bookmark'), chapter: chapter),

        // const SizedBox(width: 6),

        Expanded(child: scrollRow),
        //Fake pad
        // const SizedBox(width: 6),
        // const SizedBox(width: 12),
        // _LengthSummaryWrap(key: const Key('lsw'), chapter: chapter),

        // const SizedBox(width: 12),
        RecapIcon(recap: chapter?.extra?.recap),
        // const SizedBox(width: 6),
      ],
    );

    return _SubtitleContainer(
        key: const Key("subtitleContainer"),
        chapter: provider.chapter,
        part: provider.part,
        child: scrollRow);
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

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _SubtitleRow extends StatelessWidget {
  const _SubtitleRow({super.key});

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
    } else if (chapter.extra!.hasAnyChips) {
      return completedRow(context, chapter);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget noChipsRow(BuildContext context, Chapter chapter) {
    return const _CopyTextButton(key: Key('copyButton'));
  }

  Widget completedRow(BuildContext context, Chapter chapter) {
    ///No waiting on futures
    ChapterExtra extra = chapter.extra!;
    return Row(
      key: const Key("heading_row"),
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // BookmarkButton(key: const Key("bookmark"), chapter: chapter),
        WhatIcon(key: Key('what=${extra.what}'), what: extra.what),
        if (extra.contentWarning != null)
          //TODO: Brighter icon
          CurrentChip(
              key: const Key("CW"),
              value: 'CW: ${extra.contentWarning}',
              label: 'Content Warning',
              icon: Icons.warning_amber),
        // CurrentChip(
        //     key: const Key("What"),
        //     value: extra.what,
        //     label: 'What',
        //     icon: Icons.chevron_right),
        CurrentChip(
            key: const Key("Subtitle"),
            value: extra.subtitle,
            label: 'Subtitle',
            icon: null),
        CurrentChip(
            key: const Key("Where"),
            value: extra.where,
            label: 'Where',
            icon: Icons.location_on_outlined),
        CurrentChip(
            key: const Key("When"),
            value: extra.when,
            label: 'When',
            icon: Icons.calendar_month),

        // CurrentChip(
        //     key: const Key("Recap"),
        //     value: extra.recap,
        //     label: 'Recap',
        //     //Uses the same icon as above because they won't both be used
        //     icon: Icons.question_mark),
        // _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
        //TODO: Move to bottom
        const _CopyTextButton(
          key: Key("copy"),
        ),
      ],
    );
  }

  Widget nullChapterRow(BuildContext context) {
    ///Empty
    return const SizedBox.shrink();
  }
}

///Dice pips to show reading length of chapter.
///Kind of worthless because the chapters are so short that you can almost see the next one
class _LengthSummaryWrap extends StatelessWidget {
  const _LengthSummaryWrap({
    required super.key,
    required this.chapter,
  });

  final Chapter? chapter;

  @override
  Widget build(BuildContext context) {
    int numDots = chapter?.data?.readingLength ?? 0;
    String message =
        chapter?.data != null ? 'Reading length' : 'Awaiting reading length...';
    return Tooltip(
        message: message,
        triggerMode: TooltipTriggerMode.tap,
        child: Container(
            height: 30 - 4,
            width: 30 - 4,
            decoration: BoxDecoration(
                // border: Border.all(
                //     color: NoirPrimary.shade4,
                //     width: 2,
                //     strokeAlign: BorderSide.strokeAlignCenter),
                color: NoirPrimary.shade4,
                borderRadius: BorderRadius.circular(6)),
            // margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: LengthSummaryWidget(
                  numDots: numDots,
                  dotSize: .666,
                  color: NoirPrimary.shadec,
                ))));
  }
}

class _CopyTextButton extends StatelessWidget {
  const _CopyTextButton({super.key});

  void onPressed(BuildContext context) {
    Chapter chapter = Chapter.of(context);
    chapter.data?.copyText();
  }

  @override
  Widget build(BuildContext context) {
    return StdAppBarButton(
      icon: Icons.copy_all,
      onPressed: () => onPressed(context),
      tooltip: 'Copy text',
    );
  }
}

class _SubtitleContainer extends StatelessWidget {
  const _SubtitleContainer({
    super.key,
    required this.chapter,
    required this.part,
    required this.child,
  });

  final Chapter? chapter;
  final Part part;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Color color =
    //     ElevationOverlay.applyOverlay(context, part.primary.s4, elevation);
    return Material(
        key: const Key("SubtitleMat"),
        type: MaterialType.transparency,

        // borderOnForeground: true,
        // color: part.primary.s4,
        // borderOnForeground: true,
        elevation: 0,
        child: Ink(
            decoration: BoxDecoration(
              color: part.primary.s5,
              //   gradient: LinearGradient(
              //       colors: [part.primary.s3, part.primary.s2],
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight),
              //   // border: Border(top: BorderSide(color: dividerColor, width: 1.5)),
            ),
            child: SizedBox(
                key: const Key("SubtitleBG"),
                height: 60,
                child: HeaderSizer(child: child))));
  }
}
