import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/index.dart';
import 'package:soyourhomeworld/frontend/pages/loading_page.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/finite_scroller.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/infinite_scroller.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/test_rig_scroller.dart';

import '../backend/book.dart';

// const ScrollerDoor scrollerDoor = ScrollerDoor();

bool useInfiniteScroll = true;

class ScrollDoor extends StatelessWidget {
  final int startChapter;
  final bool testRig;
  const ScrollDoor({super.key, this.startChapter = 0, this.testRig = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Book?>(
        future: BookLoader.mckinsey().load(), builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot<Book?> bookSnapshot) {
    if (bookSnapshot.hasError) {
      ErrorList.logError(bookSnapshot.error!, bookSnapshot.stackTrace);
      //Continue with error
    }
    if (bookSnapshot.hasData) {
      if (bookSnapshot.data == null) {
        ErrorList.logError(Exception('Null book'));
        return ErrorList.instance.page(context);
      } else {
        return BookProvider(
            book: bookSnapshot.data!,
            child: _ScrollerPicker(
                book: bookSnapshot.data!,
                startChapter: startChapter,
                testRig: testRig));
      }
    } else {
      if (bookSnapshot.hasError) {
        // If no data, assume loading has failed
        return ErrorList.instance.page(context);
      } else {
        // Otherwise show loader
        return const LoadingPage(message: 'Loading index...');
      }
    }
  }
}

class NamedChapterScrollerDoor extends StatelessWidget {
  final int startChapter;
  final String? chapterName;
  final bool testRig;
  const NamedChapterScrollerDoor(
      {super.key,
      this.startChapter = 0,
      this.testRig = false,
      this.chapterName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Book?>(
        future: BookLoader.mckinsey().load(), builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot<Book?> bookSnapshot) {
    if (bookSnapshot.hasError) {
      ErrorList.logError(bookSnapshot.error!, bookSnapshot.stackTrace);
      //Continue with error
    }
    if (bookSnapshot.hasData) {
      if (bookSnapshot.data == null) {
        ErrorList.logError(Exception('Null book'));
        return ErrorList.instance.page(context);
      } else {
        return successfulLoad(bookSnapshot.data!);
      }
    } else {
      if (bookSnapshot.hasError) {
        // If no data, assume loading has failed
        return ErrorList.instance.page(context);
      } else {
        // Otherwise show loader
        return const LoadingPage(message: 'Loading index...');
      }
    }
  }

  Widget successfulLoad(Book book) {
    int? startChapter;
    if (chapterName != null) {
      startChapter = book.findChapterBySearchTerm(chapterName!);
    }

    if (startChapter == null) {
      dev.log("Couldn't find chapter $chapterName");
      ErrorList.logError(Exception("Couldn't find chapter $chapterName"));
      return McScaffold(
          source: 'scroll',
          child: BookProvider(
              book: book, child: SearchIndexWidget(searchTerm: chapterName)));
    } else {
      return McScaffold(
          source: 'scroll',
          child: BookProvider(
              book: book,
              child: _ScrollerPicker(
                book: book,
                startChapter: startChapter,
                testRig: testRig,
              )));
    }
  }
}

class _ScrollerPicker extends StatelessWidget {
  const _ScrollerPicker({
    required this.book,
    required this.startChapter,
    this.testRig = false,
  });

  final Book book;
  final int startChapter;
  final bool testRig;

  @override
  Widget build(BuildContext context) {
    if (testRig || TEST_RIG) {
      // TODO: Save startChapter somewhere
      return TestRigScroller(
        book: book,
        startChapter: startChapter,
      );
    }

    // return FuckedUpScroller(spider: ChapterSpider(startChp: 0));

    if (useInfiniteScroll) {
      return MasterScroller(
        key: Key('Master!${book.id}_$startChapter'),
        book: book,
        startChapter: startChapter,
      );
    } else {
      return McScaffold(
          source: 'scroll',
          key: Key("!ScrollEntry${book.id}_$startChapter"),
          child: PagingScroller(key: const Key("Pager!"), book: book));
    }
  }
}
