/*
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

    ViewSettings.instance.testRigNotifier.addListener(testRigChanged);
  }

  @override
  void dispose() {
    ViewSettings.instance.testRigNotifier.removeListener(testRigChanged);
    super.dispose();
  }

  void testRigChanged() {
    setState(() {});
  }

  void scrollToChapter() {
    //TODO:
  }

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        key: const ValueKey('InfScrollScaffold!'),
        source: 'Scroll',
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
    if (index == 0) {
      return ChapterAndPartProvider(
          key: const Key("ChpTitle"),
          chapter: chapter,
          child: const TitleWidget(
            key: Key("title"),
          ));
    }
    if (ViewSettings.instance.useTestRig) {
      return ChapterAndPartProvider(
          key: Key("Chp${chapter.id}"),
          chapter: chapter,
          child: const DebugReaderScreen(
            key: Key("DebugReader"),
          ));
    }

    return ChapterAndPartProvider(
        key: Key("Chp${chapter.id}"),
        chapter: chapter,
        child: const ReaderScreen(
          key: Key("Reader"),
          // scrollController: _scrollController,
        ));
  }

  Future<void> _fetchPage(int pageKey) async {
    // dev.log('fetch $pageKey');

    // dev.log("Getting page $pageKey");
    if (widget.book.hasKey(pageKey)) {
      try {
        Chapter chap = widget.book.chapters[pageKey];
        chap.load();
        // dev.log('(InfScroll) Factoried Chapter = $chap ${chap.length}');
        // TODO: You could do funky navigation with the nextPageKey here.
        // final nextPageKey = pageKey + 1;
        final nextPageKey = chap.nextId;
        // dev.log("Next key: $nextPageKey");
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
    return const LoadingPage(
        key: Key("LoadingPage"), message: 'No chapters...');
  }

  Widget _noMoreItemsIndicatorBuilder(BuildContext context) {
    return LayoutBuilder(builder: _noMoreItemsIndicatorLayoutBuilder);
  }

  Widget _noMoreItemsIndicatorLayoutBuilder(
      BuildContext context, BoxConstraints constraints) {
    return const ChapterEnd();
  }

  Widget _firstPageProgressIndicatorBuilder(BuildContext context) {
    return const LoadingPage(
      key: Key("LoadingPage"),
      message: 'Loading first page...',
    );
  }

  void nullCallback() {}
}
*/
