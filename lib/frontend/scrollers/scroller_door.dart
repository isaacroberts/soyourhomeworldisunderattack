import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_load_tools.dart';
import 'package:soyourhomeworld/frontend/pages/loading_page.dart';
//Custom element to tell developer to start the server
import 'package:soyourhomeworld/frontend/pages/server_offline_error.dart'
    deferred as server_offline_lib;
import 'package:soyourhomeworld/frontend/pages/sidebar/sidebar.dart';
import 'package:soyourhomeworld/frontend/readers/reader_bg.dart';
//TODO: Defer
import 'package:soyourhomeworld/frontend/scrollers/sliver_scroller.dart';
import 'package:soyourhomeworld/frontend/theme/layout_constants.dart';

//TODO: Defer
import '../../../backend/book.dart';
import '../../backend/chapter.dart';
import '../../backend/part_id.dart';
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
    dev.log("Book error");
    setState(() {
      this.exception = ExceptionHolder(exception: exception, stackTrace: trace);
    });
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

  //Brothers
  final ValueNotifier<Chapter?> currentChapter = ValueNotifier(null);

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
    return _ScrollerScaffold(
        key: const Key('scscf'),
        hasIndex: true,
        child: MediumView(currentChapter: currentChapter, widget: widget));
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

class _ScrollerScaffold extends StatelessWidget {
  const _ScrollerScaffold({
    required super.key,
    required this.hasIndex,
    required this.child,
  });
  final Widget child;
  final bool hasIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key("Scaffold"),
        //Only needs background on Small
        //The un-expanded doesn't have a BG, currently
        backgroundColor: hasIndex ? null : NoirPrimary.shade2,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        //Sorry. The drawer has to switch when the index is present.
        //This is because the drawerButton's side needs to match the drawer. (This is automatic in flutter.)
        //A left-side drawer interferes with the title

        // drawer: hasIndex
        //     ? const MenuDrawer(key: Key('drawer'), source: 'scroll')
        //     : null,
        endDrawer: const MenuDrawer(key: Key('drawer'), source: 'scroll'),

        // floatingActionButton: const McFAB(),
        body: child);
  }
}

class MediumView extends StatelessWidget {
  const MediumView({
    super.key,
    required this.currentChapter,
    required this.widget,
  });

  final ValueNotifier<Chapter?> currentChapter;
  //TODO: Why?
  final _BookLoadedScrollDoor widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('R'),
      alignment: Alignment.centerLeft,
      fit: StackFit.expand,
      children: [
        //Index

        //Reader
        //This is expanded to fill space because gutter needs to scroll
        Padding(
            padding: const EdgeInsets.only(left: collapsedIndexWidth),
            child: _StackedScroller(
                key: const Key("stk"),
                startChapter: widget.startChapter,
                currentChapter: currentChapter,
                hasIndex: false)),
        Align(
            alignment: Alignment.centerLeft,
            child: Sidebar(
              key: const Key('sidebar'),
              currentChapter: currentChapter,
            )),
      ],
    );
  }
}

/*
class WideView extends StatelessWidget {
  const WideView({
    super.key,
    required this.currentChapter,
    required this.widget,
  });

  final ValueNotifier<Chapter?> currentChapter;
  final _BookLoadedScrollDoor widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('R'),
      children: [
        //Index
        SidebarIndex(
          key: const Key('sidebar'),
          currentChapter: currentChapter,
        ),
        //Reader
        //This is expanded to fill space because gutter needs to scroll
        Expanded(
            key: const Key('Exp'),
            child:
                // Stack(children: [],)
                _StackedScroller(
              key: const Key("stk"),
              startChapter: widget.startChapter,
              hasIndex: false,
              currentChapter: currentChapter,
            )
            // SliverScroller(
            //   key: const Key("SliverScroller"),
            //   startChapter: widget.startChapter,
            //   hasIndex: true,
            // )
            ),
      ],
    );
  }
}
*/
class _StackedScroller extends StatelessWidget {
  final StartChapter startChapter;
  final ValueNotifier<Chapter?> currentChapter;
  final bool hasIndex;
  const _StackedScroller(
      {super.key,
      required this.startChapter,
      required this.hasIndex,
      required this.currentChapter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('mnStx'),
      fit: StackFit.expand,
      children: [
        ChangingBg(key: const Key("bgChgr"), currentChapter: currentChapter),
        SliverScroller(
            key: const Key('SliverScroller'),
            startChapter: startChapter,
            currentChapter: currentChapter,
            hasIndex: hasIndex),
      ],
    );
  }
}

class ChangingBg extends StatefulWidget {
  const ChangingBg({super.key, required this.currentChapter});

  final ValueNotifier<Chapter?> currentChapter;

  @override
  State<StatefulWidget> createState() => _ChangingBgState();
}

class _ChangingBgState extends State<ChangingBg>
    with SingleTickerProviderStateMixin {
  Chapter? get chapter => widget.currentChapter.value;
  PartId get part => chapter?.part ?? PartId.noir;

  PartId currentPart = PartId.noir;
  PartId lastPart = PartId.noir;

  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    widget.currentChapter.addListener(chapterChanged);
    super.initState();
  }

  @override
  void dispose() {
    animationController.removeListener(chapterChanged);
    super.dispose();
  }

  void chapterChanged() {
    //Part => chapter?.part
    //currentPart: variable
    if (currentPart != part) {
      if (animationController.isCompleted) {
        animationController.reset();
        lastPart = currentPart;
      }
      setState(() {
        currentPart = part;
      });
      animationController.animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (animationController.isAnimating) {
      return Stack(
        key: const Key('bgStx'),
        fit: StackFit.expand,
        children: [
          getGradientBg(lastPart),
          FadeTransition(
              key: const Key('bgForeFade'),
              opacity: animationController,
              child: getGradientBg(currentPart)),
        ],
      );
    } else {
      return getGradientBg(currentPart);
    }
  }
}
