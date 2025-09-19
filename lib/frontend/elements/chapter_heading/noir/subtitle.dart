import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/length_summary_widget.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/noir/subtitle_components.dart';

import '../../../../backend/book.dart';
import '../../../../backend/chapter.dart';
import '../../../../backend/chapter_data.dart';
import '../../../parts/noir_colors.dart';
import '../../../parts/part.dart';

class ChapterHeadingSubtitle extends StatelessWidget
    implements PreferredSizeWidget {
  const ChapterHeadingSubtitle({required super.key});

  bool get center => false;

  @override
  Widget build(BuildContext context) {
    ChapterProvider provider = ChapterProvider.of(context);

    Chapter? chapter = provider.chapter;
    late Widget scrollRow;
    if (chapter?.extra?.hasAnyChips ?? false) {
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
    scrollRow = Row(
      children: [
        BookmarkButton(key: const Key('bookmark'), chapter: chapter),
        Expanded(child: scrollRow),
        //Fake pad
        const SizedBox(width: 6),
        _LengthSummaryWrap(key: const Key('lsw'), chapter: chapter),
        const SizedBox(width: 12),
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
    if (chapter == null) {
      return nullChapterRow(context);
    } else if (chapter.data == null) {
      return nullChapterRow(context);
      //These futures are causing every chapter to load at once
      return futuresRow(context, chapter);
    } else if (chapter.extra!.hasAnyChips) {
      return completedRow(context, chapter);
    } else {
      return const SizedBox.shrink();
      return noChipsRow(context, chapter);
    }
  }

  Widget futuresRow(BuildContext context, Chapter chapter) {
    ///For waiting on chapter
    return Row(
        key: const Key("heading_row"),
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // BookmarkButton(key: const Key("bookmark"), chapter: chapter),
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
          // _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
          //Don't add copyButton while waiting on futures
        ]);
  }

  Widget noChipsRow(BuildContext context, Chapter chapter) {
    return const _CopyTextButton(key: Key('copyButton'));
    return const SizedBox.shrink();

    ///No waiting on futures
    return Row(
      key: const Key("heading_row"),
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BookmarkButton(key: const Key("bookmark"), chapter: chapter),
        const Expanded(child: SizedBox.shrink()),
        _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
        const _CopyTextButton(
          key: Key("copy"),
        ),
      ],
    );
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
        CurrentChip(
            key: const Key("Subtitle"),
            value: extra.subtitle,
            label: 'Subtitle',
            icon: null),
        CurrentChip(
            key: const Key("Where"),
            value: extra.where,
            label: 'Where',
            icon: Icons.public),
        CurrentChip(
            key: const Key("When"),
            value: extra.when,
            label: 'When',
            icon: Icons.access_time),
        // _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
        const _CopyTextButton(
          key: Key("copy"),
        ),
      ],
    );
  }

  Widget nullChapterRow(BuildContext context) {
    ///Empty
    return const SizedBox.shrink();
    return const Row(
        key: Key("heading_row"),
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BookmarkButton(key: Key("bookmark"), chapter: null),
          _LengthSummaryWrap(key: Key("lsw"), chapter: null),
          //No copyButton, since no chapter to copy
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
    int numDots = chapter?.data?.readingLength ?? 0;
    String message = chapter?.data != null
        ? 'Reading length: ${ChapterData.readingLengthDescriptor(numDots)}'
        : 'Awaiting reading length...';
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
                color: NoirPrimary.shadee.withAlpha(128),
                borderRadius: BorderRadius.circular(6)),
            // margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),

                //Because there's no onClick
                // excludeFromSemantics: true,
                // child: Chip(
                //     key: const Key("LSW_Chip"),
                // child: SizedBox(
                //     width: 24,
                //     height: 24,
                child: LengthSummaryWidget(
                  numDots: numDots,
                  dotSize: .666,
                  color: NoirPrimary.shade4,
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
    Color color = ChapterProvider.partOf(context).primary.se.withAlpha(128);

    return Tooltip(
        message: 'Copy chapter',
        child: IconButton(
            onPressed: () => onPressed(context),
            padding: const EdgeInsets.all(6),
            icon: Icon(
              Icons.copy_all,
              color: color,
            )));
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
    double elevation = 15;
    // Color dividerColor =
    //     ElevationOverlay.applyOverlay(context, part.primary.s6, elevation);
    Color dividerColor = part.primary.s6;
    Color color =
        ElevationOverlay.applyOverlay(context, part.primary.s4, elevation);
    return Material(
        key: const Key("SubtitleMat"),
        type: MaterialType.transparency,

        // borderOnForeground: true,
        // color: part.primary.s4,
        borderOnForeground: true,
        elevation: elevation,
        child: Ink(
            decoration: BoxDecoration(
              color: color,
              border: Border(top: BorderSide(color: dividerColor, width: 1.5)),
            ),
            child: SizedBox(
                key: const Key("SubtitleBG"), height: 60, child: child)));
  }
}
