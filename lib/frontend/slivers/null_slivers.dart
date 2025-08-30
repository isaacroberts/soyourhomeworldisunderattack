import 'package:flutter/material.dart';

import '../elements/widgets/deferred_icon.dart';

class NullChapterSliver extends StatelessWidget {
  const NullChapterSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
        key: Key('nullChapter(zero)'), padding: EdgeInsets.zero);
  }
}

class BlankChapterSliver extends StatelessWidget {
  const BlankChapterSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        key: const Key('nullChapter(blank)'),
        child: Container(
            height: 600,
            color: const Color(0xff444444),
            child: const DeferredRpgIcon(
                iconIx: 0, size: 48, color: Color(0xff888888))));
  }
}
