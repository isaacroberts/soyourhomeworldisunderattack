import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter_info.dart';

/// This is for the DebugReader.
///
/// This is the table of chapter ID's that pop up
/// TODO: Change to varNames
///
///
class ChapterSelector extends StatefulWidget {
  final int startChapter;
  final void Function(ChapterKey) onChapterChanged;
  const ChapterSelector(
      {super.key, this.startChapter = 1, required this.onChapterChanged});

  @override
  State<ChapterSelector> createState() => _ChapterSelectorState();
}

class _ChapterSelectorState extends State<ChapterSelector> {
  late int currentChapter;

  @override
  void initState() {
    super.initState();

    currentChapter = widget.startChapter;
  }

  void gridSelected(int index) {
    widget.onChapterChanged(index);
    Navigator.pop(context);
  }

  void openDialog(_) {
    dev.log("Open dialog");
    ChapterSelectorGrid.pushChapterSelectorGrid(context,
        book: Book.of(context), onChapterSelected: gridSelected);
  }

  @override
  Widget build(BuildContext context) {
    return _TextSquare(
        key: Key("TextSquare_$currentChapter"),
        chapterNo: currentChapter,
        onPressed: openDialog);
  }
}

class _TextSquare extends StatelessWidget {
  final int chapterNo;
  final void Function(int) onPressed;
  const _TextSquare(
      {super.key, required this.chapterNo, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: TextButton(
          onPressed: () => onPressed(chapterNo),
          child: Text(
            '$chapterNo',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(),
          )),
    );
  }
}

class ChapterSelectorGrid extends PopupRoute {
  final bool show0;
  final void Function(int) onChapterSelected;

  static void pushChapterSelectorGrid(BuildContext context,
      {required void Function(int) onChapterSelected,
      required Book book,
      bool show0 = true}) {
    Navigator.push(
        context,
        ChapterSelectorGrid(
            book: book, show0: show0, onChapterSelected: onChapterSelected));
  }

  ChapterSelectorGrid({
    required this.onChapterSelected,
    required this.book,
    this.show0 = true,
    // super.filter,
  }) : super(
            settings: const RouteSettings(name: 'ChapterSelectorGrid'),
            requestFocus: true,
            //Direction arrow keys will loop grid
            directionalTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
            //Regular traversal will leave the unimportant grid
            traversalEdgeBehavior: TraversalEdgeBehavior.parentScope);

  final Book book;

  @override
  Color get barrierColor => const Color(0x00000000);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Barrier';

  @override
  bool get opaque => false;

  void boxSelected(int index, BuildContext context) {
    if (canPop) {
      Navigator.pop(context);
    }
    onChapterSelected(index);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // var offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
    //     .animate(animation);

    return FadeTransition(
        opacity: animation,
        child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            child: SizedBox(
                width: 300,
                height: 400,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: BookProvider(
                        book: book,
                        child: ChapterSelectorWidget(
                          onChapterSelected: (i) => boxSelected(i, context),
                          show0: show0,
                        ))))));
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}

class ChapterSelectorWidget extends StatelessWidget {
  final void Function(int) onChapterSelected;
  final bool show0;
  const ChapterSelectorWidget(
      {super.key, required this.onChapterSelected, this.show0 = true});

  Widget? itemBuilder(BuildContext context, int index) {
    if (!show0) {
      index += 1;
    }
    if (index < Book.of(context).chapterAmt) {
      return _TextSquare(chapterNo: index, onPressed: onChapterSelected);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1,
            mainAxisExtent: 25),
        itemBuilder: itemBuilder);
  }
}
