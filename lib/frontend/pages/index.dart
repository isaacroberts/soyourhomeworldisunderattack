import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../backend/book.dart';
import '../../backend/chapter.dart';
import '../book_waiter.dart';
import '../elements/scaffold.dart';
import '../extra_styles.dart';

class IndexWidget extends StatelessWidget {
  const IndexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Book book = Book.of(context);
    return ListView.builder(
        // controller: controller,
        physics: const BouncingScrollPhysics(),
        // prototypeItem: Container(width: 800),
        itemBuilder: (context, ix) {
          if (ix >= book.chapterAmt) {
            return null;
          }
          return ListTile(
              title: Text(book.getChapterName(ix)),
              onTap: () {
                context.go('/scroll/$ix');
                // context.goNamed('/scroll',
                //     pathParameters: {'chid': ix.toString()});
              });
        });
  }
}

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchIndexPage();
    return const McScaffold(
        source: 'index', child: StdBookWaiter(child: IndexWidget()));
  }
}

class SearchIndexPage extends StatelessWidget {
  final String? searchTerm;
  const SearchIndexPage({super.key, this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'search',
        child: StdBookWaiter(child: SearchIndexWidget(searchTerm: searchTerm)));
  }
}

class SearchIndexWidget extends StatefulWidget {
  /*
      The index, but with a searched term that was not found

      [SearchIcon]  _desert_____

      1. Rachel
      2. Sarah
      3. Nevada [Desert]
   */
  final String? searchTerm;
  const SearchIndexWidget({super.key, required this.searchTerm});

  @override
  State<SearchIndexWidget> createState() => _SearchIndexWidgetState();
}

class _SearchIndexWidgetState extends State<SearchIndexWidget> {
  // late final TextEditingController controller;
  // String? currentSearchTerm;
  late final SearchController controller;
  @override
  void initState() {
    super.initState();
    controller = SearchController();
    controller.text = widget.searchTerm ?? '';
    // currentSearchTerm = widget.searchTerm;
    // controller = TextEditingController(text: widget.searchTerm);
  }

  // void onTextChange(String? text) {
  //   setState(() {
  //     currentSearchTerm = controller.text;
  //   });
  // }

  Iterable<ChapterHolder> suggestions(SearchController controller) sync* {
    Book? book = Book.maybeOf(context);
    if (book == null) {
      return;
    }
    for (ChapterHolder chapter in book.chapters) {
      if (chapter.displayName.contains(controller.text)) {
        yield chapter;
      }
    }
  }

  Iterable<Widget> suggestionBuilder(
      BuildContext context, SearchController controller) {
    return suggestions(controller).map((ChapterHolder chapter) =>
        _SearchedChapter(chapter: chapter.info, searchTerm: controller.text));
  }

  Iterable<Widget> items(BuildContext context) sync* {
    Book book = Book.of(context);
    for (ChapterHolder chapter in book.chapters) {
      yield _SearchedChapter(
          chapter: chapter.info, searchTerm: controller.text);
    }
  }

  Widget barBuilder(BuildContext context, SearchController controller) {
    return SearchBar(
      controller: controller,
      onTap: controller.openView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SearchAnchor(
        // isFullScreen: true,
        // barHintText: 'Chapter titles',
        builder: barBuilder,
        suggestionsBuilder: suggestionBuilder,
        // viewLeading: Text("Search widget"),
        viewTrailing: items(context),

        // builder: (context, controller) => SearchedIndexWidget(
        //       key: const Key('SearchWidget'),
        //       searchTerm: controller.text,
        //     ),
      ),
      Expanded(
          child: SearchedIndexWidget(
        key: const Key('SearchWidget'),
        searchTerm: controller.text,
      )),
    ]);
    /*
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SearchBar(
        key: const Key("IndexSearchBar"),
        controller: controller,
        leading: const Icon(Icons.search),
        onChanged: onTextChange,
      ),
      Expanded(
          child: SearchedIndexWidget(
        key: const Key('SearchWidget'),
        searchTerm: currentSearchTerm,
      )),
    ]);

     */
  }
}

class SearchedIndexWidget extends StatelessWidget {
  final String? searchTerm;
  const SearchedIndexWidget({super.key, this.searchTerm});

  void goto(BuildContext context, int ix) {
    context.go('/scroll/$ix');
  }

