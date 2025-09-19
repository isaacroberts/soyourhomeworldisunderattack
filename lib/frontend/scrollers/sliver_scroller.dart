import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/theme_changing_scaffold.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/grand_swatch.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../backend/start_chapter.dart';
import '../elements/chapter_heading/heading_data.dart';
import '../icons.dart';
import '../pages/title/title.dart';
import '../parts/noir_colors.dart';
import '../parts/noir_part.dart';
import '../parts/part.dart';
import '../slivers/chapter_sliver.dart';
import '../slivers/null_slivers.dart';
import '../theme/base_colors.dart';
import '../theme/timings.dart';

//TODO: Move
const Part defaultPart = PartNoir();

class SliverScroller extends StatefulWidget {
  // final Book book;
  // final int? startChapter;

  final StartChapter startChapter;

  const SliverScroller({super.key, required this.startChapter});

  @override
  State<SliverScroller> createState() => _SliverScrollerState();
}

//TODO: Move to central file
//TODO: Save current chapter to users machine
void setCurrentChapter(int ix) async {}
Future<int?> getStartChapter() async {
  return null;
}

class _SliverScrollerState extends State<SliverScroller> {
  late Book book;

  // int get startChapter => widget.startChapter ?? 0;
  int? get firstLoadedChapter => chapters.isEmpty ? null : chapters.first.index;
  int get endChapter => chapters.isEmpty ? 0 : chapters.last.index;
  final List<Chapter> chapters = [];

  Chapter? currentChapter;
  //This is needed for the background
  late Part part;
  // Map<Chapter, double> chapterPositions = {};

  late final ScrollController controller;

  @override
  void initState() {
    ScrollController? c = Scrollable.maybeOf(context)?.widget.controller;
    dev.log("Had scroll controller: ${c != null}");
    controller = c ??
        ScrollController(
            debugLabel: 'SliverScrollController',
            onAttach: scrollControllerAttach,
            keepScrollOffset: true);
    controller.addListener(scrollNotification);
    super.initState();
  }

  void scrollControllerAttach(ScrollPosition pos) {
    //TODO: Check this in various functions to reduce UI load
    // Scrollable.of(context).position.recommendDeferredLoading(context);
    //TODO:
  }

