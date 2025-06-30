import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/book.dart';
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/debug_chapter_selector.dart';

import '../../../../backend/chapter.dart';
import '../../icons.dart';
import '../drawer.dart';
import '../readers/debug_reader.dart';

class TestRigScroller extends StatefulWidget {
  final Book book;
  final int startChapter;
  const TestRigScroller({super.key, this.startChapter = 0, required this.book});

  @override
  State<TestRigScroller> createState() => _TestRigScrollerState();
}

class _TestRigScrollerState extends State<TestRigScroller> {
  Chapter? chapter;
  int? chapterIx;
  _TestRigScrollerState();

  @override
  void initState() {
    widget.book.getAndLoadChapter(widget.startChapter).then(_chapterGot);
    super.initState();
  }

  void _chapterGot(Chapter? chap) {
    setState(() {
      chapter = chap;
      chapterIx = chapter?.id;
    });
  }

  void _refresh() {
    dev.log("Not implemented yet");
    // int cur = chapter?.id ?? widget.startChapter;
    // widget.book.refreshChapter(cur).then(_chapterGot);
  }

  void _nextChapter() {
    int? chapterIx = this.chapterIx;
    if (chapterIx != null) {
      setState(() {
        widget.book.getAndLoadChapter(chapterIx + 1).then(_chapterGot);
      });
    } else {
      widget.book.getAndLoadChapter(widget.startChapter).then(_chapterGot);
    }
  }

  void _previousChapter() {
    int? chapterIx = this.chapterIx;
    if (chapterIx != null) {
      setState(() {
        widget.book.getAndLoadChapter(chapterIx - 1).then(_chapterGot);
      });
    } else {
      widget.book.getAndLoadChapter(widget.startChapter).then(_chapterGot);
    }
  }

  void _setChapter(int index) {
    widget.book.getAndLoadChapter(index).then(_chapterGot);
  }

  Widget scaffold(BuildContext context, {required Widget child}) {
    //TODO: Chapter file
    String appBarDisplay = '${chapter?.id}:  ${chapter?.displayTitle ?? ' ? '}';
    String elemDisplay = '(${chapter?.length} elements)';
    TextStyle greyed = const TextStyle(
        fontFamily: 'Palatino', fontSize: 12, color: Color(0x40ffffff));

    return Scaffold(
        key: const Key("TestRig"),
        endDrawer: const MenuDrawer(source: 'Scroll'),
        appBar: AppBar(
          leadingWidth: 75,
          // centerTitle: true,
          automaticallyImplyLeading: true,
          key: const Key("TestRigAppBar"),
          title: Text(
            appBarDisplay,
            maxLines: 1,
            style: greyed,
          ),
          actions: [
            Text(elemDisplay, style: greyed),
            IconButton(
                onPressed: _previousChapter,
                icon: const Icon(Icons.navigate_before)),
            // Text('${chapter?.id}'),
            ChapterSelector(onChapterChanged: _setChapter),
            IconButton(
                onPressed: _nextChapter, icon: const Icon(Icons.navigate_next)),
            IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
            const SizedBox(
              width: 50,
            )
          ],
        ),
        // backgroundColor: const Color(0xfff2ce9f),
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: const McFAB(),
        body: child);
  }

  @override
  Widget build(BuildContext context) {
    Chapter? chapter = this.chapter;

    if (chapter == null) {
      return scaffold(context,
          child: ColoredIconCard(
            text: 'Null Chapter (start=${widget.startChapter})',
            icon: RpgAwesome.bleeding_eye,
          ));
    }

    return scaffold(
      context,
      child: DebugReaderScreen(
          key: Key('DbgRdr_chp${chapter.id}'), chapter: chapter),
    );
  }
}
