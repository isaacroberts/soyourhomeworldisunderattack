import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/bar.dart';

import '../../../backend/chapter.dart';
import '../../../backend/chapter_holder.dart';
import '../../elements/holders/holder_base.dart';
import 'reader_builder.dart';

class SliverReader extends StatefulWidget {
  final ChapterHolder? chapterHolder;

  const SliverReader({super.key, required this.chapterHolder});

  Chapter? get chapter => chapterHolder?.chapter;

  @override
  State<StatefulWidget> createState() => _SliverReaderState();
}

class _SliverReaderState extends State<SliverReader> {
  Chapter? get chapter => widget.chapter;

  @override
  void initState() {
    super.initState();
  }

  Widget itemBuilder(BuildContext context, Holder holder, bool showFonts) {
    return SliverToBoxAdapter(
        child: holder.elementOrFallback(context, showFonts));
  }

  Widget header(BuildContext context) {
    return SliverHeader(chapter: widget.chapterHolder, header: chapter?.header);
  }

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      //Returns zero box, so rest of reader can use ! null checks
      return const SliverToBoxAdapter(
          child: SizedBox(
        height: 400,
      ));
    }

    return ReaderBuilder(
      useSliverProtocol: true,
      key: Key('RdrBldr_Chp${chapter!.id}'),
      chapter: chapter!,
      itemBuilder: itemBuilder,
      // leadItems: [header(context)],
      // endItems: const [SliverToBoxAdapter(child: Text('/End'))],
    );
  }

  Widget debugCornerWidget(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0x88222222),
            border: Border.all(color: const Color(0xffaaaaaa), width: 1.5),
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Text(chapter!.displayTitle),
          // Text('Height: $height'),
        ]));
  }
}
