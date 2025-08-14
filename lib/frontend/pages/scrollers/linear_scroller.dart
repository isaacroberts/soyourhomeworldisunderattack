import 'dart:collection';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/measure_sliver.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../../backend/chapter_holder.dart';
import '../../elements/holders/holder_base.dart';

class ChapterLoaderElement extends StatelessWidget {
  final String chapterName;
  const ChapterLoaderElement({super.key, required this.chapterName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400, child: TriWizardLoader(message: '$chapterName...'));
  }
}

class ChapterWaitingOrNullHolder extends Holder {
  final String chapterName;
  const ChapterWaitingOrNullHolder({required this.chapterName});
  @override
  Widget element(BuildContext context) {
    return SizedBox(
        height: 400, child: TriWizardLoader(message: '$chapterName...'));
  }

  @override
  Widget fallback(BuildContext context) {
    return SizedBox(
        height: 400,
        child: TriWizardLoader(
          message: '$chapterName...',
          colorMode: LoaderColorMode.grey,
        ));
  }

  @override
  String toText() {
    return '[Loading $chapterName...]\n';
  }
}

class LinearScroller extends StatefulWidget {
  final int startChapter;
  const LinearScroller({super.key, required this.startChapter});

  @override
  State<LinearScroller> createState() => _LinearScrollerState();
}

class _LinearScrollerState extends State<LinearScroller> {
  final ScrollController controller =
      ScrollController(debugLabel: 'LinearScrollController');
  int currentHolder = 0;
  late final Book book;

  double precedingSize = 0;

  ChapterHolder? currentChapter;
  List<ChapterHolder> _currentChapters = [];
  List<Holder> currentHolders = [];

  UnmodifiableListView<ChapterHolder> get currentChapters =>
      UnmodifiableListView(_currentChapters);

  set currentChapters(List<ChapterHolder> chapters) {
    _currentChapters = chapters;
    setState(() {});
  }

  @override
  void initState() {
    // controller.position.addListener(scrollNotification);
    controller.addListener(scrollNotification);
    super.initState();
  }

  Future<int> getStartChapter() async {
    //TODO: Get from user preferences
    await Future.delayed(const Duration(seconds: 1));
    return widget.startChapter;
  }

  @override
  void didChangeDependencies() {
    //This is where InheritedWidgets update
    book = Book.of(context);
    // currentChapters = [];
    getStartChapter().then((i) => addChapter(startChapter: i), onError: (e, t) {
      ErrorList.showError(e, t);
      addChapter(startChapter: null);
    });
    currentHolders = [
      const ChapterWaitingOrNullHolder(chapterName: 'Chapters')
    ];
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant LinearScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  double get estimateHeight {
    return currentHolders.length * 10;
  }

  void scrollNotification() {
    double heightEstimate = estimateHeight;
    ScrollDirection direction = controller.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      if (controller.offset >= heightEstimate * .75) {
        //Add chapter

        if (addChapter()) {
          dev.log("+Chapter (scroll=${controller.offset})");
        }
      }
    } else if (direction == ScrollDirection.forward) {
      //If approaching start of screen
      if (controller.offset < 400) {
        //Add chapter at start
        //Add squashed ChapterSliver
        if (addChapter(atStart: true)) {
          dev.log("+Chapter0 (scroll=${controller.offset})");
        }
      }
    } else if (direction == ScrollDirection.idle) {
      //Pass
    }
  }

  bool addChapter({bool atStart = false, int? startChapter}) {
    //Sometimes there is no next
    if (_addChapter(atStart: atStart, startChapter: startChapter)) {
      if (currentChapters.length > 3) {
        if (atStart) {
          _currentChapters.removeLast();
        } else {
          _currentChapters.removeAt(0);
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
    //Refresh view
    dev.log("ChapterLoaded ${chapterAndStream.$1.varName}");
  }

  bool _addChapter({atStart = false, int? startChapter}) {
    ChapterHolder? chapter;
    if (currentChapters.isEmpty) {
      chapter = book.chapters[startChapter ?? widget.startChapter];
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
    chapter.load().then(chapterLoaded, onError: ErrorList.showError);

    if (atStart) {
      _currentChapters.insert(0, chapter);
    } else {
      _currentChapters.add(chapter);
    }
    return true;
  }

  void chapterBecomesMain(ChapterHolder chapter) {
    dev.log("Chapter Main: ${chapter.displayName}");
    setState(() {
      currentChapter = chapter;
    });
  }

  void chapterGoesOOB(ChapterHolder chapter, bool atBottom, double pos) {
    dev.log(
        "Chapter ${chapter.varName} OOB at ${atBottom ? 'bottom' : 'top'} $pos");
    if (atBottom) {
      int ix = currentChapters.lastIndexOf(chapter);
      currentChapters = currentChapters.sublist(0, ix);
    } else {
      int ix = currentChapters.indexOf(chapter);
      precedingSize += pos;
      currentChapters = currentChapters.sublist(ix);
      // controller.jumpTo(controller.offset - pos);
    }
  }

  List<Widget> getHolderSlivers() {
    List<Widget> slivers = [];

    for (ChapterHolder chapterHolder in currentChapters) {
      Chapter? chapter = chapterHolder.chapter;
      if (chapter != null) {
        slivers.add(MeasureSliver(
            chapter: chapterHolder,
            onBecomesMain: chapterBecomesMain,
            onOOB: chapterGoesOOB));
        if (chapter.header != null) {
          slivers.add(holderBuilder(chapter.header!));
        }
        slivers.addAll(holderList(chapter.lines));
      } else {
        slivers.add(SliverToBoxAdapter(
            child:
                ChapterLoaderElement(chapterName: chapterHolder.displayName)));
        //Don't load more
        //TODO: This will eventually block scroll on failure
        return slivers;
      }
    }
    return slivers;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];
    // slivers.add(SliverAppBar(
    //   // floating: true,
    //   // pinned: false,
    //   // stretch: false,
    //   title: Text('Help, My Homeworld!'),
    // ));
    slivers.add(SliverToBoxAdapter(
        child: SizedBox(
      height: precedingSize,
    )));
    slivers.addAll(getHolderSlivers());
    slivers.add(SliverFillRemaining(
        child: Container(
      color: const Color(0x22ff0000),
    )));
    return Stack(
      alignment: Alignment.topRight,
      children: [
        if (currentChapters.isNotEmpty)
          Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Text(
                  'Chapter ${currentChapter?.displayName} (${currentChapter?.id})')),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Text('ChapterAmt: ${currentChapters.length}'),
        ),
        CustomScrollView(
          key: const Key("LinearScrollView"),
          controller: controller,
          slivers: slivers,
        )
      ],
    );
  }

  Widget holderBuilder(Holder h) {
    return SliverToBoxAdapter(
      child: h.element(context),
    );
  }

  List<Widget> holderList(List<Holder> holders, {bool growable = false}) {
    return holders.map(holderBuilder).toList(growable: growable);
  }
}
