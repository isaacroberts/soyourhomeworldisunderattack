import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/subtitle.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/title.dart';

import '../../../backend/chapter.dart';
import '../../theme/colors.dart';

class DrivenAppBar extends StatelessWidget {
  const DrivenAppBar({required super.key});

  @override
  Widget build(BuildContext context) {
    return const ClipRRect(
        key: Key("clip"),
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
            key: Key('overflow'),
            alignment: Alignment.topCenter,
            maxHeight: 120,
            child: _AppBarCol(key: Key("appBar"))));
  }
}

class _AppBarCol extends StatefulWidget {
  const _AppBarCol({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _AppBarColState();
}

class _AppBarColState extends State<_AppBarCol> {
  late Chapter? chapter;

  @override
  void didChangeDependencies() {
    //Add listener
    chapter = Chapter.maybeOf(context);
    chapter?.loadNotifier.addListener(chapterUpdated);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //Remove listener
    chapter?.loadNotifier.removeListener(chapterUpdated);
    super.dispose();
  }

  void chapterUpdated() {
    if (mounted) {
      //Header, accessed from chapter, won't update on change
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    header: chapter?.data?.header,
                    chapter: chapter))),
        //Replaces divider with color change
        // const SizedBox(height: 6),

        _SubtitleContainer(
            key: const Key("subtitleContainer"), chapter: chapter),
      ],

      //Bookmark Button
    );
  }
}

class _SubtitleContainer extends StatelessWidget {
  const _SubtitleContainer({
    super.key,
    required this.chapter,
  });

  final Chapter? chapter;

  @override
  Widget build(BuildContext context) {
    return Container(
        key: const Key("SubtitleBG"),
        height: 60,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Primary.shade5, width: 1))),
        //Only render child on expanded
        alignment: Alignment.center,
        child: ChapterHeadingSubtitle(key: Key("Subtitle${chapter?.key}")));
  }
}
