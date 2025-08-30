import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/parts/gn_colors.dart';

import '../../../../backend/chapter.dart';
import '../../../parts/part.dart';
import 'gn_subtitle.dart';
import 'gn_title.dart';

class GnBar extends StatelessWidget {
  const GnBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 60;
    const double expandedHeight = 120;
    Part part = Part.of(context);
    return Theme(
        data: part.theme,
        child: const SliverAppBar(
          key: Key("GnAppBar"),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          flexibleSpace: GnAppBar(key: Key("AppBar")),
          leadingWidth: 50,
          toolbarHeight: collapsedHeight,
          collapsedHeight: collapsedHeight,
          // collapsedHeight: expandedHeight,
          expandedHeight: expandedHeight,
          backgroundColor: GnPrimary.shade5,
          // surfaceTintColor: Color(0x00000000),
          // backgroundColor: CanvasColor.shade1,
          scrolledUnderElevation: 10,
          forceElevated: true,
          elevation: 10,
          shadowColor: Colors.black,

          // surfaceTintColor: CanvasColor.shaded,
          floating: true,
          snap: false,
          pinned: true,
          stretch: false,
        ));
  }
}

class GnAppBar extends StatelessWidget {
  const GnAppBar({required super.key});

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
  late Part part;

  @override
  void didChangeDependencies() {
    //Add listener
    chapter = Chapter.maybeOf(context);
    part = ChapterProvider.of(context).part;
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

                child: GnHeadingTitleRow(
                    key: Key("Title${chapter?.key}"),
                    header: chapter?.data?.header,
                    chapter: chapter))),
        //Replaces divider with color change
        // const SizedBox(height: 6),
        // const Divider(),
        _SubtitleContainer(
          key: const Key("subtitleContainer"),
          chapter: chapter,
          part: part,
        ),
      ],

      //Bookmark Button
    );
  }
}

class _SubtitleContainer extends StatelessWidget {
  const _SubtitleContainer({
    super.key,
    required this.chapter,
    required this.part,
  });

  final Chapter? chapter;
  final Part part;

  @override
  Widget build(BuildContext context) {
    return Container(
        key: const Key("SubtitleBG"),
        height: 60,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: GnPrimary.shade5, width: 1)),
          color: GnPrimary.shade4,
        ),
        //Only render child on expanded
        alignment: Alignment.center,
        child: GnChapterHeadingSubtitle(key: Key("Subtitle${chapter?.key}")));
  }
}
