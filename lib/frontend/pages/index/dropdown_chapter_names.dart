import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/noir/title.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';
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
    //Overlays are getting removed elsewhere
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
          itemExtent: 60,
          findChildIndexCallback: findChildIndexCallback,
          key: const Key('chpNameDropdownListView'),
          itemBuilder: builder,
          prototypeItem: const _ChapterTilePrototype(
            key: Key('chpTileProto'),
          ),
        ));
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
      //This will automatically match the tile to the chapter that it's from
      Part part = getPartOrFallback(chapter.part);
      //TODO: Extract to widget
      return Material(
        key: Key('chpTile$index'),
        type: MaterialType.canvas,
        color: part.primary.s4,
        child: _ChapterTitleListItem(
            key: Key('chp$index'),
            chapter: book.chapters[index],
            onClicked: onChapterSelected,
            part: part),
      );
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
  final Part part;

  const _ChapterTitleListItem(
      {required super.key,
      required this.chapter,
      required this.onClicked,
      required this.part});

  void onPressed() {
    onClicked(chapter);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Put border on these
    return MaterialButton(
        onPressed: onPressed,
        child: SizedBox(
            height: 60,
            child: RawTitleRow(
              chapter: chapter,
              small: true,
              part: part,
            )));
  }
}

//For the list view
class _ChapterTilePrototype extends StatelessWidget {
  const _ChapterTilePrototype({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 60,
        child: RawTitleRow(
          chapter: null,
          small: true,
          part: PartNoir(),
        ));
  }
}
