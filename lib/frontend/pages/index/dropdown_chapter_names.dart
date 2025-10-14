import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/noir/title.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../parts/part.dart';

///Dropdown when the chapter name is clicked on
///
class ChapterTitleDropdown extends StatefulWidget {
  final Chapter? startChapter;
  const ChapterTitleDropdown({super.key, required this.startChapter});

  @override
  State<StatefulWidget> createState() => _ChapterTitleDropdownState();
}

class _ChapterTitleDropdownState extends State<ChapterTitleDropdown> {
  late Book book;
  late final ScrollController scrollController;
  @override
  void initState() {
    int startChapterIx = widget.startChapter?.index ?? 0;
    scrollController = ScrollController(
        initialScrollOffset: 60.0 * startChapterIx,
        keepScrollOffset: false,
        debugLabel: 'ChapterDropdownScroll');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    book = Book.of(context);
    super.didChangeDependencies();
  }

  void onChapterSelected(Chapter? c) {
    //TODO: I think this should callback the parent to make sure overlays are getting removed
    scrollToChapter(c, context: context);
  }

  @override
  Widget build(BuildContext context) {
    // Part part = Part.of(context);
    // Part part = const PartNoir();
    //Put scrollbar back
    return ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListView.builder(

            //This allows the startItem to be shown first
            controller: scrollController,
            //TODO: Prototype item
            // prototypeItem: const SizedBox(
            //   height: 60,
            // ),
            itemExtent: 60,
            findChildIndexCallback: findChildIndexCallback,
            key: const Key('chpNameDropdownListView'),
            itemBuilder: builder));
  }

  int? findChildIndexCallback(Key key) {
    String s = toString();
    if (s.length > 8) {
      s = s.substring(7);
      //Chapter number is after in key
      return int.tryParse(s);
    }
    return null;
  }

  Widget? builder(BuildContext context, int index) {
    if (book.inBounds(index)) {
      Chapter chapter = book.chapters[index];
      //TODO: Change this to nullable chec
      //I'm so fucking sorry LMAO
      //On the upside, this will automatically match the tile to the chapter that it's from
      Part part = getPartOrFallback(chapter.part);
      //TODO: Extract to widget
      return Material(
          key: Key('chpTile$index'),
          type: MaterialType.canvas,
          color: part.primary.s4,
          child: ChapterProvider(
              key: const Key('chpDropdown'),
              chapter: chapter,
              part: part,
              child: _ChapterTitleListItem(
                  key: Key('chp$index'),
                  chapter: book.chapters[index],
                  onClicked: onChapterSelected)));
    } else {
      return null;
    }
  }
}

///Boxes for the dropdown
class _ChapterTitleListItem extends StatelessWidget {
  ///Use a callback instead of context.go so barrier can be dismissed properly
  final void Function(Chapter) onClicked;
  final Chapter chapter;

  const _ChapterTitleListItem(
      {required super.key, required this.chapter, required this.onClicked});

  void onPressed() {
    onClicked(chapter);
  }

  @override
  Widget build(BuildContext context) {
    Part part = Part.of(context);
    //TODO: Put border on these
    return MaterialButton(
        onPressed: onPressed,
        child: SizedBox(
            height: 60,
            child: RawTitleRow(
              chapter: chapter,
              small: true,
            )));
    return ListTile(
      leading: chapter.isPart
          ? Icon(
              Symbols.brick,
              color: part.primary.se,
            )
          : null,
      onTap: onPressed,
      title: Text(
        key: const Key('t'),
        chapter.displayName,
        style: headerFont.copyWith(fontSize: 16),
        textAlign: TextAlign.left,
      ),
      trailing: ChapterNumber(index: chapter.index),
    );
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Material(
            color: part.primary.s4,
            child: InkWell(
                key: Key('dropdownItem${chapter.index}'),
                onTap: onPressed,
                // color: part.primary.s4,
                // padding: EdgeInsets.zero,

                child: DecoratedBox(
                  decoration: BoxDecoration(border: Border.all()),
                  //TODO: Move these up
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Text(
                            key: const Key('t'),
                            chapter.displayName,
                            style: headerFont.copyWith(fontSize: 12),
                            textAlign: TextAlign.left,
                          ))),
                ))));
  }
}
