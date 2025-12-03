import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:soyourhomeworld/backend/bookmark_saver.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/chapter_progress_indicator.dart';
import 'package:soyourhomeworld/frontend/pages/sidebar/side_index.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';
import 'package:soyourhomeworld/frontend/theme/layout_constants.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../chapter_heading/header_elements.dart';
import '../../parts/part.dart';
import 'logo.dart';

class Sidebar extends StatefulWidget {
  final ValueNotifier<Chapter?> currentChapter;
  const Sidebar({required super.key, required this.currentChapter});

  @override
  State<Sidebar> createState() => _SidebarState();
}

//Pro-gamer move to preserve state
bool expanded = false;

class _SidebarState extends State<Sidebar> {
  late Book book;

  Chapter? get currentChapter => widget.currentChapter.value;

  Part part = const PartNoir();

  @override
  void initState() {
    super.initState();
    widget.currentChapter.addListener(onChapterChanged);
  }

  @override
  void didChangeDependencies() {
    book = Book.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.currentChapter.removeListener(onChapterChanged);
    super.dispose();
  }

  void openDrawer() {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return ChapterProvider(
        key: const Key('dumbChpProvider'),
        chapter: currentChapter ?? book.chapters[0],
        part: part,
        child: AnimatedContainer(
            key: Key('ctr_${part.id}'),
            duration: const Duration(milliseconds: 350),
            width: expanded ? indexSidebarWidth : collapsedIndexWidth,
            decoration: BoxDecoration(
                color: part.primary.s2,
                border: Border.symmetric(
                    vertical: BorderSide(
                        color: part.primary.s3,
                        strokeAlign: BorderSide.strokeAlignInside))
                // gradient: LinearGradient(
                //   colors: [
                //     part.primary.s1,
                //     part.primary.s0,
                //   ],
                //   stops: const [0, 1],
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.topCenter,
                // ),
                //TODO: I want this under the logo as well
                // border: Border(right: BorderSide(color: part.primary.s7))
                ),
            // alignment: Alignment.topLeft,
            child: expanded
                ? SidebarIndex(
                    key: const Key('sideIndex'),
                    currentChapter: widget.currentChapter,
                    part: part,
                    onCollapsed: onCollapsed,
                  )
                : CollapsedSidebar(
                    key: const Key('sidebar'),
                    part: part,
                    onOpenIndex: onExpanded,
                    currentChapter: widget.currentChapter)));
  }

// === Callbacks ==========
  void onCollapsed() {
    //TODO: Don't offer hide when screen is wide enough
    setState(() {
      expanded = false;
    });
  }

  void onExpanded() {
    setState(() {
      expanded = true;
    });
  }

  void onChapterChanged() {
    if (currentChapter != null) {
      if (currentChapter?.part != part.id) {
        setState(() {
          part = getPartImmediate(currentChapter?.part ?? part.id);
        });
      }
    }
  }
}

class CollapsedSidebar extends StatelessWidget {
  const CollapsedSidebar(
      {super.key,
      required this.part,
      required this.onOpenIndex,
      required this.currentChapter});
  final Part part;
  final VoidCallback onOpenIndex;
  final ValueNotifier<Chapter?> currentChapter;

  @override
  Widget build(BuildContext context) {
    Part part = ChapterProvider.of(context).part;

    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Title (one letter )
          CollapsedSiteLogo(
            part: part,
            key: const Key('smlLogo'),
          ),
          //This is to make it match the app bar
          Container(
              height: expandedAppBarSize - appBarSize,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: part.primary.s3,
                  border: Border.all(
                      color: part.primary.s3,
                      strokeAlign: BorderSide.strokeAlignInside)),
              // child: StdAppBarButton(
              //   icon: Icons.arrow_forward_ios,
              //   onPressed: onExpanded,
              // )
              child: Center(
                child: StdAppBarButton(
                  key: const Key('showToggle'),
                  icon: Symbols.menu_book,
                  tooltip: 'Show',
                  onPressed: onOpenIndex,
                  hilite: true,
                ),
              )),
          // const Divider(),
          // const SizedBox(height: 12),
          // const Divider(),
          const SizedBox(height: 6),

          BookmarkSaveStatusIcon(
            key: const Key('bkmkStatus'),
            part: part,
          ),
          const SizedBox(height: 12),

          const Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: BookmarkNumberDisplay(
                key: Key('bkmkNum'),
              )),
          const SizedBox(height: 12),

          const Expanded(child: SizedBox.shrink()),

          Padding(
              padding: const EdgeInsets.all(12),
              child: _DetectingRPI(
                key: const Key('chpNum'),
                currentChapter: currentChapter,
                part: part,
              ))
        ]);
  }
}

class _DetectingRPI extends StatelessWidget {
  const _DetectingRPI(
      {super.key, required this.currentChapter, required this.part});
  final ValueNotifier<Chapter?> currentChapter;
  final Part part;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: currentChapter, builder: builder);
  }

  Widget builder(BuildContext context, Widget? previous) {
    int chapterAmt = Book.of(context).chapterAmt;
    return ReadingProgressIndicator(
      key: const Key('progress'),
      chapter: currentChapter.value?.index,
      totalChapters: chapterAmt,
      color: part.primary.sc,
    );
  }
}
