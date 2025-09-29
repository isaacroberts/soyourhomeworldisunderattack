import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_icon.dart';

import '../elements/widgets/loader.dart';

class EmptyChapterSliver extends StatelessWidget {
  const EmptyChapterSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
        key: Key('nullChapter(zero)'), padding: EdgeInsets.zero);
  }
}

class LoadSliver extends StatelessWidget {
  ///Before any info on the Chapter
  final String chapterTitle;
  const LoadSliver({super.key, required this.chapterTitle});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: TriWizardLoader(
              key: const Key("chp"),
              message: '"$chapterTitle"...',
            ))));
  }
}

///Simple arranged loader with height 400
class SmallLoadSliver extends StatelessWidget {
  const SmallLoadSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
        key: Key('LdrSmal'),
        child: SizedBox(
            key: Key('s'),
            height: 300,
            child: Center(
                key: Key('c'),
                child: NoMessageTriWizardLoader(
                  key: Key("ldr"),
                ))));
  }
}

class BlankChapterSliver extends StatelessWidget {
  /// Shows to user that a chapter is missing
  ///   Appears as a Trap Chapter, aka, a Trapter
  const BlankChapterSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
        key: Key('trapter'),
        child: SizedBox(
            height: 400,
            child: DeferredRpgIcon(
                //Trap Icon
                iconIx: 41,
                //Large
                size: 48,
                //Half opacity white
                color: Color(0x80ffffff))));
  }
}
