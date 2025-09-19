import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/pages/index/searched_tile.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';

class OldIndexWidget extends StatefulWidget {
  /*
      The index, but with a searched term that was not found

      [SearchIcon]  _desert_____

      1. Rachel
      2. Sarah
      3. Nevada [Desert]
   */
  final String? searchTerm;
  const OldIndexWidget({super.key, required this.searchTerm});

  @override
  State<OldIndexWidget> createState() => _OldIndexWidgetState();
}

class _OldIndexWidgetState extends State<OldIndexWidget> {
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
    return suggestions(controller).map((Chapter chapter) => SearchedChapterTile(
        key: Key('searched_${chapter.id}'),
        chapter: chapter.info,
        searchTerm: controller.text));
  }

  Iterable<Widget> items(BuildContext context) sync* {
    Book book = Book.of(context);
    for (Chapter chapter in book.chapters) {
      yield SearchedChapterTile(
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
          child: _OldIndexList(
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

class _OldIndexList extends StatelessWidget {
  final String? searchTerm;
  const _OldIndexList({required super.key, this.searchTerm});

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
