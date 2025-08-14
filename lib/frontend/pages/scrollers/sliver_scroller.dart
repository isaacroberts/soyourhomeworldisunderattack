import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/load_sliver.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter_holder.dart';
import '../../../backend/error_handler.dart';
import '../../elements/chapter_heading/heading_data.dart';
import '../../icons.dart';
import '../../theme/colors.dart';
import '../title/title.dart';
import 'slivers/chapter_holder_sliver.dart';

class SliverScrollerPage extends StatelessWidget {
  final int startChapter;
  const SliverScrollerPage({super.key, this.startChapter = 0});

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

class _SliverScrollerState extends State<SliverScroller> {
  late Book book;

  // List<ChapterHolder> currentChapters = [];
  //
  // set currentChapters(List<ChapterHolder> s) {}
  List<ChapterHolder> get currentChapters =>
      kDebugMode ? book.chapters.sublist(0, 20) : book.chapters;

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
    //This is where InheritedWidgets update
    book = Book.of(context);

    populate();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SliverScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void populate() async {
    if (currentChapters.isNotEmpty) {
      return;
    }
    currentChapter = book.chapters[widget.startChapter ?? 0];
    currentChapter!.load();

    RenderObject? scrollTo =
        currentChapter!.globalKey.currentContext?.findRenderObject();
    if (scrollTo != null) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        Scrollable.maybeOf(context)?.position.ensureVisible(scrollTo);
      });
    }
  }

  void scrollNotification() {
    //If it has been less than 1 second since the last notification

    ///TODO: Does main do anything?
    chapterBecomesMain(getMainChapter(controller.offset));
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
    } else if (chapter?.needsLoad ?? false) {
      chapter?.load();
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
          // center: nullableKey(doScroll),
          // reverse: true,
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
//============ Debug ======================

const int amountChaptersToPreload = 2;

class DebugSliverScroller extends StatefulWidget {
  // final Book book;
  final int? startChapter;

  const DebugSliverScroller({super.key, this.startChapter});

  @override
  State<DebugSliverScroller> createState() => _DebugSliverScrollerState();
}

class _DebugSliverScrollerState extends State<DebugSliverScroller> {
  late Book book;

  List<ChapterHolder> currentChapters = [];

  ChapterHolder? currentChapter;
  Map<ChapterHolder, double> chapterPositions = {};

  bool blockAdditions = false;

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
  void didUpdateWidget(DebugSliverScroller oldWidget) {
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
    // return false;
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
      BuildContext? ctx = chp.globalKey.currentContext;
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

    slivers.add(const _FillRemaining(key: Key("fillRemaining")));

    return ChapterHeadingData(
        key: const Key("HeadingData"),
        onChapterBecomesMain: chapterPositionSet,
        child: refreshWrap(
            child: CustomScrollView(
          key: const Key("DebugSliverCustomScrollView"),
          shrinkWrap: false,
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
          key: const Key("refreshIndicator"),
          onRefresh: onPullToRefresh,
          edgeOffset: 100,
          child: child);
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
    return ChapterHolderSliver(key: chapter.globalKey, chapter: chapter);
  }
}
