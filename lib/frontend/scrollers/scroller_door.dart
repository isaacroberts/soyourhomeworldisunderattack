import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_load_tools.dart';
import 'package:soyourhomeworld/frontend/pages/index.dart';
import 'package:soyourhomeworld/frontend/pages/loading_page.dart';
import 'package:soyourhomeworld/frontend/pages/server_offline_error.dart'
    deferred as server_offline_lib;
import 'package:soyourhomeworld/frontend/scrollers/finite_scroller.dart'
    deferred as finite_lib;
import 'package:soyourhomeworld/frontend/scrollers/infinite_scroller.dart'
    deferred as infinite_lib;
import 'package:soyourhomeworld/frontend/scrollers/sliver_scroller.dart';
import 'package:soyourhomeworld/frontend/scrollers/test_rig_scroller.dart'
    deferred as rig_lib;
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../../backend/book.dart';

// const ScrollerDoor scrollerDoor = ScrollerDoor();

class ScrollDoor extends StatelessWidget {
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
    return ErrorList.instance.page(context);
  }

  Widget builder(BuildContext context, AsyncSnapshot<Book?> bookSnapshot) {
    if (bookSnapshot.hasData) {
      return BookProvider(
          book: bookSnapshot.data!,
          child: _ScrollerPicker(
            book: bookSnapshot.data!,
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
          child: _ScrollerPicker(
            book: book,
            startChapter: startChapter,
          ));
    }
  }
}

class _ScrollerPicker extends StatelessWidget {
  const _ScrollerPicker({
    required this.book,
    required this.startChapter,
  });

  final Book book;
  final int? startChapter;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: ViewSettings.instance.scrollModeNotifier, builder: builder);
  }

  Widget builder(BuildContext context, Widget? child) {
    ViewSettings settings = ViewSettings.instance;

    //TODO: Get

    switch (settings.scrollMode) {
      case ScrollMode.sliver:
//No deferred load because sliver is already default
        return SliverScroller(
          key: const Key("SliverScroller"),
          startChapter: startChapter,
        );
      case (ScrollMode.infinitePackage):
        if (settings.useTestRig) {
          return DeferredPage(
              key: const Key("DeferredRigLib"),
              loader: () => rig_lib.loadLibrary(),
              builder: (context) => rig_lib.TestRigScroller(
                    book: book,
                    startChapter: startChapter ?? 0,
                  ));
        } else {
          return DeferredPage(
              key: const Key("DeferredInfinite"),
              loader: () => infinite_lib.loadLibrary(),
              builder: (context) => infinite_lib.MasterScroller(
                    key: const Key('Master'),
                    book: book,
                    startChapter: startChapter ?? 0,
                  ));
        }
      case (ScrollMode.paged):
        //TODO: Put DebugReader on PagingScroller
        return McScaffold(
            source: 'scroll',
            key: const Key("PagingScroller"),
            child: DeferredWidget(
                loader: () => finite_lib.loadLibrary(),
                builder: (context) => finite_lib.PagingScroller(
                    key: const Key("Pager!"), book: book)));
    }
  }
}
