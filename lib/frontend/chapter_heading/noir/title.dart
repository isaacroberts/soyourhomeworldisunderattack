import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/noir/subtitle_components.dart';
import 'package:soyourhomeworld/frontend/pages/index/dropdown_chapter_names.dart';

import '../../../../backend/chapter.dart';
import '../../elements/holders/textholders.dart';
import '../../parts/part.dart';
import '../../theme/base_text_theme.dart';

class AppBarTitleOnly extends StatelessWidget {
  const AppBarTitleOnly({super.key});

  @override
  Widget build(BuildContext context) {
    Chapter? chapter = Chapter.maybeOf(context);
    return HeadingTitleRow(
        key: Key("Title${chapter?.key}"),
        header: chapter?.data?.header,
        chapter: chapter);
  }
}

class HeadingTitleRow extends StatefulWidget {
  const HeadingTitleRow({
    super.key,
    required this.chapter,
    required this.header,
  });

  //You already have to have the Header
  final Chapter? chapter;
  final HeaderOfText? header;

  @override
  State<StatefulWidget> createState() => _HeadingTitleState();
}

class _HeadingTitleState extends State<HeadingTitleRow> {
  late final MenuController menuController;

  @override
  void initState() {
    menuController = MenuController();
    super.initState();
  }

  Chapter? get chapter => widget.chapter;
  HeaderOfText? get header => widget.header;

  @override
  Widget build(BuildContext context) {
    Widget title = RawTitleRow(
      chapter: chapter,
    );

    title = RawMenuAnchor(
        controller: menuController,
        overlayBuilder: overlayBuilder,
        child: title);
    title = TextButton(onPressed: () => menuController.open(), child: title);
    title = HeaderSizer(child: title);

    return SizedBox(
        height: 60,
        child: Padding(
            //Standard left gutter, then space for drawer
            padding: const EdgeInsets.only(left: 0, right: 36),
            child: title));
  }

  Widget overlayBuilder(BuildContext context, RawMenuOverlayInfo info) {
    // dev.log("MenuANchor Info: ${info.anchorRect}");
    return Positioned(
        //Extra padding
        top: info.anchorRect.top - 12,
        left: info.anchorRect.left,
        child: SizedBox(
            width: info.anchorRect.width + 24,
            // height: info.anchorRect.height,
            //TODO: Switch this to regular sizing
            height: MediaQuery.sizeOf(context).height,
            child: ChapterTitleDropdown(
              startChapter: chapter,
            )));
  }
}

class RawTitleRow extends StatelessWidget {
  final Chapter? chapter;
  final bool small;
  const RawTitleRow({super.key, required this.chapter, this.small = false});

  @override
  Widget build(BuildContext context) {
    late TextStyle headerStyle;
    // late final Color headerColor;
    HeaderOfText? header = chapter?.data?.header;
    if (header is CustomHeaderOfText) {
      // headerColor = header.font.color ?? headerColor;

      //TODO: Figure out Rubik headers issue
      // Then Use Holder element so CustomHeaders can be shown
      //TODO: Fallback instancing?
      // headerStyle = header.font.instance();
      //TODO: This is disabling header styles
      headerStyle = headerFont;
    } else {
      // headerColor = textColor;
      headerStyle = headerFont;
    }

    if (small) {
      headerStyle = headerStyle.copyWith(fontSize: 16);
    }

    String headerText = header?.text ?? chapter?.displayTitle ?? '...';

    Widget title = Text(
      key: const Key("titleText"),
      headerText,
      style: headerStyle,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    //Too slow
    // Widget title = MarqueeText.lazy(
    //   key: Key("MarqueeText_$headerText"),
    //   text: headerText,
    //   style: headerStyle,
    //   alignment: Alignment.center,
    // );

    //This sizes the button to the width of the text, not the full bar
    // title = Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 12), child: title);
    // title = HeaderSizer(child: title);
    title = Align(alignment: Alignment.centerLeft, child: title);
    return title;
    //This adds the chapter number, which I thought looks ugly
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(key: const Key('e'), child: title),
//Chapter number
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: ChapterNumber(index: chapter?.index)),
      ],
    );
  }
}

///Modernized
class ChapterNumber extends StatelessWidget {
  // final Chapter? chapter;
  final int? index;
  const ChapterNumber({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Part part = Part.of(context);
    return Container(
        key: const Key('chapNumber'),
        //Must be this wide for

        width: 36,
        height: 36,
        decoration: BoxDecoration(
            color: part.primary.s3, borderRadius: BorderRadius.circular(3)),
        //borderRadius: BorderRadius.circular(3),
        alignment: Alignment.center,
        // margin: const EdgeInsets.symmetric(vertical: 12),
        // padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          _chapterNumberToText(index),
          style: headerFont.copyWith(fontSize: 16),
        ));
  }
}

String _chapterNumberToText(int? index) {
  if (index == null) {
    return '?';

    // } else if (index < 100) {
    //   return '#$index';
  } else {
    //3 digit numbers are too wide, and the # is visually confusing
    return index.toString();
  }
}
