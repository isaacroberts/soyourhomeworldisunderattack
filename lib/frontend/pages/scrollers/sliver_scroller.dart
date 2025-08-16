import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/load_sliver.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../elements/chapter_heading/heading_data.dart';
import '../../icons.dart';
import '../../theme/colors.dart';
import '../../theme/timings.dart';
import '../title/title.dart';
import 'slivers/chapter_sliver.dart';

class SliverScrollerPage extends StatelessWidget {
  final int? startChapter;
  const SliverScrollerPage({required super.key, this.startChapter});

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).size.width > 800;
    return McScaffold(
        key: const Key("SliverScaffold"),
        source: 'scroll',
        showFAB: showFab,
        child: SliverScroller(
          key: const Key("SliverScroll"),
          startChapter: startChapter,
        ));
  }
}

class SliverScroller extends StatefulWidget {
  // final Book book;
  final int? startChapter;

  const SliverScroller({super.key, this.startChapter});

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

  int get startChapter => widget.startChapter ?? 0;
  int? get firstLoadedChapter => chapters.isEmpty ? null : chapters.first.index;
  int get endChapter => chapters.isEmpty ? 0 : chapters.last.index;
  final List<Chapter> chapters = [];

  Chapter? currentChapter;
  Map<Chapter, double> chapterPositions = {};

  final ScrollController controller = ScrollController(
      debugLabel: 'SliverScrollController', keepScrollOffset: true);

  @override
  void initState() {
    controller.addListener(scrollNotification);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    dev.log(
        "(SlvScroller: didChangeDependencies() start=${widget.startChapter}");

    //This is where InheritedWidgets update
    book = Book.of(context);
    if (chapters.isEmpty) {
      populate();
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
    await Future.delayed(const Duration(milliseconds: 2000));
    //Scroll to new chapter
    //The null context doesn't allow it to retry by loading the SliverScroller
    scrollToChapter(chapter, context: mounted ? context : null);
  }

  Future<void> scrollUpDelayed(Chapter? chapter) async {
    if (chapter == null) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 200));
    //Scroll to new chapter
    //The null context doesn't allow it to retry by loading the SliverScroller
    BuildContext? keyContext = chapter.globalKey.currentContext;
    if (keyContext == null || !keyContext.mounted) {
      //Minor error
      return;
    }
    await Scrollable.ensureVisible(keyContext, duration: Duration.zero);

    //Show user new chapter
    await Future.delayed(const Duration(milliseconds: 200));
    controller.animateTo(controller.offset - 200,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    // }
  }

  void updateChapters() async {
    if (widget.startChapter != null) {
      if (chapters.isEmpty) {
        assert(false);
      }
      //If new scroll is oob
      if (widget.startChapter! >= endChapter) {
        addChaptersUntil(widget.startChapter!);
      }
      int firstLoadedChapter = this.firstLoadedChapter!;

      if (widget.startChapter! < firstLoadedChapter) {
        _insertStartChaptersUntil(widget.startChapter!);
      }

      //Scroll to new chapter
      scrollDelayed(book.chapters[widget.startChapter!]);
    } else {
      //Ensure currentChapter is still visible
      scrollDelayed(currentChapter);
    }
  }

  void populate() async {
    assert(chapters.isEmpty);
    if (widget.startChapter == null) {
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
    } else {
      //Start loading first
      currentChapter = book.chapters[startChapter];

      //Save to prevent async
      Chapter chp = currentChapter!;
      _addChapter(chp);

      //Update screen
      updateView();
      //If we need to scroll to start chapter
      if (startChapter > 0) {
        //Delay to make sure screen's loaded
        scrollDelayed(chp);
      }
      //Load last to make sure it doesn't clog up async
      chp.load();
    }
  }

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  void scrollNotification() {
    //If it has been less than 1 second since the last notification

    ///TODO: Does main do anything?
    chapterBecomesMain(getMainChapter(controller.offset));

    if (controller.offset > controller.position.maxScrollExtent - 3000) {
      addChapter();
    }
  }

  void chapterPositionSet(Chapter? chapter, double position) {
    if (chapter != null) {
      chapterPositions[chapter] = position;
    }
  }

  Chapter? getMainChapter(double scrollPosition) {
    // ChapterHolder? below;
    Chapter? above;
    double abovePosition = -1;
    // double? belowPosition;
    // dev.log("Scroll: $scrollPosition poses=${chapterPositions}");
    for (var mapEntry in chapterPositions.entries) {
      if (mapEntry.value > abovePosition && mapEntry.value < scrollPosition) {
        above = mapEntry.key;
        abovePosition = mapEntry.value;
      }
    }
    return above;
  }

  void chapterBecomesMain(Chapter? chapter) {
    if (chapter != currentChapter) {
      // dev.log("Main: ${chapter?.varName}");
      if (chapter != null) {
        chapter.load();
        currentChapter = chapter;
      } else {
        //Main
        currentChapter = null;
      }
    } else if (chapter?.needsLoad ?? false) {
      chapter?.load();
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
    Chapter? next = chapters.last.next;
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

      updateView();

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
    List<Widget> slivers = [];

    if (chapters.isEmpty) {
      slivers.add(const ChapterLoadSliver(chapterTitle: 'Chapters'));
    } else {
      slivers.addAll(chapters.map<Widget>(itemMapper).toList(growable: false));
    }

    slivers.add(const _FillRemaining(key: Key("fillRemaining")));

    return ChapterHeadingData(
        key: const Key("headingData"),
        onChapterBecomesMain: chapterPositionSet,
        child: refreshWrap(context,
            child: CustomScrollView(
              key: const Key("SliverCustomScrollView"),
              cacheExtent: 2000,

              shrinkWrap: false,

              // physics: AlwaysScrollableScrollPhysics(),
              controller: controller,
              slivers: slivers,
            )));
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
      // It'll display through the sliver but it won't animate
      return const SliverToBoxAdapter(
          child: TitleWidget(
        key: Key("Title"),
      ));
    }
    return ChapterSliver(key: chapter.globalKey, chapter: chapter);
  }
}

class _FillRemaining extends StatelessWidget {
  const _FillRemaining({
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Expand text from center
    return SliverToBoxAdapter(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            height: 200,
            color: Primary.shade0,
            alignment: Alignment.center,
            child: const Column(
                key: Key("fillRemCol"),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      key: Key("fillRmText"),
                      "You can Scroll no further",
                      style: TextStyle(
                          fontFamily: 'Palatino',
                          fontSize: 16,
                          color: Primary.shade7)),
                  SizedBox(
                    height: 24,
                  ),
                  Icon(
                    key: Key("fillRmIcon"),
                    RpgAwesome.burning_meteor,
                    color: Primary.shadea,
                    size: 48,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                      key: Key("subText"),
                      "Only Doom remains",
                      style: TextStyle(
                          fontFamily: 'Palatino',
                          fontSize: 12,
                          color: Primary.shade7)),
                ])));
  }
}
