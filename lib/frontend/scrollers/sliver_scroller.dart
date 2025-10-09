import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/backend/utils.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/grand_swatch.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../backend/start_chapter.dart';
import '../elements/chapter_heading/heading_data.dart';
import '../icons.dart';
import '../pages/title/title.dart';
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
  final bool hasIndex;
  final StartChapter startChapter;
  final ValueNotifier<Chapter?> currentChapter;

  const SliverScroller(
      {super.key,
      required this.startChapter,
      required this.hasIndex,
      required this.currentChapter});

  @override
  State<SliverScroller> createState() => _SliverScrollerState();
}

class _SliverScrollerState extends State<SliverScroller> {
  late Book book;

  // int get startChapter => widget.startChapter ?? 0;
  // int? get firstLoadedChapter => chapters.isEmpty ? null : chapters.first.index;
  // int get endChapter => chapters.isEmpty ? 0 : chapters.last.index;
  int firstLoadedChapter = 0;
  int _endChapter = 1;
  int get endChapter => _endChapter;
  set endChapter(int set) {
    _endChapter = clampInt(0, set, book.chapterAmt);
  }
  // final List<Chapter> chapters = [];

  Chapter chapters(int ix) {
    return book.chapters[ix];
  }

  // Chapter? currentChapter;
  Chapter? get currentChapter => widget.currentChapter.value;
  set currentChapter(Chapter? set) {
    widget.currentChapter.value = set;
  }

  //This is needed for the background
  late Part part;
  // Map<Chapter, double> chapterPositions = {};

  late final ScrollController controller;

  @override
  void initState() {
    // ScrollController? c = Scrollable.maybeOf(context)?.widget.controller;
    // dev.log("Had scroll controller: ${c != null}");
    controller = ScrollController(
        debugLabel: 'SliverScrollController',

        // onAttach: scrollControllerAttach,
        onDetach: scrollControllerDetatch,
        keepScrollOffset: false);
    controller.addListener(scrollNotification);

    super.initState();
  }

  void scrollControllerAttach(ScrollPosition pos) {
    //TODO: Check this in various functions to reduce UI load
    // Scrollable.of(context).position.recommendDeferredLoading(context);
  }
  void scrollControllerDetatch(ScrollPosition pos) {
    for (int n = firstLoadedChapter; n < endChapter; ++n) {
      if (book.chapters[n].needsDispose()) {
        book.chapters[n].unloadCompletely();
      }
    }
  }

  @override
  void didChangeDependencies() {
    dev.log(
        "(SlvScroller: didChangeDependencies() start=${widget.startChapter}");

    //This is where InheritedWidgets update
    book = Book.of(context);

    part = defaultPart;

    super.didChangeDependencies();

    widget.startChapter.getStart(book).then(chapterReceivedAtStart);
  }

  @override
  void didUpdateWidget(SliverScroller oldWidget) {
    dev.log("(SlvScroller: didUpdateWidget()");

    super.didUpdateWidget(oldWidget);
    //If chapter changed
    if (widget.startChapter != oldWidget.startChapter) {
      widget.startChapter.getStart(book).then(chapterReceivedAtStart);
    }
  }

  void chapterReceivedAtStart(Chapter? chapter) {
    dev.log("StartChapter = $chapter");

    if (chapter == null) {
      //Fix possible errors

      //If end after beginning
      if (endChapter <= firstLoadedChapter + 1) {
        endChapter = firstLoadedChapter + 1;
      }
      return;
    }

    //If current chapter before start
    if (firstLoadedChapter >= chapter.index) {
      //Move view to current
      setState(() {
        currentChapter = chapter;
        firstLoadedChapter = chapter.index;
        endChapter = firstLoadedChapter + 3;
      });
    }
    //If current chapter after last
    else if (endChapter <= chapter.index) {
      //Move view to current
      setState(() {
        currentChapter = chapter;
        firstLoadedChapter = chapter.index;
        endChapter = firstLoadedChapter + 3;
      });
    }
    //If chapter is different
    else if (currentChapter != chapter) {
      //Scroll to new
      currentChapter = chapter;
      scrollToChapter(chapter, context: context);
    }
  }

