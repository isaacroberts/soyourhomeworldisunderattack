import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_load_tools.dart';
import 'package:soyourhomeworld/frontend/pages/index/sidebar_index.dart';
import 'package:soyourhomeworld/frontend/pages/loading_page.dart';
//Custom element to tell developer to start the server
import 'package:soyourhomeworld/frontend/pages/server_offline_error.dart'
    deferred as server_offline_lib;
import 'package:soyourhomeworld/frontend/readers/reader_bg.dart';
//TODO: Defer
import 'package:soyourhomeworld/frontend/scrollers/sliver_scroller.dart';
import 'package:soyourhomeworld/frontend/theme/layout_constants.dart';

//TODO: Defer
import '../../../backend/book.dart';
import '../../backend/start_chapter.dart';
import '../pages/drawer.dart';
import '../parts/noir_colors.dart';

///Handles the central reader layout
///Formerly chose the scroller mode
class ScrollDoor extends StatefulWidget {
  final StartChapter startChapter;

  const ScrollDoor(
      {required super.key, this.startChapter = defaultStartChapter});
  @override
  State<StatefulWidget> createState() => _ScrollDoorState();
}

Future<Book> combinedFuture() async {
  //deferrals

  //This will short-circuit if already loaded
  return BookLoader.instance.load();
}

class _ScrollDoorState extends State<ScrollDoor> {
  Book? book;
  ExceptionHolder? exception;

  @override
  void initState() {
    super.initState();
    BookLoader.instance.load().then(onFutureCompleted, onError: onBookError);
  }

  void onFutureCompleted(Book book) {
    setState(() {
      this.book = book;
    });
  }

  void onBookError(exception, trace) {
    this.exception = ExceptionHolder(exception: exception, stackTrace: trace);
    //Show snackbar
    ErrorList.showError(exception, trace);
  }

  @override
  Widget build(BuildContext context) {
    //start futures
    if (exception != null) {
      return bookErrorBuilder(context);
    } else if (book == null) {
      //Loading page
      return const LoadingPage(
          key: Key('loadingBook'), message: 'Loading book...');
    } else {
      //Now choose layout
      //This is why we avoided a FutureBuilder
      return BookProvider(
          book: book!,
          child: _BookLoadedScrollDoor(
              key: const Key('door2'), startChapter: widget.startChapter));
    }
  }

  Widget bookErrorBuilder(BuildContext context) {
//Check type
    String exceptionType = exception!.exception.runtimeType.toString();
    //ClientSocketException = couldn't connect to server
    if (exceptionType == '_ClientSocketException') {
      //Tell developer to start server
      //Deferred load
      return DeferredPage(
          key: const Key("DeferredServerOffline"),
          loader: server_offline_lib.loadLibrary,
          builder: (context) => server_offline_lib.ServerOfflinePage(
              exception: exception!.exception,
              stackTrace: exception!.stackTrace));
    }

    // Assume loading has failed
    //Show error page
    return ErrorList.page(context);
  }
}

class _BookLoadedScrollDoor extends StatefulWidget {
  final StartChapter startChapter;
  const _BookLoadedScrollDoor({super.key, required this.startChapter});

  @override
  State<_BookLoadedScrollDoor> createState() => _BookLoadedScrollDoorState();
}

class _BookLoadedScrollDoorState extends State<_BookLoadedScrollDoor>
    with SingleTickerProviderStateMixin {
  //For polling error
  Timer? timer;

  @override
  void initState() {
    super.initState();
    //For ErrorSnackbars

    //Avoid showing ErrorSnackbar immediately upon open
    Future.delayed(
        const Duration(seconds: kDebugMode ? 1 : 10), startErrorChecking);
  }

  @override
  Widget build(BuildContext context) {
    // Part part = getPartImmediate(PartId.noir);
    return
        // Theme(
        //   key: const Key("Theme"),
        //   data: part.theme,
        //   child:
        Scaffold(
            key: const Key("Scaffold"),
//Only needs background on Small
            //On medium, the ReaderWidth will color the background
            backgroundColor: NoirPrimary.shade2,
            extendBody: true,
            endDrawer: const MenuDrawer(key: Key('drawer'), source: 'scroll'),
            // floatingActionButton: const McFAB(),
            body: DecoratedBox(
                decoration: getReaderGradient(),
                child: LayoutBuilder(
                    key: const Key('pageLayout'), builder: layoutBuilder)));
  }

  Widget layoutBuilder(BuildContext context, BoxConstraints constraints) {
    if (constraints.maxWidth > maxReaderWidth + indexSidebarWidth) {
      return Row(
        key: const Key('R'),
        children: [
          //Index
          const SizedBox(
              key: Key('indexW'),
              width: indexSidebarWidth,
              child: SidebarIndex(key: Key('sidebar'))),
          //Reader
          //This is expanded to fill space because gutter needs to scroll
          Expanded(
              key: const Key('Exp'),
              child:
                  // Stack(children: [],)
                  _StackedScroller(
                      key: const Key("stk"),
                      startChapter: widget.startChapter,
                      hasIndex: false)
              // SliverScroller(
              //   key: const Key("SliverScroller"),
              //   startChapter: widget.startChapter,
              //   hasIndex: true,
              // )
              ),
        ],
      );
    } else if (constraints.maxWidth > minReaderWidth + indexSidebarWidth) {
      return Row(
        key: const Key('R'),
        children: [
          //Index
          const SizedBox(
              key: Key('indexW'),
              width: indexSidebarWidth,
              child: SidebarIndex(key: Key('sidebar'))),

          //Reader
          //This is expanded to fill space because gutter needs to scroll
          Expanded(
              key: const Key('Exp'),
              // width: minReaderWidth,
              child: _StackedScroller(
                  key: const Key("stk"),
                  startChapter: widget.startChapter,
                  hasIndex: false)
              // child: SliverScroller(
              //   key: const Key("SliverScroller"),
              //   startChapter: widget.startChapter,
              //   hasIndex: true,
              // )
              ),
        ],
      );
    } else //if (constraints.maxWidth < maxReaderWidth) {
    {
      return _StackedScroller(
          key: const Key("stk"),
          startChapter: widget.startChapter,
          hasIndex: false);
      //Small / medium
      return SliverScroller(
        key: const Key("SliverScroller"),
        startChapter: widget.startChapter,
        hasIndex: false,
      );
    }
  }

  void startErrorChecking() {
    //For ErrorSnackbars
    timer = Timer.periodic(const Duration(seconds: 1), checkScaffold);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkScaffold(Timer timer) {
    if (mounted) {
      ErrorList.instance.checkSnackbar(context);
    }
  }
}

class _StackedScroller extends StatelessWidget {
  final StartChapter startChapter;
  final bool hasIndex;
  const _StackedScroller(
      {super.key, required this.startChapter, required this.hasIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const SoftReaderBg(),
        SliverScroller(
            key: const Key('SliverScroller'),
            startChapter: startChapter,
            hasIndex: hasIndex),
      ],
    );
  }
}
