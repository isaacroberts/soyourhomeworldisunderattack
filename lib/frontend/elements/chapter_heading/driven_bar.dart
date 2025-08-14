import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/subtitle.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/title.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import '../../../backend/chapter_holder.dart';
import '../../theme/colors.dart';

class DrivenAppBar extends StatefulWidget {
  final ChapterHolder? chapter;
  final HeaderOfText? header;
  final Animation<double> animation;
  const DrivenAppBar(
      {required super.key,
      required this.chapter,
      required this.header,
      required this.animation});

  @override
  State<DrivenAppBar> createState() => _DrivenAppBarState();
}

class _DrivenAppBarState extends State<DrivenAppBar> {
  Animation<double> get animation => widget.animation;
  ChapterHolder? get chapter => widget.chapter;

  bool get fullyContracted => animation.value == 0;
  bool get partiallyExpanded => animation.value > 0;
  bool get fullyExpanded => animation.value >= 1;

  @override
  void initState() {
    chapter?.loadNotifier.addListener(chapterUpdated);
    super.initState();
  }

  void chapterUpdated() {
    if (mounted) {
      // dev.log("(Bar) Chapter updated: ${chapter?.varName}");
      setState(() {});
    }
  }

  Widget column(BuildContext context) {
    return Column(
      key: const Key("col"),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            key: const Key("row1Size"),
            height: 60,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                //Row

                child: HeadingTitleRow(
                    key: Key("Title${chapter?.key}"),
                    header: chapter?.chapter?.header,
                    chapter: chapter))),
        //Replaces divider with color change
        // const SizedBox(height: 6),

        Container(
            key: const Key("SubtitleBG"),
            height: 60,
            //Other 6 px of divider
            // padding: const EdgeInsets.only(top: 8),
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Primary.shade5, width: 1))
                // color: Color(0x2faaaaaa),
                // color: CanvasColor.shade1,
                ),
            //Only render child on expanded
            alignment: Alignment.center,
            child: ChapterHeadingSubtitle(
                key: Key("Subtitle${chapter?.key}"), chapter: chapter)),
      ],

      //Bookmark Button
    );
  }

  @override
  Widget build(BuildContext context) {
    return _OverflowWrap(key: const Key('overflow'), child: column(context));
  }
}

class _OverflowWrap extends StatelessWidget {
  final Widget child;
  const _OverflowWrap({required super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
            alignment: Alignment.topCenter, maxHeight: 120, child: child));
  }
}