  Future<void> scrollDelayed(Chapter? chapter) async {
    if (chapter == null) {
      return;
    }
    if (kDebugMode && false) {
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

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  bool canAdd = true;

  void scrollNotification() async {
    //There are, for some reason, multiple scrolls
    if (!canAdd) {
      return;
    }
    ScrollPosition position = controller.positions.last;

    // dev.log("Pixels : ${position.pixels} / ${position.maxScrollExtent}");
    if (position.pixels > position.maxScrollExtent - 2000) {
      //Add 2 chapters at once
      int newEnd = math.min(book.chapterAmt, endChapter + 2);
      dev.log("Add chapters to $newEnd");
      if (newEnd != endChapter) {
        //Add new to view
        setState(() {
          endChapter = newEnd;
        });
      }
      canAdd = false;
      await Future.delayed(const Duration(seconds: 1));
      canAdd = true;
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
    if (!mounted) {
      return;
    }
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
        if (mounted) {
          setState(() {});
        } //Dispose old chapters
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
    if (currentChapter != null) {
      bookmarkCurrentChapter(currentChapter!.index);
    }
  }

  void disposeChaptersBefore(int disposeBefore) async {
    bool printedYet = false;
    for (int n = firstLoadedChapter; n < disposeBefore; ++n) {
      //Delete all images and holders
      if (chapters(n).needsDispose()) {
        chapters(n).unloadCompletely();
        if (!printedYet) {
          dev.log("Disposing $n-$disposeBefore");
          printedYet = true;
        }
      }
    }
  }

  void addChaptersUntil(int desiredCurrent) {
    setState(() {
//Add 1 extra for preload
      endChapter = desiredCurrent + 1;
    });
  }

  Future<void> onRefresh() async {
    int chapterIx = firstLoadedChapter;
    if (chapterIx > 0) {
      setState(() {
        firstLoadedChapter = math.max(firstLoadedChapter - 1, 0);
      });
      //FUCK after-scrolling
      // scrollDelayed(currentChapter);

      // updateView();

      // await scrollUpDelayed(currentChapter);
      // await Future.delayed(const Duration(seconds: 3));
      currentChapter?.load();
      //I assume this refreshes the view
      return;
    } else {
      //No chapters to add
      showNothingToInsertOverlay();
      return;
    }
  }

  void onAddExtra() {
    int newEnd = math.min(book.chapterAmt, endChapter + 4);
    if (newEnd != endChapter) {
      //Add new to view
      setState(() {
        endChapter = newEnd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return builder(context, null);
    return LayoutBuilder(key: const Key("size_response"), builder: builder);
  }

  Widget builder(BuildContext context, BoxConstraints? constraints) {
    List<Widget> slivers = [];

    if (firstLoadedChapter == endChapter) {
      slivers.add(const LoadSliver(chapterTitle: 'Chapters'));
    } else {
      slivers.addAll(book.chapters
          .sublist(firstLoadedChapter, endChapter)
          .map<Widget>(itemMapper)
          .toList(growable: false));
    }

    if (endChapter == book.chapterAmt) {
      slivers.add(const _FillRemaining(key: Key("fillRemaining")));
    } else {
      slivers.add(_HasExtraFillRemaining(
          key: const Key('refreshRemaining'), onRequestMore: onAddExtra));
    }
    return ChapterHeadingData(
        key: const Key("headingData"),
        onChapterBecomesMain: chapterPositionSet,
        child: refreshWrap(context,
            // child: SelectionArea(
            //     key: const Key("selection"),
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
            )));
  }

  Widget refreshWrap(BuildContext context, {required Widget child}) {
    if (firstLoadedChapter == endChapter) {
      //Almost wanna refresh immediately
      return child;
    }
    if (firstLoadedChapter == 0) {
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
                    RpgAwesome.fedora,
                    color: primary.sa,
                    size: 48,
                  ),
                  const Text('Heh, thanks for reading.'),
                  // const Text('You have Helped your Homeworld'),
                  const Text("Why not share on social media?"),
                  TextButton(
                      onPressed: () => copyText(context, shareURL),
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(1, 5)),
                      ),
                      child: Text(
                        serverDisplayURL,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(decoration: TextDecoration.underline),
                      ))
                ])));
  }
}

class _HasExtraFillRemaining extends StatelessWidget {
  final VoidCallback onRequestMore;
  const _HasExtraFillRemaining({
    required super.key,
    required this.onRequestMore,
  });

  @override
  Widget build(BuildContext context) {
    GrandSwatch primary = GrandSwatch.primaryOf(context);

    return SliverToBoxAdapter(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            //Large so that user can keep scrolling, triggering another notification
            height: 200,
            color: primary.s3,
            alignment: Alignment.center,
            child: Column(
                key: const Key("fillRemCol"),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Continue"),
                  IconButton(
                    onPressed: onRequestMore,
                    icon: Icon(
                      key: const Key("fillRmIcon"),
                      Icons.more_horiz_rounded,
                      color: primary.sa,
                      size: 48,
                    ),
                  ),
                  const Text("Scroll to scroll"),
                ])));
  }
}
