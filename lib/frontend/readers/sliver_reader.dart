import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';
import '../../../backend/chapter_data.dart';
import '../elements/holders/holder_base.dart';
import '../view_settings.dart';
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
    ViewSettings.instance.testRigNotifier.addListener(debugChanged);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ViewSettings.instance.testRigNotifier.removeListener(debugChanged);
    super.dispose();
  }

  void debugChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget itemBuilder(BuildContext context, Holder holder, bool showFonts) {
    return holder.sliver(context);
  }

  Widget debugBuilder(BuildContext context, Holder holder, bool showFonts) {
    return holder.debugSliver(context);
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      //Returns zero box, so rest of reader can use ! null checks
      return const SliverToBoxAdapter(
          key: Key('SliverReaderNull'),
          child: SizedBox(
            height: 400,
          ));
    }

    var builder = ViewSettings.instance.useTestRig ? debugBuilder : itemBuilder;

    return ReaderBuilder(
      key: const Key('RdrBldr'),
      itemBuilder: builder,
      leadItems: const [
        SliverToBoxAdapter(
            key: Key('stbaLead'),
            child: SizedBox(
              height: 24,
            ))
      ],
      endItems: const [
        SliverToBoxAdapter(
            key: Key('endPad'),
            child: SizedBox(
              height: 12,
            ))
      ],
    );
  }
}
