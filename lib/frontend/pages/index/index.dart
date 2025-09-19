import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/components/deferrals/index.dart'
    as defer;

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../book_waiter.dart';
import '../../elements/scaffold.dart';

class IndexPage extends StatelessWidget {
  ///For navigating to the index with a particular term
  final String? searchTerm;
  const IndexPage({required super.key, this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'search',
        child: BookWaiter(
            child: IndexWidget(
                key: const Key('searchIndex'), searchTerm: searchTerm)));
  }
}

class IndexWidget extends StatefulWidget {
  /// The index, but split into parts
  ///
  /// 1. Rachel
  /// 2. Sarah
  /// 3. Nevada [Desert]
  ///
  ///
  final String? searchTerm;

  const IndexWidget({required super.key, required this.searchTerm});

  @override
  State<IndexWidget> createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<IndexWidget> {
  // late final TextEditingController controller;
  // String? currentSearchTerm;
  late final SearchController controller;
  List<Widget> listTiles = [];

  @override
  void initState() {
    super.initState();
    controller = SearchController();
    controller.text = widget.searchTerm ?? '';
    // listTiles = splitParts(Book.of(context));
  }

  @override
  void didChangeDependencies() {
    //TODO: Move this into book
    // listTiles = splitParts(Book.of(context));
    super.didChangeDependencies();
    defer.splitParts(Book.of(context)).then(partsGot);
  }

  void partsGot(List<Widget> parts) {
    setState(() {
      listTiles = parts;
    });
  }

  Widget barBuilder(BuildContext context, SearchController controller) {
    return LiveSearchList(
        key: const Key("liveSearchTerms"), onTap: controller.openView);
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
          listTiles.isEmpty
              ? const BlankSearchList(key: Key("BlankSearchTerms"))
              : LiveSearchList(
                  key: const Key("liveSearchTerms"),
                  onTap: controller.openView),
          // SearchAnchor.bar(
          //   isFullScreen: true,
          //   barHintText: 'Search chapters',
          //
          //   // barHintText: 'Chapter titles',
          //
          //   // builder: barBuilder,
          //   suggestionsBuilder: blankSuggestions,
          //   // viewLeading: Text("Search widget"),
          //   // viewTrailing: listTiles,
          // ),
          Expanded(
              key: const Key('index_expanded'),
              child: ListView(
                key: const Key('SearchWidget'),
                children: listTiles,
              )),
        ]));
  }
}

class LiveSearchList extends StatelessWidget {
  ///The list of chapters that drop down under the search bar as you type
  final VoidCallback onTap;
  const LiveSearchList({required super.key, required this.onTap});

  Iterable<Widget> mapMatches(List<Chapter> chapters,
      {required String searchTerm}) {
    return chapters
        .map((Chapter chapter) => defer.searchedTile(chapter, searchTerm));
  }

  Future<Iterable<Widget>> suggestionBuilder(
      BuildContext context, SearchController controller) async {
    Stream<Chapter> matches =
        Book.of(context).streamChapterBySearchTerm(controller.text);
    var l = await matches.toList();
    return mapMatches(l, searchTerm: controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      suggestionsBuilder: suggestionBuilder,
      // controller: controller,
      onTap: onTap,
      isFullScreen: true,
    );
  }
}

class BlankSearchList extends StatelessWidget {
  ///The list of chapters that drop down under the search bar as you type
  const BlankSearchList({required super.key});

  Iterable<Widget> blankSuggestions(
      BuildContext context, SearchController controller) {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      suggestionsBuilder: blankSuggestions,
      // controller: controller,
      onTap: null,
      isFullScreen: true,
    );
  }
}
