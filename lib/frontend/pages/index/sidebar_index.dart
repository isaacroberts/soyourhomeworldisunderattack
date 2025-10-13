import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/noir/subtitle_components.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/chapter_progress_indicator.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/noir_colors.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/layout_constants.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../../backend/error_handler.dart';
import '../../parts/part.dart';

class SidebarIndex extends StatefulWidget {
  final ValueNotifier<Chapter?> currentChapter;
  const SidebarIndex({required super.key, required this.currentChapter});

  @override
  State<SidebarIndex> createState() => _SidebarIndexState();
}

//Pro-gamer move to preserve state
bool expanded = false;

class _SidebarIndexState extends State<SidebarIndex> {
  late ScrollController controller;
  late Book book;

  Chapter? get currentChapter => widget.currentChapter.value;

  bool pin = false;
  bool partsOnly = false;

  @override
  void initState() {
    controller = ScrollController(keepScrollOffset: true);
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

  void currentChapterListener() {
    if (mounted) {
      if (pin) {
        scrollToCurrentChapter();
      }
      setState(() {});
    }
  }

  void scrollToCurrentChapter() {
    Chapter? scrollTo = widget.currentChapter.value;
    if (scrollTo == null) {
      return;
    }
    if (mounted && expanded) {
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

  void togglePin() {
    setState(() {
      pin = !pin;
    });
    // If now pinned
    if (pin) {
      scrollToCurrentChapter();
    }
  }

  void openDrawer() {
    Scaffold.of(context).openEndDrawer();
  }

  Widget subtitleButtons(BuildContext context) {
    return Row(
      children: [
        // StdAppBarButton(
        //   icon: Icons.menu,
        //   onPressed: openDrawer,
        //   tooltip: 'Open navigation',
        // ),
        StdAppBarButton(
          icon: partsOnly ? Symbols.book_5 : Symbols.book_2,
          onPressed: togglePartsOnly,
          tooltip: 'Show Parts',
        ),
        StdAppBarButton(
          icon: pin ? Symbols.keep : Symbols.keep_off,
          tooltip: null,
          onPressed: togglePin,
        ),
        //Separater
        const Expanded(child: SizedBox.shrink()),
        _TogglingExpandoButton(
            key: const Key('toggleExp'),
            expanded: expanded,
            onPressed: onCollapsed),
        // StdAppBarButton(
        //   icon: Icons.keyboard_arrow_left,
        //   onPressed: onCollapsed,
        //   tooltip: 'Hide',
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: expanded ? indexSidebarWidth : collapsedIndexWidth,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                NoirPrimary.shade3,
                NoirPrimary.shade4,
              ],
              stops: [0, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            // color: Color(0xffefefef),
            // backgroundBlendMode: BlendMode.colorBurn,
            border: Border(right: BorderSide(color: NoirPrimary.shade2))),
        alignment: Alignment.topLeft,
        child: expanded ? expandedView(context) : collapsedView(context));
  }

  Column expandedView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Title
        const SiteLogo(),
        Container(
          color: NoirPrimary.shade5,
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

  Widget collapsedView(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Title (one letter )
          const CollapsedSiteLogo(),
          SizedBox(
              // color: NoirPrimary.shade5,
              height: expandedAppBarSize - appBarSize,
              // alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                // child: StdAppBarButton(
                //   icon: Icons.arrow_forward_ios,
                //   onPressed: onExpanded,
                // )
                child: _TogglingExpandoButton(
                    key: const Key('toggleExp'),
                    expanded: expanded,
                    onPressed: onExpanded),
              )),
          const Expanded(child: SizedBox.shrink()),

          Padding(
              padding: const EdgeInsets.all(12),
              child: ReadingProgressIndicator(
                key: const Key('progress'),
                chapter: currentChapter?.index,
                totalChapters: book.chapterAmt,
                color: NoirPrimary.shadec,
              ))
        ]);
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

  Widget? trailingWidget(BuildContext context, Chapter chapter, Part part) {
    if (currentChapter == chapter) {
      return const Icon(
        key: Key('bkMkr'),
        Icons.bookmark,
        color: NoirPrimary.shaded,
      );
      ;
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

  void tileTapped(BuildContext context, Chapter chapter) {
//TODO: If smaller than maxReaderWidth, collapse after click
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
              style: headerFont.copyWith(color: part.primary.sf, fontSize: 16),
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
            style: headerFont.copyWith(color: part.primary.sd, fontSize: 16),
          ),
          trailing: trailing);
    }
  }

// === Callbacks ==========
  void onCollapsed() {
    setState(() {
      expanded = false;
    });
  }

  void onExpanded() {
    setState(() {
      expanded = true;
    });
    _scrollToCurrentAfterReload();
  }

  ///Only show parts in index
  void togglePartsOnly() {
    setState(() {
      partsOnly = !partsOnly;
    });
    _scrollToCurrentAfterReload();
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

///Just the word Homeworld to show you what site you're on
class SiteLogo extends StatelessWidget {
  const SiteLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        key: const Key('logoCtr'),
        decoration: const BoxDecoration(
            color: NoirPrimary.shade4,
            border: Border(
                bottom: BorderSide(color: NoirPrimary.shade2, width: 1))),
        height: appBarSize,
        padding: const EdgeInsets.all(12),
        alignment: Alignment.centerLeft,
        child: TextButton(
            key: const Key('logoButton'),
            onPressed: () {},
            child: const Text(
              key: Key('logoTxt'),
              'Homeworld',
              style: headerFont,
              textAlign: TextAlign.start,
            )));
  }
}

///Just the letter H. To show you what site you're on
class CollapsedSiteLogo extends StatelessWidget {
  const CollapsedSiteLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: 'Homeworld.help',
        child: Container(
            key: const Key('logoCtr'),
            decoration: const BoxDecoration(
              color: NoirPrimary.shade4,
              // border: Border(
              //     bottom: BorderSide(color: NoirPrimary.shade2, width: 1)),
            ),
            height: appBarSize,
            // padding: const EdgeInsets.all(12),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            child: TextButton(
                key: const Key('logoButton'),
                onPressed: () {},
                child: const Text(
                  key: Key('lgoTxt'),
                  'H',
                  style: headerFont,
                  textAlign: TextAlign.start,
                ))));
  }
}

class _TogglingExpandoButton extends StatelessWidget {
  final bool expanded;
  final VoidCallback onPressed;
  const _TogglingExpandoButton(
      {required super.key, required this.expanded, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: key.toString(),
        child: Tooltip(
            message: expanded ? 'Collapse' : 'Index',
            child: StdAppBarButton(
              key: const Key('expToggle'),
              icon: expanded ? Symbols.hide : Symbols.menu_book_rounded,
              onPressed: onPressed,
            )));
  }
}
