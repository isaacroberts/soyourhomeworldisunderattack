import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/length_summary_widget.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/colors.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter_holder.dart';
import '../../../backend/error_handler.dart';
import '../../../backend/server.dart';
import '../../theme/color_scheme.dart';

const Color _subtitleColor = onCanvas;
const Color _subtitleDark = canvasSlightElevation;

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
    TextStyle style = bodyFont.copyWith(fontSize: 18, color: _subtitleColor);
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

class _VarnameChip extends StatelessWidget {
  const _VarnameChip({
    required super.key,
    required this.chapter,
  });

  final ChapterHolder? chapter;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Tooltip(
            message: chapter?.filename ?? '-',
            child: Chip(
              // avatar: Icon(Icons.ac_unit),
              label: Text(
                chapter?.varName ?? '-',
              ),
              // selected: false,
              // onSelected: (bool value) {},
            )));
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
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: colorScheme.primaryFixedDim,
        border: BoxBorder.all(color: colorScheme.outlineVariant, width: 2),
        borderRadius: BorderRadius.circular(9),
      ),
      // child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: LengthSummaryWidget(
        numDots: chapter?.chapter?.readingLength ?? 1,
        dotSize: 1,
        color: colorScheme.onPrimaryFixedVariant,
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  final ChapterHolder? chapter;
  const BookmarkButton({required super.key, required this.chapter});
  Color get color => Primary.shadee.withAlpha(128);
  String get url => '$displayURL/search/${chapter?.varName}';

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: url,
        child: IconButton(
            padding: const EdgeInsets.all(6),
            onPressed: chapter != null
                ? () {
                    context.go('/search/${chapter?.varName}');
                    // Clipboard.setData(ClipboardData(text: url));
                  }
                : null,
            icon: Icon(
              Icons.bookmark,
              color: color ?? _subtitleColor,
              size: 24,
            )));
  }
}

class CurrentChip extends StatelessWidget {
  final String? value;
  final String label;
  final IconData? icon;

  const CurrentChip(
      {required super.key,
      required this.value,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox.shrink();
    } else {
      return Padding(
          key: const Key("lpad"),
          padding: const EdgeInsets.only(right: 12),
          child: Tooltip(
              key: const Key("tooltip"),
              message: label,
              child: Chip(
                  key: const Key("chip"),
                  avatar: icon != null ? Icon(icon) : null,
                  label: Text(value!))));
    }
  }
}

class FutureChip extends StatelessWidget {
  final Future<String?>? value;
  final String label;
  final IconData? icon;
  const FutureChip(
      {required super.key,
      required this.value,
      required this.label,
      required this.icon});

  Widget buildChip(BuildContext context, String value) {
    return CurrentChip(
        key: const Key('currentChpi'), value: value, label: label, icon: icon);
  }

  Widget buildNoData(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget buildError(BuildContext context, String error) {
    return Padding(
        key: const Key("lpad"),
        padding: const EdgeInsets.only(right: 12),
        child: Tooltip(
            key: const Key("tooltip"),
            message: error,
            child: Chip(
                key: const Key("chip"),
                avatar: icon != null ? const Icon(Icons.error_outline) : null,
                label: const Text('   '))));
  }

  Widget buildWaiting(BuildContext context) {
    return Padding(
        key: const Key("lpad"),
        padding: const EdgeInsets.only(right: 12),
        child: Chip(
            key: const Key("chip"),
            avatar: icon != null ? const Icon(Icons.hourglass_empty) : null,
            label: const Text(' ')));
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot<String?> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        return buildChip(context, snapshot.data!);
      } else {
        return buildNoData(context);
      }
    } else if (snapshot.hasError) {
      ErrorList.logError(snapshot.error!, snapshot.stackTrace);
      return buildError(context, snapshot.error!.toString());
    } else {
      return buildWaiting(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return buildNoData(context);
    }
    return FutureBuilder<String?>(
        key: const Key("futureBuilder"),
        future: value!,
        builder: futureBuilder);
  }
}
