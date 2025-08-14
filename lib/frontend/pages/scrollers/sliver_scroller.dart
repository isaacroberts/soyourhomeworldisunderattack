import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/load_sliver.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter_holder.dart';
import '../../../backend/error_handler.dart';
import '../../elements/chapter_heading/heading_data.dart';
import '../title/title.dart';
import 'slivers/chapter_holder_sliver.dart';

class SliverScrollerPage extends StatelessWidget {
  final int startChapter;
  const SliverScrollerPage({super.key, this.startChapter = 0});

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'scroll',
        showFAB: false,
        child: SliverScroller(
          key: const Key("SliverScroll"),
          startChapter: startChapter,
        ));
  }
}

const int amountChaptersToPreload = 2;

class SliverScroller extends StatefulWidget {
  // final Book book;
  final int? startChapter;

  const SliverScroller({super.key, this.startChapter});

  @override
  State<SliverScroller> createState() => _SliverScrollerState();
}

class _SliverScrollerState extends State<SliverScroller> {
  late Book book;

  // List<ChapterHolder> currentChapters = [];

  set currentChapters(List<ChapterHolder> s) {}
  List<ChapterHolder> get currentChapters => book.chapters.sublist(0, 20);

  ChapterHolder? currentChapter;
  Map<ChapterHolder, double> chapterPositions = {};

  bool blockAdditions = false;

  double anchor = 0;

  final ScrollController controller = ScrollController(
      //TODO: Initial scroll offset, scroll-up dectector
      // initialScrollOffset: 500,
      debugLabel: 'SliverScrollController',
      keepScrollOffset: true);

  @override
  void initState() {
    // controller.position.addListener(scrollNotification);

    controller.addListener(scrollNotification);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //This is where InheritedWidgets update
    book = Book.of(context);

    populate();

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SliverScroller oldWidget) {
    // if (oldWidget.startChapter != widget.startChapter) {
    //   populate();
    // }
    super.didUpdateWidget(oldWidget);
  }

  void populate() async {
    if (currentChapters.isNotEmpty) {
      return;
    }
    currentChapter = book.chapters[widget.startChapter ?? 0];
    currentChapter?.load().then(chapterLoaded, onError: ErrorList.showError);
    //TODO: Fetch current chapter. If fetched, change to that chapter, and show a snackbar
    //
    currentChapters = [currentChapter!];

    addChapter();
  }

  double get estimateHeight {
    //# Chapters * Page height * 2.5 pages/chapter
    return currentChapters.length * MediaQuery.sizeOf(context).height * 2.5;
  }

  DateTime lastScrollNotification = DateTime.fromMillisecondsSinceEpoch(0);
  void scrollNotification() {
    //If it has been less than 1 second since the last notification
    if (DateTime.now()
        .isBefore(lastScrollNotification.add(const Duration(seconds: 1)))) {
      return;
    }
    lastScrollNotification = DateTime.now();

    ScrollDirection direction = controller.position.userScrollDirection;

    chapterBecomesMain(getMainChapter(controller.offset));
    //Prevent concurrent modification
    ChapterHolder? currentChapter = this.currentChapter;
    if (currentChapter == null) {
      addChapter();
      return;
    } else {
      int mainChapterIndex = currentChapters.indexOf(currentChapter);

      if (direction == ScrollDirection.reverse) {
        //Scrolling down

        if (mainChapterIndex + amountChaptersToPreload >=
            currentChapters.length) {
          addChapter(atStart: false);
        }
      } else if (direction == ScrollDirection.forward) {
        if (mainChapterIndex - 1 < 0) {
          // addChapter(atStart: true);
        }
      } else if (direction == ScrollDirection.idle) {
        //Pass

        dev.log("Cut chapters");
        if ((chapterPositions[currentChapter]?.abs() ?? 2000) < 100) {
          setState(() {
            //Cut out excesss chapters
            currentChapters = [currentChapter];
          });
        }
      }
    }
  }

  void toggleBlock() async {
    blockAdditions = true;
    await Future.delayed(const Duration(seconds: 1));
    blockAdditions = false;
  }

