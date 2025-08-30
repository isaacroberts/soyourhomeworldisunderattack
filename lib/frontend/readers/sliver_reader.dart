import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';
import '../../../backend/chapter_data.dart';
import '../elements/holders/holder_base.dart';
import 'reader_builder.dart';

class SliverReader extends StatefulWidget {
  const SliverReader({required super.key});

  @override
  State<StatefulWidget> createState() => _SliverReaderState();
}

class _SliverReaderState extends State<SliverReader> {
  late Chapter chapter;
  ChapterData? get data => chapter.data;

  @override
  void didChangeDependencies() {
    chapter = Chapter.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget itemBuilder(BuildContext context, Holder holder, bool showFonts) {
    if (holder.wantsPadding) {
      return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
              child: holder.elementCheckingFallback(context)));
    } else {
      return SliverToBoxAdapter(
          child: holder.elementOrFallback(context, showFonts));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      //Returns zero box, so rest of reader can use ! null checks
      return const SliverToBoxAdapter(
          child: SizedBox(
        height: 400,
      ));
    }

    return ReaderBuilder(
      useSliverProtocol: true,
      key: const Key('RdrBldr'),
      itemBuilder: itemBuilder,
      leadItems: const [
        SliverToBoxAdapter(
            child: SizedBox(
          height: 24,
        ))
      ],
      endItems: const [
        SliverToBoxAdapter(
            child: SizedBox(
          height: 12,
        ))
      ],
    );
  }
}
