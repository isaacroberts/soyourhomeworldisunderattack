import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/book.dart';
import 'package:soyourhomeworld/backend/chapter.dart';
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/debug_chapter_selector.dart';

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
    chapter = widget.book.chapters[chapterIx ?? 0];
    super.initState();
  }

  void setChapter(int ix) {
    setState(() {
      chapter = widget.book.chapters[ix];
      chapterIx = ix;
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
      setChapter(chapterIx);
    } else {
      setChapter(widget.startChapter);
    }
  }

  void _previousChapter() {
    int? chapterIx = this.chapterIx;
    if (chapterIx != null) {
      setState(() {
        setChapter(chapterIx - 1);
      });
    } else {
      setChapter(widget.startChapter);
    }
  }

  Widget scaffold(BuildContext context, {required Widget child}) {
    //TODO: Chapter file
    String appBarDisplay = '${chapter?.id}:  ${chapter?.displayTitle ?? ' ? '}';
    String elemDisplay = '(${chapter?.data?.length} elements)';
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
            ChapterSelector(onChapterChanged: setChapter),
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
    if (chapter == null) {
      return ColoredIconCard(
        text: 'Null Chapter (start=${widget.startChapter})',
        icon: RpgAwesome.bleeding_eye,
      );
    } else {
      return ChapterProvider(
          key: Key("Chp_${chapter!.key}"),
          chapter: chapter!,
          child: scaffold(
            context,
            child: const SingleChildScrollView(
                child: DebugReaderScreen(key: Key('DbgRdr'))),
          ));
    }
  }
}
