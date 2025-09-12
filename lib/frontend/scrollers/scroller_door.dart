import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_load_tools.dart';
import 'package:soyourhomeworld/frontend/pages/index.dart';
import 'package:soyourhomeworld/frontend/pages/loading_page.dart';
import 'package:soyourhomeworld/frontend/pages/server_offline_error.dart'
    deferred as server_offline_lib;
import 'package:soyourhomeworld/frontend/scrollers/sliver_scroller.dart';

import '../../../backend/book.dart';

// const ScrollerDoor scrollerDoor = ScrollerDoor();

//TODO: Refactor out?
class ScrollDoor extends StatelessWidget {
  //This only does the bookProvider
  static const defaultStart = 0;

  final int startChapter;
  const ScrollDoor({super.key, this.startChapter = defaultStart});
  const ScrollDoor.nullSafe({super.key, required int? startChapter})
      : startChapter = startChapter ?? defaultStart;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Book?>(
        future: BookLoader.instance.load(), builder: builder);
  }

  static Widget bookErrorBuilder(
      BuildContext context, AsyncSnapshot<Book?> bookSnapshot) {
    ErrorList.logError(bookSnapshot.error!, bookSnapshot.stackTrace);

    String exceptionType = bookSnapshot.error.runtimeType.toString();
    if (exceptionType == '_ClientSocketException') {
      return DeferredPage(
          key: const Key("DeferredServerOffline"),
          loader: server_offline_lib.loadLibrary,
          builder: (context) => server_offline_lib.ServerOfflinePage(
              exception: bookSnapshot.error!,
              stackTrace: bookSnapshot.stackTrace));
    }

    if (bookSnapshot.data == null) {}

    // Assume loading has failed
    return ErrorList.page(context);
  }

  Widget builder(BuildContext context, AsyncSnapshot<Book?> bookSnapshot) {
    if (bookSnapshot.hasData) {
      return BookProvider(
          book: bookSnapshot.data!,
          child: SliverScroller(
            key: const Key("SliverScroller"),
            startChapter: startChapter,
          ));
    } else if (bookSnapshot.hasError) {
      return bookErrorBuilder(context, bookSnapshot);
    } else {
      // Otherwise show loader
      return const LoadingPage(
          key: Key("LoadingPage"), message: 'Loading index...');
    }
  }
}

class NamedChapterScrollerDoor extends StatelessWidget {
  final String? chapterName;
  const NamedChapterScrollerDoor({super.key, this.chapterName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Book?>(
        future: BookLoader.instance.load(), builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot<Book?> bookSnapshot) {
    if (bookSnapshot.hasData) {
      return successfulLoad(bookSnapshot.data!);
    } else if (bookSnapshot.hasError) {
      ErrorList.logError(bookSnapshot.error!, bookSnapshot.stackTrace);
      return ScrollDoor.bookErrorBuilder(context, bookSnapshot);
    } else {
      // Otherwise show loader
      return const LoadingPage(
          key: Key("LoadingPage"), message: 'Loading index...');
    }
  }

  Widget successfulLoad(Book book) {
    int? startChapter;
    dev.log("Looking for chapter: $chapterName");
    if (chapterName != null) {
      startChapter = book.findChapterBySearchTerm(chapterName!);
    }

    if (startChapter == null) {
      dev.log("Couldn't find chapter $chapterName");
      ErrorList.logError(Exception("Couldn't find chapter $chapterName"));
      return SearchIndexPage(
          key: const Key("SearchIndex"), searchTerm: chapterName);
    } else {
      return BookProvider(
          book: book,
          child: SliverScroller(
            key: const Key("SliverScroller"),
            startChapter: startChapter,
          ));
    }
  }
}
