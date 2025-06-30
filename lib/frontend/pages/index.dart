import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../backend/book.dart';
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
  late final TextEditingController controller;
  String? currentSearchTerm;
  @override
  void initState() {
    super.initState();
    currentSearchTerm = widget.searchTerm;
    controller = TextEditingController(text: widget.searchTerm);
  }

  void onTextChange(String? text) {
    setState(() {
      currentSearchTerm = controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
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

class SearchedText extends StatelessWidget {
  final String? searchTerm;
  final String text;
  static const Color highlightColor = boring4;

  const SearchedText({super.key, required this.searchTerm, required this.text});

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

  @override
  Widget build(BuildContext context) {
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
