import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../backend/book.dart';
import '../../backend/chapter.dart';
import '../../backend/chapter_info.dart';
import '../book_waiter.dart';
import '../elements/scaffold.dart';
import '../theme/extra_styles.dart';

/*
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
          ChapterHolder chapter = book.chapters[ix];
          return ListTile(
              leading: Checkbox(value: chapter.isPart, onChanged: null),
              title: Text(chapter.displayName),
              onTap: () {
                context.go('/scroll/$ix');
              });
        });
  }
}
*/
class IndexPage extends StatelessWidget {
  const IndexPage({required super.key});

  @override
  Widget build(BuildContext context) {
    return const PartedSearchIndexWidget(searchTerm: null);
  }
}

class SearchIndexPage extends StatelessWidget {
  final String? searchTerm;
  const SearchIndexPage({required super.key, this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'search',
        child: StdBookWaiter(
            child: PartedSearchIndexWidget(searchTerm: searchTerm)));
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

  Iterable<Chapter> suggestions(SearchController controller) sync* {
    Book? book = Book.maybeOf(context);
    if (book == null) {
      return;
    }
    for (Chapter chapter in book.chapters) {
      if (chapter.displayName.contains(controller.text)) {
        yield chapter;
      }
    }
  }

  Iterable<Widget> suggestionBuilder(
      BuildContext context, SearchController controller) {
    return suggestions(controller).map((Chapter chapter) => _SearchedChapter(
        key: Key('searched_${chapter.id}'),
        chapter: chapter.info,
        searchTerm: controller.text));
  }

  Iterable<Widget> items(BuildContext context) sync* {
    Book book = Book.of(context);
    for (Chapter chapter in book.chapters) {
      yield _SearchedChapter(
          key: Key('searched_${chapter.id}'),
          chapter: chapter.info,
          searchTerm: controller.text);
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

class PartedSearchIndexWidget extends StatefulWidget {
  /*
      The index, but with a searched term that was not found

      Also uses parts

      [SearchIcon]  _desert_____

      1. Rachel
      2. Sarah
      3. Nevada [Desert]
   */
  final String? searchTerm;

  const PartedSearchIndexWidget({super.key, required this.searchTerm});

  @override
  State<PartedSearchIndexWidget> createState() =>
      _PartedSearchIndexWidgetState();
}

class _PartedSearchIndexWidgetState extends State<PartedSearchIndexWidget> {
  // late final TextEditingController controller;
  // String? currentSearchTerm;
  late final SearchController controller;
  late final List<PartListTile> listTiles;

  @override
  void initState() {
    super.initState();
    controller = SearchController();
    controller.text = widget.searchTerm ?? '';
    // listTiles = splitParts(Book.of(context));
  }

  @override
  void didChangeDependencies() {
    listTiles = splitParts(Book.of(context));
    super.didChangeDependencies();
  }

  Iterable<Chapter> suggestions(SearchController controller) sync* {
    Book? book = Book.maybeOf(context);
    if (book == null) {
      return;
    }
    for (PartListTile part in listTiles) {
      if (part.chapter.matchesSearchTerm(controller.text)) {
        yield part.chapter;
      } else {
        // for (ChapterHolder chapter in book.chapters) {
        //   if (chapter.displayName.contains(controller.text)) {
        //     yield chapter;
        //   }
        // }
      }
    }
  }

  Iterable<Widget> suggestionBuilder(
      BuildContext context, SearchController controller) {
    return suggestions(controller).map((Chapter chapter) => _SearchedChapter(
        key: Key('searched_${chapter.id}'),
        chapter: chapter.info,
        searchTerm: controller.text));
  }

  Iterable<Widget> blankSuggestions(
      BuildContext context, SearchController controller) {
    return [];
  }

  Widget barBuilder(BuildContext context, SearchController controller) {
    return SearchAnchor.bar(
      suggestionsBuilder: blankSuggestions,
      // controller: controller,
      onTap: controller.openView,
      isFullScreen: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            key: const Key('index_main_col'),
            children: [
          SearchAnchor.bar(
            isFullScreen: true,
            barHintText: 'Search chapters',

            // barHintText: 'Chapter titles',

            // builder: barBuilder,
            suggestionsBuilder: blankSuggestions,
            // viewLeading: Text("Search widget"),
            // viewTrailing: listTiles,
          ),
          Expanded(
              key: const Key('index_expanded'),
              child: ListView(
                key: const Key('SearchWidget'),
                children: listTiles,
              )),
        ]));
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
    Chapter chapter = book.chapters[ix];
    return ListTile(
        // key: Key('SearchIndexChp$ix'),
        leading: Checkbox(value: chapter.isPart, onChanged: null),
        title: SearchedText(
          text: chapter.displayName,
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
        leading: const SizedBox.shrink(),
        trailing: const Icon(Icons.book_online, size: 25),
        onTap: () => goto(context)
        // context.goNamed('/scroll',
        //     pathParameters: {'chid': ix.toString()});
        );
  }
}

List<PartListTile> splitParts(Book book) {
  Chapter? lastPart;
  int lastIx = 0;
  List<PartListTile> parts = [];

  for (int n = 0; n < book.chapterAmt; ++n) {
    if (book.chapters[n].isPart) {
      if (lastPart != null) {
        parts.add(PartListTile(
            key: Key('Part_${lastPart.id}'),
            chapter: lastPart,
            subChapters: book.chapters.sublist(lastIx + 1, n)));
      }
      lastPart = book.chapters[n];
      lastIx = n;
    }
  }
  if (lastPart != null) {
    parts.add(PartListTile(
        key: Key('Part_${lastPart.id}'),
        chapter: lastPart,
        subChapters: book.chapters.sublist(lastIx + 1)));
  }
  //Remove hidden parts
  parts = parts.where((e) => !e.chapter.info.hidePart).toList(growable: false);

  return parts;
}

class PartListTile extends StatefulWidget {
  final Chapter chapter;
  final List<Chapter> subChapters;
  const PartListTile(
      {super.key, required this.chapter, required this.subChapters});

  @override
  State<PartListTile> createState() => _PartListTileState();
}

class _PartListTileState extends State<PartListTile> {
  Chapter get chapter => widget.chapter;

  Widget subTile(Chapter sub) {
    return ListTile(
        key: Key('subChapterTile_${sub.id}'),
        leading: const SizedBox(
          width: 25,
        ),
        onTap: () => context.go('/scroll/${sub.id}'),
        title: Text(
          sub.displayName,
        ));
  }

  void gotoPart() {
    scrollToChapter(chapter, context: context);
  }

  Widget goButton(BuildContext context) {
    return FilledButton(
      onPressed: gotoPart,
      child: const Text('Read'),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(chapter.isPart);

    return ExpansionTile(
      key: const Key('partExpansionTile'),
      title: Text(widget.chapter.displayName),
      // leading: SizedBox.shrink(),
      internalAddSemanticForOnTap: true,

// controller: ExpansibleController(),
      controlAffinity: ListTileControlAffinity.leading,
      // trailing: const Icon(
      //     key: Key('partLeadingIcon'), RpgAwesome.bottom_right, size: 25),
      trailing: goButton(context),
      children: widget.subChapters.map(subTile).toList(growable: false),
      // onTap: () => goto(context)
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
