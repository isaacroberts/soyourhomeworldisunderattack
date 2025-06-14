import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:soyourhomeworld/backend/book.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/title.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/chapter_end.dart';
import 'package:soyourhomeworld/frontend/pages/readers/reader.dart';

import '../../../../backend/chapter.dart';
import '../../../../backend/error_handler.dart';
import '../../styles.dart';
import '../loading_page.dart';

class MasterScroller extends StatefulWidget {
  final Book book;
  final int startChapter;
  const MasterScroller({super.key, required this.book, this.startChapter = 0});

  @override
  State<MasterScroller> createState() => _MasterScrollerState();
}

class _MasterScrollerState extends State<MasterScroller> {
  late final PagingController<int, Chapter> _pagingController;
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: false);

  // static final GlobalKey<_MasterScrollerState> _counterKey = GlobalKey();

  _MasterScrollerState();

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, Chapter>(
      firstPageKey: widget.startChapter,
      invisibleItemsThreshold: 1,
    );
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void didUpdateWidget(covariant MasterScroller oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // if (widget.startChapter != oldWidget.st)
    // _pagingController.nextPageKey = widget.startChapter;
  }

  void scrollToChapter() {
    // _scrollController.
  }

  @override
  Widget build(BuildContext context) {
    // dev.log("Start chapter = ${widget.startChapter}");
    return McScaffold(
        key: const ValueKey('InfScrollScaffold!'),
        source: 'Scroll',
        // showAppCTA: false,
        // showAppCTA: widget.startChapter == 0,
        // showAds: false,
        child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            // behavior: MaterialScrollBehavior().copyWith(scrollbars: false),
            child: PagedListView<int, Chapter>(
              key: const ValueKey("InfPagedListView!"),
              scrollController: _scrollController,

              // physics: const ScrollWizard(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: itemBuilder,
                firstPageErrorIndicatorBuilder: _firstPageErrorIndicator,
                newPageErrorIndicatorBuilder: _newPageErrorIndicatorBuilder,
                noItemsFoundIndicatorBuilder: _noItemsFoundIndicatorBuilder,
                noMoreItemsIndicatorBuilder: _noMoreItemsIndicatorBuilder,
                firstPageProgressIndicatorBuilder:
                    _firstPageProgressIndicatorBuilder,
              ),
              // separatorBuilder: separator,
            )));
  }

  // ==== Subwidgets ===========

  Widget separator(BuildContext context, int ix) {
    return const SizedBox(
      height: 48,
    );
  }

  // ======= Page related ======================

  Widget itemBuilder(BuildContext context, Chapter chapter, int index) {
    if (index == 0 && chapter.isTitle) {
      return const TitleWidget(
        key: Key("title"),
      );
    }
    return ReaderScreen(
        key: Key("Reader_${chapter.id}"),
        scrollController: _scrollController,
        chapter: chapter);
  }

  Future<void> _fetchPage(int pageKey) async {
    // dev.log('fetch $pageKey');

    dev.log("Getting page $pageKey");
    if (widget.book.hasKey(pageKey)) {
      try {
        Chapter chap = await widget.book.getAndLoadChapter(pageKey);

        // dev.log('(InfScroll) Factoried Chapter = $chap ${chap.length}');
        // TODO: You could do funky navigation with the nextPageKey here.
        // final nextPageKey = pageKey + 1;
        final nextPageKey = chap.nextId;
        dev.log("Next key: $nextPageKey");
        _pagingController.appendPage([chap], nextPageKey);
      } catch (exception, stackTrace) {
        dev.log(exception.toString(), stackTrace: stackTrace);
        ErrorList.showError(exception, stackTrace);
      }
    } else {
      _pagingController.appendLastPage([]);
    }
  }

  // void waitForChapter(Chapter chapter) async {
  //   if (!chapter.loaded) {
  //     await chapter.load();
  //     // setState(() {});
  //   }
  // }

  List<Widget> headerGetter(BuildContext context, bool innerBoxIsScrolled) {
    return [
      const SliverAppBar(
        pinned: true,
        title: Text('Header', style: headerFont),
      )
    ];
  }

  // ===== Screen Handlers  =====

  Widget _firstPageErrorIndicator(BuildContext context) {
    return const ErrorBox(text: 'First Page InfScroll Error');
  }

  Widget _newPageErrorIndicatorBuilder(BuildContext context) {
    return const ErrorBox(text: 'New Page InfScroll Error');
  }

  Widget _noItemsFoundIndicatorBuilder(BuildContext context) {
    return const LoadingPage(message: 'No chapters...');
  }

  Widget _noMoreItemsIndicatorBuilder(BuildContext context) {
    return LayoutBuilder(builder: _noMoreItemsIndicatorLayoutBuilder);
  }

  Widget _noMoreItemsIndicatorLayoutBuilder(
      BuildContext context, BoxConstraints constraints) {
    return const ChapterEnd();
  }

  Widget _firstPageProgressIndicatorBuilder(BuildContext context) {
    return const LoadingPage();
  }

  void nullCallback() {}
}
