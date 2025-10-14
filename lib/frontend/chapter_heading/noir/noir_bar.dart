import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/noir/subtitle.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/noir/title.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

import '../../../../backend/chapter.dart';
import '../../components/app_bar_chop/app_bar_chop.dart';
import '../../parts/noir_colors.dart';
import '../../parts/part.dart';

class NoirBar extends StatelessWidget {
  const NoirBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 60;
    const double expandedHeight = 120;
// SliverAppBar;
    return const SliverAppBarChop(
      key: Key("NoirAppBar"),
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: NoirPrimary.shade5, // Navigation bar
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,

        statusBarColor: NoirPrimary.shade5, // Status bar
      ),
      actions: [DrawerButton()],
      // shape:
      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      flexibleSpace: NoirAppBar(key: Key("AppBar")),
      // flexibleSpace: AppBarTitleOnly(
      //   key: Key("BarTitle"),
      // ),
      // bottom: ChapterHeadingSubtitle(key: Key("Subtitle")),
      // leadingWidth: 50,
      // leading: SizedBox.shrink(),
      actionsPadding: EdgeInsets.symmetric(horizontal: 12),
      // forceMaterialTransparency: true,
      collapsedHeight: collapsedHeight,
      // collapsedHeight: expandedHeight,
      expandedHeight: expandedHeight,
      backgroundColor: NoirPrimary.shade4,

      //Baked into theme
      // surfaceTintColor: NoirPrimary.shadec,

      scrolledUnderElevation: 0,
      // forceElevated: true,
      elevation: 0,

//Baked in
//       floating: true,
//       snap: false,
//       pinned: true,
//       stretch: false,
    );
  }
}

class DrawerButton extends StatefulWidget {
  const DrawerButton({super.key});

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: openDrawer,
        icon: const Icon(
          Icons.menu,
          color: headerColor,
        ));
  }

  void openDrawer() {
    Scaffold.maybeOf(context)?.openEndDrawer();
  }
}

class NoirAppBar extends StatelessWidget {
  const NoirAppBar({required super.key});

  @override
  Widget build(BuildContext context) {
    return const ClipRRect(
        key: Key("clip"),
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
            key: Key('overflow'),
            alignment: Alignment.topCenter,
            maxHeight: 120 + 12,
            child: _AppBarCol(key: Key("appBar"))));
  }
}

class _AppBarCol extends StatefulWidget {
  const _AppBarCol({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _AppBarColState();
}

class _AppBarColState extends State<_AppBarCol> {
  late Chapter? chapter;
  late Part part;

  @override
  void didChangeDependencies() {
    //Add listener
    chapter = Chapter.maybeOf(context);
    part = ChapterProvider.of(context).part;
    chapter?.loadNotifier.addListener(chapterUpdated);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //Remove listener
    chapter?.loadNotifier.removeListener(chapterUpdated);
    super.dispose();
  }

  void chapterUpdated() {
    if (mounted) {
      //Header, accessed from chapter, won't update on change
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key("col"),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        // DecoratedBox(
        // decoration: const BoxDecoration(
        //     border: Border(
        //         bottom: BorderSide(color: NoirPrimary.shade3, width: 1))),
        SizedBox(
            key: const Key("row1Size"),
            height: 60,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                //Row

                child: HeadingTitleRow(
                    key: Key("Title${chapter?.key}"),
                    header: chapter?.data?.header,
                    chapter: chapter))),
        // const Divider(
        //   indent: 12,
        //   endIndent: 12,
        //   height: 12,
        //   radius: BorderRadius.all(Radius.circular(3)),
        // ),
        //Replaces divider with color change
        // const SizedBox(height: 6),
        ChapterHeadingSubtitle(key: Key("Subtitle${chapter?.key}")),
      ],

      //Bookmark Button
    );
  }
}
