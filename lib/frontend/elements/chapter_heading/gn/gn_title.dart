import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/chapter_grid.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../../backend/book.dart';
import '../../../../backend/chapter.dart';
import '../../../components/marquee_text.dart';
import '../../../parts/part.dart';
import '../../holders/textholders.dart';

class GnHeadingTitleRow extends StatelessWidget {
  const GnHeadingTitleRow({
    super.key,
    required this.chapter,
    required this.header,
  });

  final Chapter? chapter;
  final HeaderOfText? header;

  @override
  Widget build(BuildContext context) {
    late final Color headerColor;
    late final TextStyle headerStyle;
    HeaderOfText? header = this.header;
    /*
    if (header is CustomHeaderOfText) {
      headerColor = header.font.color ?? headerColor;

      //TODO: Figure out Rubik headers issue
      // Then Use Holder element so CustomHeaders can be shown
      //TODO: Fallback instancing?
      // headerStyle = header.font.instance();
      //TODO: This is disabling header styles
      headerStyle = _headerFont;
    } else {
      headerColor = headerColor;
      headerStyle = _headerFont;
    }*/

    Part part = ChapterProvider.of(context).part;
    headerColor = part.primary.sf;
    headerStyle = TextStyle(
        fontFamily: 'Rubik',
        fontSize: 24,
        fontWeight: FontWeight.w200,
        color: headerColor);

    double screenWidth = MediaQuery.sizeOf(context).width;

    String headerText = header?.text ?? '...';

    // Widget title = Text(
    //   key: const Key("titleText"),
    //   headerText,
    //   style: headerStyle,
    //   textAlign: TextAlign.center,
    //   maxLines: 1,
    //   overflow: TextOverflow.ellipsis,
    // );

    //Too slow
    Widget title = MarqueeText.lazy(
      key: Key("MarqueeText_$headerText"),
      text: headerText,
      style: headerStyle,
      alignment: Alignment.center,
    );

    if (screenWidth < 400) {
      return SizedBox(
          height: 40,
          child: Center(
            child: title,
          ));
    }

    return Row(
      key: const Key("headerRow"),
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Bookmark button
        _ChapterNumberWrap(
            key: Key("bookmarkButton${chapter?.key}"),
            chapterNumber: chapter?.id,
            headerColor: headerColor),
        //Title
        Expanded(key: const Key("titleTitle"), child: Center(child: title)),
        //Space for drawerbutton
        const SizedBox(width: 60),
      ],
    );
  }
}

class _ChapterNumberWrap extends StatefulWidget {
  const _ChapterNumberWrap({
    super.key,
    required this.chapterNumber,
    required this.headerColor,
  });

  final int? chapterNumber;
  final Color headerColor;

  @override
  State<StatefulWidget> createState() => _ChapterNumberWrapState();
}

class _ChapterNumberWrapState extends State<_ChapterNumberWrap> {
  void onSelected(int ix) {
    Book book = Book.of(context);
    //Get chapter
    Chapter chapter = book.chapters[ix];
    //Use customized scroll
    scrollToChapter(chapter, context: context);
  }

  void onClicked() {
    ChapterSelectorGrid.pushChapterSelectorGrid(context,
        onChapterSelected: onSelected,
        book: Book.of(context),
        //Title does not have a scrollable
        show0: false);
  }

  Widget buttonBuilder(
      BuildContext context, MenuController controller, Widget? child) {
    return TextButton(
        key: const Key('TextButton'),
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: child ?? const Text('err'));
  }

  @override
  Widget build(BuildContext context) {
    Part part = ChapterProvider.partOf(context);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: SizedBox(
            width: 60,
            child: MenuAnchor(
                consumeOutsideTap: false,

                // childFocusNode: FocusNode(),
                menuChildren: [
                  SizedBox(
                      width: 400,
                      height: 200,
                      child: ChapterSelectorWidget(
                        onChapterSelected: onSelected,
                        show0: false,
                      )),
                ],
                builder: buttonBuilder,
                child: Text(
                  key: const Key("ChapterNumber"),
                  '${widget.chapterNumber}.',
                  style: part.bodyFont
                      .copyWith(fontSize: 18, color: widget.headerColor),
                ))));
  }
}
