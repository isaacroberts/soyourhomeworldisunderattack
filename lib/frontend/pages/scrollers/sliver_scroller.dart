import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/load_sliver.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter_holder.dart';
import '../../elements/chapter_heading/heading_data.dart';
import '../../icons.dart';
import '../../theme/colors.dart';
import '../../theme/timings.dart';
import '../title/title.dart';
import 'slivers/chapter_holder_sliver.dart';

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
  int get endChapter =>
      currentChapters.isEmpty ? 0 : currentChapters.last.index;
  final List<ChapterHolder> currentChapters = [];

  ChapterHolder? currentChapter;
  Map<ChapterHolder, double> chapterPositions = {};

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
    if (currentChapters.isEmpty || endChapter < startChapter) {
      populate();
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SliverScroller oldWidget) {
    dev.log("(SlvScroller: didUpdateWidget()start=${widget.startChapter}");

    super.didUpdateWidget(oldWidget);
    //If chapter changed
    if (widget.startChapter != oldWidget.startChapter) {
      if (widget.startChapter != null) {
        //If new scroll is oob
        if (widget.startChapter! >= endChapter) {
          addChaptersUntil(widget.startChapter!);
        }

        //Scroll to new chapter
        scrollDelayed(book.chapters[widget.startChapter!]);
      } else {
        //Ensure currentChapter is still visible
        scrollDelayed(currentChapter);
      }
    }
  }

  Future<void> scrollDelayed(ChapterHolder? chapter) async {
    if (chapter == null) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    //Scroll to new chapter
    //The null context doesn't allow it to retry by loading the SliverScroller
    scrollToChapter(book.chapters[widget.startChapter!],
        context: mounted ? context : null);
  }

  void populate() async {
    if (widget.startChapter == null) {
//Load first
      _addChapter(book.chapters[0]);
//       currentChapters = [book.chapters[0]];
      //Technically chapter 0 doesn't need to load
// currentChapter?.load();
      //Update screen
      // updateView();
      //Await startChapter from file
      int? startChapter = await getStartChapter();

      if (startChapter != null) {
        //Load previously saved chapter

//Load current
        currentChapter = book.chapters[startChapter];
        currentChapter?.load();

        //Add all to view
        addChaptersUntil(startChapter);

        //Update view
        updateView();
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
      ChapterHolder? chp = currentChapter;

      //Fill currentChapters
      addChaptersUntil(startChapter);

      //Update screen
      updateView();

      //If we need to scroll to start chapter
      if (startChapter > 0) {
        //Delay to make sure screen's loaded
        scrollDelayed(chp);
      }

      //Load on other thread
      currentChapter!.load();
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

  void chapterPositionSet(ChapterHolder? chapter, double position) {
    if (chapter != null) {
      chapterPositions[chapter] = position;
    }
  }

  ChapterHolder? getMainChapter(double scrollPosition) {
    // ChapterHolder? below;
    ChapterHolder? above;
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

  void chapterBecomesMain(ChapterHolder? chapter) {
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
    for (int n = endChapter; n <= desiredCurrent + 1; ++n) {
      _addChapter(book.chapters[n]);
    }
  }

  void addChapter() {
    ChapterHolder? next = currentChapters.last.next;
    if (next != null) {
      _addChapter(next);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _addChapter(ChapterHolder? chapter) {
    if (chapter != null) {
      if (kDebugMode) {
        assert(!currentChapters.contains(chapter));
      }
      currentChapters.add(chapter);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];

    if (currentChapters.isEmpty) {
      slivers.add(const ChapterLoadSliver(chapterTitle: 'Chapters'));
    } else {
      slivers.addAll(
          currentChapters.map<Widget>(itemMapper).toList(growable: false));
    }

    slivers.add(const _FillRemaining(key: Key("fillRemaining")));

    return ChapterHeadingData(
        key: const Key("headingData"),
        onChapterBecomesMain: chapterPositionSet,
        child: CustomScrollView(
          key: const Key("SliverCustomScrollView"),
          cacheExtent: 2000,

          shrinkWrap: false,

          // physics: AlwaysScrollableScrollPhysics(),
          controller: controller,
          slivers: slivers,
        ));
  }

  Widget itemMapper(ChapterHolder chapter) {
    if (chapter.id == 0) {
      // It'll display through the sliver but it won't animate
      return const SliverToBoxAdapter(
          child: TitleWidget(
        key: Key("Title"),
      ));
    }
    return ChapterHolderSliver(key: chapter.globalKey, chapter: chapter);
  }
}

class _FillRemaining extends StatelessWidget {
  const _FillRemaining({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            color: Primary.shade4,
            alignment: Alignment.center,
            child: const Column(
                key: Key("fillRemCol"),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      key: Key("fillRmText"),
                      "End.",
                      style: TextStyle(
                          fontFamily: 'Palatino',
                          fontSize: 18,
                          color: Primary.shadea)),
                  SizedBox(
                    height: 24,
                  ),
                  Icon(
                    key: Key("fillRmIcon"),
                    RpgAwesome.burning_meteor,
                    color: Primary.shadea,
                    size: 48,
                  ),
                ])));
  }
}
