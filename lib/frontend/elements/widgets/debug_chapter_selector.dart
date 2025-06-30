import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/chapter.dart';

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
    Navigator.push(context, ChapterSelectorGrid(onSelected: gridSelected));
  }

  @override
  Widget build(BuildContext context) {
    return _TextSquare(chapterNo: currentChapter, onPressed: openDialog);
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
          onPressed: () => onPressed(chapterNo), child: Text('$chapterNo')),
    );
  }
}

class ChapterSelectorGrid extends PopupRoute {
  final void Function(int) onSelected;
  ChapterSelectorGrid({required this.onSelected});

  @override
  Color get barrierColor => const Color(0x00000000);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Barrier';

  @override
  bool get opaque => false;

  void boxSelected(int index) {
    onSelected(index);
  }

  Widget itemBuilder(BuildContext context, int index) {
    return _TextSquare(chapterNo: index, onPressed: boxSelected);
  }

  Widget grid(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1,
            mainAxisExtent: 25),
        itemBuilder: itemBuilder);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // var offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
    //     .animate(animation);

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 16,
        child: SizedBox(
            width: 300,
            height: 400,
            child: Padding(
                padding: const EdgeInsets.all(5), child: grid(context))));
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}
