import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../../backend/error_handler.dart';
import '../../../backend/part_id.dart';
import '../../chapter_heading/general/subtitle_components.dart';
import '../../chapter_heading/general/title.dart';
import '../../parts/all_parts.dart';
import '../../parts/noir_colors.dart';
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
  bool partsOnly = false;
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
          color: widget.part.primary.s5,
          height: expandedAppBarSize - appBarSize,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: subtitleButtons(context),
        ),
        //TODO: Extract widget

        Expanded(
            child: ScrollConfiguration(
                //TODO: Make second ScrollBehavior
                behavior: const ScrollBehavior(),
                child: SizedBox(
                    width: indexSidebarWidth,
                    child: ListView.builder(
                      controller: controller,
                      itemBuilder: itemBuilder,
                      prototypeItem: chapterTile(context, book.chapters[1]),
                      itemCount: partsOnly ? null : book.chapterAmt,
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
          icon: partsOnly ? Symbols.book_5 : Symbols.book_2,
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
    if (partsOnly) {
      //TODO: Store parts list
      var p = book.parts.toList(growable: false);
      if (index >= 0 && index < p.length) {
        return chapterTile(context, p[index]);
      }
    } else {
      if (index >= 0 && index < book.chapterAmt) {
        return chapterTile(context, book.chapters[index]);
      }
    }
    return null;
  }

  void currentChapterListener() {
    if (mounted) {
      if (pin) {
        scrollToCurrentChapter();
      }
      //TODO: Track part, setState if part changes
      setState(() {});
    }
  }

  ///Only show parts in index
  void togglePartsOnly() {
    setState(() {
      partsOnly = !partsOnly;
    });
    _scrollToCurrentAfterReload();
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
    final Widget? trailing = trailingWidget(context, chapter, part);
    if (chapter.isPart && !partsOnly) {
      return Container(
          decoration: BoxDecoration(
              color: part.primary.s6,
              border: Border.symmetric(
                  vertical: BorderSide(color: part.primary.s8))),
          child: ListTile(
            onTap: () => tileTapped(context, chapter),
            title: Text(
              chapter.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: headerFont(color: part.primary.sf, fontSize: 16),
            ),
            //This don't work
            tileColor: part.primary.s7,
            trailing: trailing,
          ));
    } else {
      return ListTile(
          // tileColor: NoirPrimary.shade5,
          onTap: () => tileTapped(context, chapter),
          title: Text(
            chapter.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: headerFont(color: part.primary.se, fontSize: 16),
          ),
          trailing: trailing);
    }
  }

  Widget? trailingWidget(BuildContext context, Chapter chapter, Part part) {
    if (currentChapter == chapter) {
      return const Icon(
        key: Key('bkMkr'),
        Icons.bookmark,
        color: NoirPrimary.shaded,
      );
    } else if (partsOnly) {
      //TODO: This will work once parts are fully integrated, i think
      if (currentChapter?.part == chapter.part) {
        return const Icon(
          key: Key('bkMkr'),
          Icons.bookmark_rounded,
          color: NoirPrimary.shaded,
        );
      }
    } else if (chapter.isPart) {
      Color color = part.primary.sd;
      return Icon(Symbols.book, color: color);
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
      double offset;
      if (partsOnly) {
        //There aren't enough parts to fill the screen
        offset = 0;
      } else {
        offset = (scrollTo.index) * tileHeight - 50;
        offset = math.max(0, offset);
      }
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