  bool addChapter({bool atStart = false, int? startChapter}) {
    return false;
    if (blockAdditions) {
      return false;
    }
    //Sometimes there is no next
    if (_addChapter(atStart: atStart, startChapter: startChapter)) {
      if (atStart) {}
      if (currentChapters.length > 7) {
        if (atStart) {
          currentChapters.removeLast();
        } else {
          currentChapters.removeAt(0);
        }
      }
      //Refresh view
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  void chapterLoaded(ChapterAndStream chapterAndStream) {
    // dev.log("ChapterLoaded ${chapterAndStream.$1.varName}");
  }

  bool _addChapter({atStart = false, int? startChapter}) {
    return false;
    ChapterHolder? chapter;
    if (currentChapters.isEmpty) {
      chapter = book.chapters[startChapter ?? widget.startChapter ?? 0];
    } else {
      // int? id;
      if (atStart) {
        chapter = currentChapters.first.previous;
      } else {
        chapter = currentChapters.last.next;
      }
    }
    if (chapter == null) {
      return false;
    }
    if (currentChapters.contains(chapter)) {
      throw Exception('Chapter already in list: ${chapter.varName}');
    }

    dev.log("Insert chapter: ${chapter.varName}");
    chapter.load().then(chapterLoaded, onError: ErrorList.showError);

    if (atStart) {
      currentChapters.insert(0, chapter);
    } else {
      currentChapters.add(chapter);
    }
    toggleBlock();
    return true;
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
      dev.log("Main: ${chapter?.varName}");
      if (chapter != null) {
        chapter.load();
        currentChapter = chapter;
      }
    }
  }

  Future<void> onPullToRefresh() async {
    // scrollTo = currentChapter;
    var chp = currentChapter;
    if (blockAdditions) {
      return;
    }
    _addChapter(atStart: true);
    // anchor += MediaQuery.of(context).size.height;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted && chp != null) {
      BuildContext? ctx = itemKey(chp).currentContext;
      if (ctx != null) {
        if (ctx.mounted) {
          Scrollable.ensureVisible(ctx);
        }
      }
    }
    // controller.animateTo(controller.offset - 30,
    //     duration: const Duration(milliseconds: 300), curve: Curves.ease);
// controller.
    // dev.log("Refreshed");
    // return;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];

    //TODO: This does not work

    if (currentChapters.isEmpty) {
      slivers.add(const ChapterLoadSliver(chapterTitle: 'Chapters'));
    } else {
      slivers.addAll(
          currentChapters.map<Widget>(itemMapper).toList(growable: false));
    }
    // slivers.add(SliverFillRemaining(
    //     child: Container(
    //   color: const Color(0xff000006),
    //   child: const Icon(
    //     RpgAwesome.burning_meteor,
    //     color: Color(0xff555565),
    //     size: 48,
    //   ),
    // )));

    //It's surfing on the BoxAdaptor
    // slivers.add(const SliverToBoxAdapter(
    //     child: SizedBox(
    //   height: 200,
    //   // color: const Color(0xff000006),
    //   child: Icon(
    //     RpgAwesome.burning_meteor,
    //     color: Color(0xff555565),
    //     size: 48,
    //   ),
    // )));

    return ChapterHeadingData(
        onChapterBecomesMain: chapterPositionSet,
        child: refreshWrap(
            child: CustomScrollView(
          // center: nullableKey(doScroll),
          // reverse: true,
          shrinkWrap: false,

          // physics: AlwaysScrollableScrollPhysics(),
          controller: controller,
          slivers: slivers,
        )));
  }

  Widget refreshWrap({required Widget child}) {
    // return child;
    if (currentChapters.first.id == 0) {
      //Build without refresh indicator
      return child;
    } else {
      //The refresh indicator is breaking the scrollview!
      return RefreshIndicator(

          // refreshTriggerPullDistance: 100,

          onRefresh: onPullToRefresh,
          edgeOffset: 100,
          child: child);
    }
  }

  GlobalKey itemKey(ChapterHolder chapter) {
    return chapter.globalKey;
    //This must be standardized for the customScrollView
    // if (chapter.id == 0) {
    //   return const Key("Title");
    // } else {
    //   return Key("Chp_${chapter.id}");
    // }
  }

  GlobalKey? nullableKey(ChapterHolder? chapter) {
    if (chapter == null) {
      return null;
    } else {
      return itemKey(chapter);
    }
  }

  Widget itemMapper(ChapterHolder chapter) {
    if (chapter.id == 0) {
      // It'll display through the sliver but it won't animate
      return const SliverToBoxAdapter(
          child: TitleWidget(
        key: Key("Title"),
      ));
    }
    return ChapterHolderSliver(key: itemKey(chapter), chapter: chapter);
  }
}
