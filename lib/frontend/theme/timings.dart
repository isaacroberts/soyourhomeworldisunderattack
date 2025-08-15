import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../backend/chapter_holder.dart';

Curve get scrollToChapterCurve => Curves.easeOutExpo;
const Duration scrollToChapterDuration = Duration(milliseconds: 2000);

void scrollToChapter(ChapterHolder? chapter, {required BuildContext? context}) {
  /// Scroll to chapter, if possible.
  /// Otherwise,
  if (chapter == null) {
    return;
  }
  BuildContext? scrollTo = chapter.globalKey.currentContext;
  if (scrollTo != null && scrollTo.mounted) {
    Scrollable.ensureVisible(scrollTo,
        duration: scrollToChapterDuration, curve: scrollToChapterCurve);
  } else {
    //If currentChapter is not in view, go to the URL
    context?.go(chapter.searchUrl);
  }
}
