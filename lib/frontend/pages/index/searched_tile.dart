import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../../backend/chapter_data.dart';
import '../../../backend/chapter_info.dart';
import '../../theme/extra_styles.dart';

class SearchedChapterTile extends StatelessWidget {
  /// Highlights searched term
  final ChapterInfo chapter;
  final String? searchTerm;
  const SearchedChapterTile(
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

  void gotoPart() async {
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
      internalAddSemanticForOnTap: true,
      controlAffinity: ListTileControlAffinity.leading,
      trailing: goButton(context),
      children: widget.subChapters
          .map((c) => _SubTile(key: Key('chp${c.index}'), chapter: c))
          .toList(growable: false),
    );
  }
}

class _SubTile extends StatefulWidget {
  final Chapter chapter;

  const _SubTile({required super.key, required this.chapter});
  @override
  State<StatefulWidget> createState() => _SubTileState();
}

class _SubTileState extends State<_SubTile> {
  Chapter get chapter => widget.chapter;
  ChapterExtra? extra;
  @override
  void initState() {
    extra = chapter.extra;
    super.initState();
    if (extra == null) {
      chapter.peekExtra().then(extraGot);
    }
  }

  void extraGot(ChapterExtra extra) {
    setState(() {
      this.extra = extra;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? subt = extra?.subtitle;

    String? where = extra?.where;
    String? when = extra?.when;

    TextStyle? whenStyle = Theme.of(context).textTheme.labelMedium;

    Widget? subtitle;

    if (extra == null) {
      subtitle = Text('...', style: whenStyle);
    } else if (subt != null) {
      //TODO: Subtitle := Row
      subtitle = Text(
        subt,
        style: whenStyle,
      );
    }

    Widget? trailing;
    if (where != null) {
      trailing = Text(
        where,
        style: whenStyle,
      );
    } else if (when != null) {
      trailing = Text(
        when,
        style: whenStyle,
      );
    }
    return ListTile(
      key: const Key('subChapterTile'),
      //Match the dropdown button on the main tile
      leading: SizedBox(
        width: 25,
        child: Text(chapter.index.toString()),
      ),

      title: Text(
        chapter.displayName,
      ),
      subtitle: subtitle,
      trailing: trailing,
      // Quick Comparison
      // trailing: when != null ? Text(when, style: whenStyle) : null,
      onTap: () => context.go('/scroll/${chapter.id}'),
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
