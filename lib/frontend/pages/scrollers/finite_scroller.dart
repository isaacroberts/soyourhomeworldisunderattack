import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../../backend/error_handler.dart';
import '../../elements/widgets/empty_chapter.dart';
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
      Chapter chap = await widget.book.getAndLoadChapter(currentChapterIx);

      setState(() {
        currentChapterIx = set;
        currentChapter = chap;
      });

      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
  }

  void _onError(exception, trace) {
    dev.log("!! Exception !!");
    dev.log('$exception');
    dev.log('$trace');
    ErrorList.showError(exception, trace);
    setState(() {
      currentChapter = null;
    });
  }

  void incrementChapter() {
    setChapter(currentChapterIx + 1);
  }

  Widget buttonIcon() => const Icon(
        key: Key('ChapterNextIcon'),
        Icons.add,
        size: 50,
        color: Colors.white,
      );

  Widget chapterButton() => IconButton(
      key: Key("Chapter$currentChapter NextButton"),
      onPressed: incrementChapter,
      icon: buttonIcon());

  @override
  Widget build(BuildContext context) {
    Chapter? chp = currentChapter;

    if (chp == null) {
      dev.log('Empty chapter');
      return const EmptyChapterWidget();
    } else {
      return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            key: Key('Chp$currentChapterIx ScrollHoldCol'),
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReaderScreen(
                chapter: chp,
                scrollController: _scrollController,
              ),
              Center(child: chapterButton()),
              const SizedBox(
                height: 250,
              ),
            ],
          ));
    }
  }
}
