import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../../backend/chapter_data.dart';
import '../../../backend/chapter_info.dart';
import '../../theme/extra_styles.dart';

class SearchedChapterTile extends StatelessWidget {
  /// Highlights searched term
  /// TODO: Use regular Chapter
  final ChapterInfo chapter;
  final String? searchTerm;
  const SearchedChapterTile(
      {super.key, required this.chapter, required this.searchTerm});

  void goto(BuildContext context) {
    Chapter fullChapter = Book.of(context).chapters[chapter.id];
    scrollToChapter(fullChapter, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        // key: Key('SearchIndexChp$ix'),
        title: Text(
          chapter.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
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

class PartListTile extends StatefulWidget {
  final int partIndex;
  // final List<Chapter> subChapters;
  const PartListTile({super.key, required this.partIndex});

  @override
  State<PartListTile> createState() => _PartListTileState();
}

class _PartListTileState extends State<PartListTile> {
  late Book book;
  @override
  void didChangeDependencies() {
    book = Book.of(context);
    super.didChangeDependencies();
  }

  Chapter get chapter => book.getPartStart(widget.partIndex);
  List<Chapter> get subChapters => book.getPartRange(widget.partIndex);

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
      title: Text(
        chapter.displayName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      internalAddSemanticForOnTap: true,
      controlAffinity: ListTileControlAffinity.leading,
      trailing: goButton(context),
      children: subChapters
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
      trailing = SizedBox(
          width: 12 * 5,
          child: Text(
            where,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: whenStyle,
          ));
    } else if (when != null) {
      trailing = SizedBox(
          width: 12 * 5,
          child: Text(
            when,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: whenStyle,
          ));
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
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle,
      trailing: trailing,

      // Quick Comparison
      // trailing: when != null ? Text(when, style: whenStyle) : null,
      onTap: () => scrollToChapter(chapter, context: context),
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