  Widget? itemBuilder(context, ix) {
    Book book = Book.of(context);
    if (ix >= book.chapterAmt) {
      return null;
    }
    return ListTile(
        // key: Key('SearchIndexChp$ix'),
        title: SearchedText(
          text: book.getChapterName(ix),
          searchTerm: searchTerm,
        ),
        onTap: () => goto(context, ix)
        // context.goNamed('/scroll',
        //     pathParameters: {'chid': ix.toString()});
        );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        prototypeItem: itemBuilder(context, 0),
        itemBuilder: itemBuilder);
  }
}

class _SearchedChapter extends StatelessWidget {
  final ChapterInfo chapter;
  final String? searchTerm;
  const _SearchedChapter(
      {super.key, required this.chapter, required this.searchTerm});

  void goto(BuildContext context) {
    context.go('/scroll/${chapter.id}');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        // key: Key('SearchIndexChp$ix'),
        title: Text(chapter.displayName),
        // title: SearchedText(
        //   text: chapter.displayName,
        //   searchTerm: searchTerm,
        // ),
        leading: SizedBox.shrink(),
        trailing: Icon(Icons.book_online, size: 25),
        onTap: () => goto(context)
        // context.goNamed('/scroll',
        //     pathParameters: {'chid': ix.toString()});
        );
  }
}

class SearchedText extends StatelessWidget {
  final String? searchTerm;
  final String text;
  static const Color highlightColor = boring4;

  late final String? before, match, after;

  SearchedText({super.key, this.searchTerm, required this.text}) {
    var tup = splitMatch();
    before = tup.$1;
    match = tup.$2;
    after = tup.$3;
  }

  Widget highlightedSpan(context, String text) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(backgroundColor: highlightColor));
  }

  Widget partialHighlightSpan(
      context, String textBefore, String textHilite, String textAfter) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: textBefore, style: Theme.of(context).textTheme.bodyLarge),
        TextSpan(
            text: textHilite,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(backgroundColor: highlightColor)),
        TextSpan(text: textAfter, style: Theme.of(context).textTheme.bodyLarge),
      ]),
    );
  }

  (String?, String?, String?) splitMatch() {
    String? searchTerm = this.searchTerm?.toLowerCase();
    String searchText = text.toLowerCase();
    if (searchTerm == null || searchTerm.isEmpty) {
      return (text, null, null);
    }
    if (searchTerm == searchText || searchTerm.contains(searchText)) {
      return (null, text, null);
    }
    if (searchText.contains(searchTerm)) {
      int ix0 = searchText.indexOf(searchTerm);
      if (ix0 == 0 || searchText[ix0 - 1] == ' ') {
        String before = text.substring(0, ix0);
        String match = text.substring(ix0, ix0 + searchTerm.length);
        String after = text.substring(ix0 + searchTerm.length);
        return (before, match, after);
      }
    }
    if (searchText[0] == searchTerm[0]) {
      int ixMatch = 0;
      while (ixMatch < searchText.length &&
          ixMatch < searchTerm.length &&
          searchText[ixMatch] == searchTerm[ixMatch]) {
        ixMatch++;
      }
      String match = text.substring(0, ixMatch);
      String after = text.substring(ixMatch);
      return (null, match, after);
    }
    return (text, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: element(context));
  }

  Widget element(BuildContext context) {
    String? searchTerm = this.searchTerm?.toLowerCase();
    if (searchTerm == null || searchTerm.isEmpty) {
      return Text(text);
    }

    String searchText = text.toLowerCase();
    if (searchTerm == searchText || searchTerm.contains(searchText)) {
      return highlightedSpan(context, text);
    }
    if (searchText.contains(searchTerm)) {
      int ix0 = searchText.indexOf(searchTerm);
      if (ix0 == 0 || searchText[ix0 - 1] == ' ') {
        String before = text.substring(0, ix0);
        String matched = text.substring(ix0, ix0 + searchTerm.length);
        String after = text.substring(ix0 + searchTerm.length);
        return partialHighlightSpan(context, before, matched, after);
      }
    }
    if (searchText[0] == searchTerm[0]) {
      int ixMatch = 0;
      while (ixMatch < searchText.length &&
          ixMatch < searchTerm.length &&
          searchText[ixMatch] == searchTerm[ixMatch]) {
        ixMatch++;
      }
      return partialHighlightSpan(
          context, '', text.substring(0, ixMatch), text.substring(ixMatch));
    }
    return Text(text);
  }
}