  @override
  void didChangeDependencies() {
    dev.log(
        "(SlvScroller: didChangeDependencies() start=${widget.startChapter}");

    //This is where InheritedWidgets update
    book = Book.of(context);

    part = defaultPart;

    if (chapters.isEmpty) {
      populateAtStart();
    } else {
      updateChapters();
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SliverScroller oldWidget) {
    dev.log("(SlvScroller: didUpdateWidget()start=${widget.startChapter}");

    super.didUpdateWidget(oldWidget);
    //If chapter changed
    if (widget.startChapter != oldWidget.startChapter) {
      updateChapters();
    }
  }

  Future<void> scrollDelayed(Chapter? chapter) async {
    if (chapter == null) {
      return;
    }
    if (kDebugMode) {
      //It slows down the computer too much
      return;
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    //Scroll to new chapter
    //The null context doesn't allow it to retry by loading the SliverScroller
    scrollToChapter(chapter, context: mounted ? context : null);
  }

  Future<bool> scrollUpDelayed(Chapter? chapter) async {
    if (chapter == null) {
      return false;
    }
    if (kDebugMode) {
      //It slows down the computer too much
      return false;
    }
    updateView();
    await Future.delayed(const Duration(milliseconds: 500));
    //Scroll to new chapter
    //The null context doesn't allow it to retry by loading the SliverScroller
    BuildContext? keyContext = chapter.globalKey.currentContext;
    if (keyContext == null || !keyContext.mounted) {
      //Minor error
      return false;
    }
    // await Future.delayed(Duration(milliseconds: 300));
    await Scrollable.ensureVisible(keyContext, duration: Duration.zero);
    // Show user new chapter
    await Future.delayed(const Duration(milliseconds: 500));
    controller.animateTo(controller.offset - 200,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    // }
    return true;
  }

  void populateAtStart() async {
    ///Load initial chapters
    assert(chapters.isEmpty);
//Load first
    _addChapter(book.chapters[0]);

    //Await startChapter from file
    int? startChapter = await getStartChapter();

    if (startChapter != null) {
      //Load previously saved chapter

//Load current
      currentChapter = book.chapters[startChapter];
      //Add all to view
      addChaptersUntil(startChapter);

      //Update view
      updateView();
      currentChapter?.load();

      //TODO: Show snackbar saying 'loaded from bookmark'

      scrollDelayed(book.chapters[startChapter]);
    } else {
      //Add preloaded next
      _addChapter(book.chapters[1]);
      //Update screen
      updateView();
    }
  }

  void updateChapters() async {
    if (chapters.isEmpty) {
      assert(false);
    }
    int? startChapter = await getStartChapter();

    if (startChapter == null) {
      //No further change is needed
      return;
    }
    //If new scroll is oob
    if (startChapter >= endChapter) {
      addChaptersUntil(startChapter);
    }
    int firstLoadedChapter = this.firstLoadedChapter!;

    if (startChapter < firstLoadedChapter) {
      _insertStartChaptersUntil(startChapter);
    }

    //Scroll to new chapter
    scrollDelayed(book.chapters[startChapter]);
  }

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  void scrollNotification() {
    if (controller.offset > controller.position.maxScrollExtent - 3000) {
      addChapter();
    }
  }

  void chapterPositionSet(Chapter? chapter) {
    if (chapter != null) {
      WidgetsBinding.instance.addPostFrameCallback((d) {
        chapterBecomesMain(chapter);
      });
    }
  }

  void chapterBecomesMain(Chapter? chapter) {
    if (chapter != currentChapter) {
      // dev.log("Main: ${chapter?.varName}");
      if (chapter != null) {
        chapter.load();
        currentChapter = chapter;
        if (part.id != currentChapter!.part) {
          //TODO: Await here
          part = getPartImmediate(currentChapter!.part);
        }
        //Refresh view
        setState(() {});
        //Dispose old chapters
        //The minimum height for chapters puts them on 3 on screen at a time
        disposeChaptersBefore(currentChapter!.index - 4);
      } else {
        //Chapter is null
        //Main
        setState(() {
          currentChapter = null;
        });
        //Leave part
      }
    } else if (chapter?.needsLoad ?? false) {
      chapter?.load();
    }
  }

  void disposeChaptersBefore(int disposeBefore) async {
    bool printedYet = false;
    for (int n = 0; n < chapters.length; ++n) {
      int chapterIx = chapters[n].index;
      if (chapterIx >= disposeBefore) {
        return;
      } else {
        // if (chapters[n].c)
        //Delete all images and holders
        if (chapters[n].needsDispose()) {
          chapters[n].unloadCompletely();
          if (!printedYet) {
            dev.log("Disposing $chapterIx-$disposeBefore");
            printedYet = true;
          }
        }
      }
    }
  }

  void addChaptersUntil(int desiredCurrent) {
    //Add all to view
//Add 1 extra for preload
    int endChapter = this.endChapter;
    for (int n = endChapter + 1; n <= desiredCurrent + 1; ++n) {
      _addChapter(book.chapters[n]);
    }
  }

  void _insertStartChaptersUntil(int startIx) {
    //Add all to view
//Add 1 extra for preload
    //Helpful clamp
    if (startIx < 0) {
      startIx = 0;
    }
    if (chapters.isEmpty) {
      _addChapter(book.chapters[startIx]);
      return;
    } else {
      int currentStart = firstLoadedChapter!;
      for (int n = currentStart - 1; n >= startIx; --n) {
        _insertStartChapter(book.chapters[n]);
      }
    }
  }

  void addChapter() {
    //TODO: This allowed custom paths through the scroll.
    //However, I don't think we want that
    // Chapter? next = chapters.last.next;

    int nextIx = chapters.last.index + 1;
    Chapter? next;
    if (nextIx < book.chapterAmt && nextIx >= 0) {
      next = book.chapters[nextIx];
    }
    if (next != null) {
      _addChapter(next);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _addChapter(Chapter? chapter) {
    if (chapter != null) {
      if (kDebugMode) {
        assert(!chapters.contains(chapter),
            'Re-adding chapter ${chapter.varName} (${chapter.index}) to end (first=$firstLoadedChapter start=${widget.startChapter} end=$endChapter)');
      } else if (kReleaseMode) {
        //Safety first!
        if (chapters.contains(chapter)) {
          return;
        }
      }
      chapters.add(chapter);
    }
  }

  void _insertStartChapter(Chapter? chapter) {
    if (chapter != null) {
      if (kDebugMode) {
        assert(!chapters.contains(chapter),
            'Re-adding chapter ${chapter.varName} (${chapter.index}) to start (first=$firstLoadedChapter start=${widget.startChapter} end=$endChapter)');
      } else if (kReleaseMode) {
        //Safety first!
        if (chapters.contains(chapter)) {
          return;
        }
      }

      chapters.insert(0, chapter);
    }
  }

  Future<void> onRefresh() async {
    if (chapters.isEmpty) {
      return;
    }
    int chapterIx = chapters.first.index - 1;
    if (chapterIx >= 0) {
      Chapter currentChapter = book.chapters[chapters.first.index];

      Chapter? chapter = book.chapters[chapterIx];
      _insertStartChaptersUntil(chapterIx - 2);

      // updateView();

      await scrollUpDelayed(currentChapter);
      // await Future.delayed(const Duration(seconds: 3));

      chapter.load();

      //I assume this refreshes the view
      return;
    } else {
      //No chapters to add
      showNothingToInsertOverlay();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return builder(context, null);
    return LayoutBuilder(key: const Key("size_response"), builder: builder);
  }

  Widget builder(BuildContext context, BoxConstraints? constraints) {
    List<Widget> slivers = [];

    if (chapters.isEmpty) {
      slivers.add(const LoadSliver(chapterTitle: 'Chapters'));
    } else {
      slivers.addAll(chapters.map<Widget>(itemMapper).toList(growable: false));
    }

    slivers.add(const _FillRemaining(key: Key("fillRemaining")));
    return ThemeChangingScaffold(
        key: const Key("SliverScaffold"),
        source: 'scroll',
        background: NoirPrimary.shade0,

        //TODO: Future loader for part
        part: part,
        showFAB: false,
        child: ChapterHeadingData(
            key: const Key("headingData"),
            onChapterBecomesMain: chapterPositionSet,
            child: refreshWrap(context,
                child: SelectionArea(
                    key: const Key("selection"),
                    child: CustomScrollView(
                      // dragStartBehavior: DragStartBehavior.down,
                      restorationId: 'sliverScroll',
                      // primary: true,

                      key: const Key("SliverCustomScrollView"),
                      //Loads & lays out sooner
                      cacheExtent: 2000,

                      shrinkWrap: false,

                      // physics: AlwaysScrollableScrollPhysics(),
                      controller: controller,
                      slivers: slivers,
                    )))));
  }

  Widget refreshWrap(BuildContext context, {required Widget child}) {
    if (chapters.isEmpty) {
      //Almost wanna refresh immediately
      return child;
    }
    if (chapters.first.index == 0) {
      //Don't add RefreshWrap if already at beginning
      return child;
    } else {
      return RefreshIndicator(
          key: const Key("Refresher"), onRefresh: onRefresh, child: child);
    }
  }

  void showNothingToInsertOverlay() async {
    //Show a visual,
    OverlayEntry overlay = OverlayEntry(builder: (context) {
      return Container(
          width: 200,
          height: 50,
          color: Tertiary.shade5,
          alignment: Alignment.center,
          child: const Text(
            "Nothing to insert!",
          ));
    });
    Overlay.of(context).insert(overlay);
    await Future.delayed(const Duration(seconds: 3));

    overlay.remove();
  }

  Widget itemMapper(Chapter chapter) {
    if (chapter.id == 0) {
      return const TitleSliver(key: Key('titleSliver'));
    }
    return ChapterSliver(key: chapter.globalKey, chapter: chapter);
  }
}

class ScrollSizeWrap extends StatelessWidget {
  final Widget child;
  final Part part;
  const ScrollSizeWrap(
      {required super.key, required this.child, required this.part});

  static const double readerWidth = 800;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth <= readerWidth) {
      return child;
    } else {
      return ColoredBox(
          key: const Key("gutter"),
          color: part.primary.s0,
          child: Center(
              child: Container(
                  key: const Key("readerCtr"),
                  width: readerWidth,
                  decoration: BoxDecoration(
                    //Skeumorphic - looks like the appbar is a container
                    //TODO: Try to get it to only draw the sides
                    border: Border.all(
                        //Manually screenpicked to match appBar
                        color: part.appBarColor,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside),
                  ),
                  child: child)));
    }
  }
}

class _FillRemaining extends StatelessWidget {
  const _FillRemaining({
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Expand text from center
    GrandSwatch primary = GrandSwatch.primaryOf(context);

    return SliverToBoxAdapter(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            height: 200,
            color: primary.s3,
            alignment: Alignment.center,
            child: Column(
                key: const Key("fillRemCol"),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    key: const Key("fillRmIcon"),
                    RpgAwesome.burning_meteor,
                    color: primary.sa,
                    size: 48,
                  ),
                ])));
  }
}
