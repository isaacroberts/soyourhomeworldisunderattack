import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../../backend/error_handler.dart';
import '../../../backend/part_id.dart';
import '../../chapter_heading/general/title.dart';
import '../../chapter_heading/header_elements.dart';
import '../../parts/all_parts.dart';
import '../../parts/part.dart';
import '../../theme/base_text_theme.dart';
import '../../theme/layout_constants.dart';
import '../../theme/timings.dart';
import 'logo.dart';

class SidebarIndex extends StatefulWidget {
  final Part part;
  final VoidCallback onCollapsed;
  final ValueNotifier<Chapter?> currentChapter;

  const SidebarIndex(
      {super.key,
      required this.currentChapter,
      required this.part,
      required this.onCollapsed});

  @override
  State<SidebarIndex> createState() => _SidebarIndexState();
}

class _SidebarIndexState extends State<SidebarIndex> {
  late ScrollController controller;
  late Book book;

  bool pin = false;
  // bool partsOnly = false;
  Chapter? get currentChapter => widget.currentChapter.value;

  @override
  void initState() {
    controller =
        ScrollController(keepScrollOffset: true, debugLabel: 'sidebarIndex');
    super.initState();
    widget.currentChapter.addListener(currentChapterListener);
  }

  @override
  void didChangeDependencies() {
    book = Book.of(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SidebarIndex oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.currentChapter.removeListener(currentChapterListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('indexCol'),
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Title
        SiteLogo(
          key: const Key('logo'),
          part: widget.part,
        ),
        Container(
          key: const Key('indexCtr'),
          decoration: BoxDecoration(
            color: widget.part.primary.s3,
            // border: Border.all(
            //     color: widget.part.primary.s5,
            //     strokeAlign: BorderSide.strokeAlignInside)
          ),
          height: expandedAppBarSize - appBarSize,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: subtitleButtons(context),
        ),
        //TODO: Extract widget

        Expanded(
            key: const Key('indexList'),
            child: ScrollConfiguration(
                //TODO: Make second ScrollBehavior
                behavior: const ScrollBehavior(),
                child: SizedBox(
                    width: indexSidebarWidth,
                    child: ListView.builder(
                      key: const Key('indexLV'),
                      controller: controller,
                      itemBuilder: itemBuilder,
                      // prototypeItem: partTile(context, 0),
                      itemCount: book.partAmt,
                      shrinkWrap: false,

                      // children: book.chapters.map(chapterTile).toList(growable: false),
                    ))))
      ],
    );
  }

  Widget subtitleButtons(BuildContext context) {
    PartId p = widget.part.id;
    return Row(
      children: [
        // StdAppBarButton(
        //   icon: Icons.menu,
        //   onPressed: openDrawer,
        //   tooltip: 'Open navigation',
        // ),
        StdAppBarButton(
          key: Key('partToggle_$p'),
          icon: Symbols.book_5, //: Symbols.book_2,
          onPressed: togglePartsOnly,
          tooltip: 'Show Parts',
        ),
        StdAppBarButton(
          key: Key('pin_$p'),
          icon: pin ? Symbols.keep : Symbols.keep_off,
          tooltip: null,
          onPressed: togglePin,
        ),
        //Separater
        const Expanded(child: SizedBox.shrink()),
        Tooltip(
            message: currentChapter?.displayName,
            child: ChapterNumber(
                key: Key('chpNum_$p'), index: currentChapter?.index)),

        StdAppBarButton(
          key: Key('hideToggle_$p'),
          icon: Symbols.hide,
          tooltip: 'Collapse',
          onPressed: onCollapsed,
          hilite: true,
        ),
        // StdAppBarButton(
        //   icon: Icons.keyboard_arrow_left,
        //   onPressed: onCollapsed,
        //   tooltip: 'Hide',
        // ),
      ],
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    if (index >= 0 && index < book.partAmt) {
      return partTile(context, index);
    }

    return null;
  }

  void currentChapterListener() {
    if (mounted) {
      if (pin) {
        scrollToCurrentChapter();
      }
      //Part changes upstream
      setState(() {});
    }
  }

  ///Only show parts in index
  void togglePartsOnly() {
    //TODO: Collapse all tiles
  }

  void togglePin() {
    setState(() {
      pin = !pin;
    });
    // If now pinned
    if (pin) {
      scrollToCurrentChapter();
    }
  }

  void onCollapsed() {
    widget.onCollapsed();
  }

  void tileTapped(BuildContext context, Chapter chapter) {
    onCollapsed();
    scrollToChapter(chapter, context: context);
  }

  Widget chapterTile(BuildContext context, Chapter chapter) {
    Part part = getPartImmediate(chapter.part);
    bool isCurrent = chapter == currentChapter;
    Widget? trailing = trailingWidget(context, chapter, part);
    trailing = SizedBox(width: 12, child: trailing);

    return Container(
        decoration:
            BoxDecoration(color: isCurrent ? part.primary.s4 : part.primary.s1),
        child: ListTile(
            // tileColor: NoirPrimary.shade5,
            onTap: () => tileTapped(context, chapter),
            title: Text(
              chapter.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: headerFont(color: part.primary.se, fontSize: 16),
            ),
            trailing: trailing));
  }

  Widget partTile(BuildContext context, int partIndex) {
    Chapter chapter = book.getPartStart(partIndex);
    Part part = getPartImmediate(chapter.part);
    bool isCurrent = chapter == currentChapter;

    return Container(
        decoration: BoxDecoration(
          color: isCurrent ? part.primary.s5 : part.primary.s3,
          // border: Border.symmetric(
          //     vertical: BorderSide(color: part.primary.s8))
        ),
        child: ExpansionTile(
          // onTap: () => tileTapped(context, chapter),
          title: Text(
            chapter.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: headerFont(color: part.primary.sf, fontSize: 16),
          ),
          children: book
              .getPartRange(partIndex)
              .map((c) => chapterTile(context, c))
              .toList(growable: false),
        ));
  }

  Widget? trailingWidget(BuildContext context, Chapter chapter, Part part) {
    Color color = widget.part.primary.sd;
    if (currentChapter == chapter) {
      if (chapter.isPart) {
        return Icon(
          key: const Key('bkMkr'),
          //Open book
          Symbols.book_5,
          color: color,
        );
      }
      return Icon(
        key: const Key('bkMkr'),
        //Corkboard pin
        Symbols.keep,
        color: color,
      );
    } else if (chapter.isPart) {
      //Closed book
      return Icon(Symbols.book_2, color: color);
    }
    return null;
  }

  void scrollToCurrentChapter() {
    Chapter? scrollTo = widget.currentChapter.value;
    if (scrollTo == null) {
      return;
    }
    if (mounted) {
      //TODO: Get current chapter from a static value
      const double tileHeight = 51;
      //TODO: This won't work anymore
      double offset = (scrollTo.index) * tileHeight - 50;
      offset = math.max(0, offset);

      controller.animateTo(offset,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut);
      //Ensures dot is visible
      setState(() {});
    }
  }

  void _scrollToCurrentAfterReload() async {
    //Give time to reload
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      //Scroll to current chapter
      //In case pinned
      scrollToCurrentChapter();
    } catch (exception, trace) {
      //I expect this to be finicky
      ErrorList.logWarning(exception, trace);
    }
  }
}
