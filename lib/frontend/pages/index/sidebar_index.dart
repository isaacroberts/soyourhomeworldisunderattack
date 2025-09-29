import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/noir_colors.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/layout_constants.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../parts/part.dart';

class SidebarIndex extends StatefulWidget {
  // final ValueNotifier<Chapter?> mainChapter;
  const SidebarIndex({super.key});

  @override
  State<SidebarIndex> createState() => _SidebarIndexState();
}

class _SidebarIndexState extends State<SidebarIndex> {
  late ScrollController controller;
  late Book book;
  @override
  void didChangeDependencies() {
    book = Book.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     NoirPrimary.shade0,
            //     NoirPrimary.shade3,
            //     NoirPrimary.shade4,
            //   ],
            //   stops: [0, .5, 1],
            //   begin: Alignment.bottomCenter,
            //   end: Alignment.topCenter,
            // ),
            color: Color(0xffefefef),
            backgroundBlendMode: BlendMode.colorBurn,
            border: Border(right: BorderSide(color: NoirPrimary.shade2))),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: NoirPrimary.shade4,
                    border: Border(
                        bottom:
                            BorderSide(color: NoirPrimary.shade2, width: 1))),
                height: appBarSize,
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Homeworld',
                      style: headerFont,
                    ))),
            Expanded(
                child: ListView.builder(
              itemBuilder: itemBuilder,
              prototypeItem: chapterTile(context, book.chapters[1]),
              itemCount: book.chapterAmt,
              shrinkWrap: false,

              // children: book.chapters.map(chapterTile).toList(growable: false),
            ))
          ],
        ));
  }

  Widget? itemBuilder(BuildContext context, int index) {
    if (index >= 0 && index < book.chapterAmt) {
      return chapterTile(context, book.chapters[index]);
    }
    return null;
  }

  Widget chapterTile(BuildContext context, Chapter chapter) {
    Part part = getPartImmediate(chapter.part);
    if (chapter.isPart) {
      return ListTile(
        title: Text(
          chapter.displayName,
          style: headerFont.copyWith(color: part.primary.se, fontSize: 16),
        ),
        tileColor: part.primary.s1,
        trailing: const Icon(Icons.expand_less),
      );
    } else {
      return ListTile(
        // tileColor: NoirPrimary.shade5,
        onTap: () => scrollToChapter(chapter, context: context),
        title: Text(
          chapter.displayName,
          style: headerFont.copyWith(color: part.primary.sd, fontSize: 16),
        ),
      );
    }
  }
}
