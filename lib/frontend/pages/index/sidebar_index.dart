import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/noir/subtitle_components.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/noir_colors.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/layout_constants.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../parts/part.dart';

class SidebarIndex extends StatefulWidget {
  final ValueNotifier<Chapter?> currentChapter;
  const SidebarIndex({required super.key, required this.currentChapter});

  @override
  State<SidebarIndex> createState() => _SidebarIndexState();
}

class _SidebarIndexState extends State<SidebarIndex> {
  late ScrollController controller;
  late Book book;

  Chapter? get currentChapter => widget.currentChapter.value;

  bool pin = false;

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
    if (mounted) {
      //TODO: Get current chapter from a static value
      const double tileHeight = 51;
      double offset = (scrollTo.index) * tileHeight - 50;
      offset = math.max(0, offset);
      controller.animateTo(offset,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut);
      //Ensures dot is visible
      setState(() {});
    }
  }

  OverlayEntry? overlay;

  Widget overlayPartTile(Chapter part) {
    return ListTile(
      onTap: () {
        scrollToChapter(part, context: context);
        overlay?.remove();
        overlay = null;
      },
      title: Text(
        part.displayName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: headerFont.copyWith(color: NoirPrimary.shaded, fontSize: 16),
      ),
    );
  }

  Widget overlayBuilder(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              width: indexSidebarWidth,
              height: 400,
              child: Material(
                  color: NoirPrimary.shade4,
                  borderRadius: BorderRadius.circular(12),
                  child: ListView(
                    children:
                        book.parts.map(overlayPartTile).toList(growable: false),
                  )),
            )));
  }

  void showMenuOverlay() {
    overlay?.remove();
    overlay = OverlayEntry(builder: overlayBuilder);
    Navigator.of(context).overlay?.insert(overlay!);
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
          icon: Symbols.book_5,
          onPressed: showMenuOverlay,
          tooltip: 'Parts',
        ),
        Expanded(child: SizedBox.shrink()),
        StdAppBarButton(
          icon: pin ? Symbols.keep_off : Symbols.keep,
          tooltip: null,
          onPressed: togglePin,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: NoirPrimary.shade4,
                    border: Border(
                        bottom:
                            BorderSide(color: NoirPrimary.shade2, width: 1))),
                height: appBarSize,
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Homeworld',
                      style: headerFont,
                    ))),
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
                    child: ListView.builder(
                      controller: controller,
                      itemBuilder: itemBuilder,
                      prototypeItem: chapterTile(context, book.chapters[1]),
                      itemCount: book.chapterAmt,
                      shrinkWrap: false,

                      // children: book.chapters.map(chapterTile).toList(growable: false),
                    )))
          ],
        ));
  }

  Widget? itemBuilder(BuildContext context, int index) {
    if (index >= 0 && index < book.chapterAmt) {
      return chapterTile(context, book.chapters[index]);
    }
    return null;
  }

  Widget chapterTile(BuildContext context, Chapter chapter) {
    bool isCurrent = currentChapter == chapter;
    Part part = getPartImmediate(chapter.part);
    if (chapter.isPart) {
      return ListTile(
        title: Text(
          chapter.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: headerFont.copyWith(color: part.primary.se, fontSize: 16),
        ),
        tileColor: part.primary.s7,
        trailing: isCurrent
            ? const _CurrentChapterMarker()
            : const Icon(Icons.expand_less),
      );
    } else {
      return ListTile(
          // tileColor: NoirPrimary.shade5,
          onTap: () => scrollToChapter(chapter, context: context),
          title: Text(
            chapter.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: headerFont.copyWith(color: part.primary.sd, fontSize: 16),
          ),
          trailing: isCurrent ? const _CurrentChapterMarker() : null);
    }
  }
}

class _CurrentChapterMarker extends StatelessWidget {
  const _CurrentChapterMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // const Hero(
        //   tag: 'CurrentIcon',
        //   child:
        const Icon(
      key: Key('bkMkr'),
      Icons.bookmark_outline,
      color: NoirPrimary.shaded,
    );
  }
}
