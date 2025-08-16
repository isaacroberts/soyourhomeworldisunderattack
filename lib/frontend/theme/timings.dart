import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../backend/chapter.dart';

Curve get scrollToChapterCurve => Curves.easeOutExpo;
const Duration scrollToChapterDuration = Duration(milliseconds: 2000);

enum DidScroll {
  no,
  scrolled,
  url,
}

Future<DidScroll> scrollToChapter(Chapter? chapter,
    {required BuildContext? context,
    Duration? duration,
    Curve? curve,
    double? alignment}) async {
  /// Scroll to chapter, if possible.
  /// Returns true if scrolled
  if (chapter == null) {
    return DidScroll.no;
  }
  BuildContext? scrollTo = chapter.globalKey.currentContext;
  if (scrollTo != null && scrollTo.mounted) {
    await Scrollable.ensureVisible(
      scrollTo,
      duration: duration ?? scrollToChapterDuration,
      curve: curve ?? scrollToChapterCurve,
      // alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      alignment: alignment ?? 0,
    );
    return DidScroll.scrolled;
  } else {
    //If currentChapter is not in view, go to the URL
    context?.go(chapter.searchUrl);
    return DidScroll.url;
  }
}
