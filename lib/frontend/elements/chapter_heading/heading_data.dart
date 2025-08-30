import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';

typedef ChapterMainCallback = void Function(Chapter?);

class ChapterHeadingData extends InheritedWidget {
  final ChapterMainCallback? onChapterBecomesMain;

  const ChapterHeadingData(
      {super.key, required super.child, required this.onChapterBecomesMain});

  static ChapterHeadingData? maybeOf(BuildContext context) {
    //There is no hard .of().
    return context.dependOnInheritedWidgetOfExactType<ChapterHeadingData>();
  }

  @override
  bool updateShouldNotify(ChapterHeadingData oldWidget) {
    return oldWidget.onChapterBecomesMain != onChapterBecomesMain;
  }
}
