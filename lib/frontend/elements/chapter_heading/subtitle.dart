import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/length_summary_widget.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/colors.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter_holder.dart';
import '../../../backend/server.dart';
import '../../theme/color_scheme.dart';

const Color _subtitleColor = onCanvas;
const Color _subtitleDark = canvasSlightElevation;

class ChapterHeadingSubtitle extends StatelessWidget {
  final ChapterHolder? chapter;
  const ChapterHeadingSubtitle({super.key, required this.chapter});

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
                child: Row(
                  key: const Key("heading_row"),
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Placeholder for BookmarkButton
                    // const SizedBox(
                    //   width: 96,
                    // ),
                    BookmarkButton(
                        key: const Key("bookmark"),
                        chapter: chapter,
                        color: Primary.shadee.withAlpha(128)),
                    _LengthSummaryWrap(key: const Key("lsw"), chapter: chapter),
                    // const SizedBox(
                    //   width: 6,
                    // ),
                    _VarnameChip(
                        key: Key('varname_chip_${chapter?.varName}'),
                        chapter: chapter),
                  ],
                ))));
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

    return Tooltip(
        message: tooltip,
        child: Container(
            width: 120,
            height: 30,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _subtitleDark, borderRadius: BorderRadius.circular(6)),
            child: Text(
              'Chapter ${chapter?.id ?? '-'}',
              style: style,
              maxLines: 1,
              textAlign: TextAlign.center,
            )));
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

class _VarnameChip extends StatelessWidget {
  const _VarnameChip({
    super.key,
    required this.chapter,
  });

  final ChapterHolder? chapter;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
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
    super.key,
    required this.chapter,
  });

  final ChapterHolder? chapter;

  @override
  Widget build(BuildContext context) {
    return Chip(
        key: const Key("LSW_Chip"),
        label: SizedBox(
            width: 24,
            height: 20,
            child: LengthSummaryWidget(
              numDots: chapter?.chapter?.readingLength ?? 3,
              dotSize: .5,
              color: Primary.shadee,
            )));
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
  final Color? color;
  const BookmarkButton(
      {super.key, required this.chapter, this.color = _subtitleColor});

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
