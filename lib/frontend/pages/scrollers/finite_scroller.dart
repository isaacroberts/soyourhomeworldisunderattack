import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/chapter.dart';

import '../../../backend/book.dart';
import '../readers/reader.dart';

class PagingScroller extends StatefulWidget {
  final Book book;
  const PagingScroller({super.key, required this.book});

  @override
  State<PagingScroller> createState() => _PagingScrollerState();
}

class _PagingScrollerState extends State<PagingScroller> {
  int currentChapterIx = 0;
  Chapter? currentChapter;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    setChapter(0);
  }

  void setChapter(int set) async {
    dev.log("Paging scroller chp = $set");

    if (widget.book.hasKey(set)) {
      Chapter chap = widget.book.chapters[currentChapterIx];

      chap.load();

      setState(() {
        currentChapterIx = set;
        currentChapter = chap;
      });

      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
  }

  // void _onError(exception, trace) {
  //   dev.log("!! Exception !!");
  //   dev.log('$exception');
  //   dev.log('$trace');
  //   ErrorList.showError(exception, trace);
  //   setState(() {
  //     currentChapter = null;
  //   });
  // }

  void incrementChapter() {
    setChapter(currentChapterIx + 1);
  }

  Widget chapterButton() => SizedBox(
      height: 200,
      child: Center(
          child: IconButton(
              key: const Key("Chapter NextButton"),
              onPressed: incrementChapter,
              icon: const Icon(
                key: Key('ChapterNextIcon'),
                Icons.arrow_forward,
                size: 50,
                color: Colors.white,
              ))));

  @override
  Widget build(BuildContext context) {
    Chapter? chapter = currentChapter;

    if (chapter == null) {
      dev.log('Empty chapter');
      return const Placeholder();
      // return const EmptyChapterWidget();
    } else {
      return ChapterProvider(
          key: Key("ChpProv${chapter.key}"),
          chapter: chapter,
          child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                key: Key('Chp$currentChapterIx ScrollHoldCol'),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ReaderScreen(
                    key: Key("FinScr_Reader}"),
                  ),
                  Center(child: chapterButton()),
                ],
              )));
    }
  }
}
