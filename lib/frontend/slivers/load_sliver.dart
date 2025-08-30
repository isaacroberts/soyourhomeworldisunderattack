import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';

const double loaderInsetHeight = 250;

class ChapterLoadSliver extends StatelessWidget {
  final String chapterTitle;
  const ChapterLoadSliver({super.key, required this.chapterTitle});

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
