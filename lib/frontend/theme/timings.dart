import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../backend/chapter.dart';

Curve get scrollToChapterCurve => Curves.easeOutExpo;
const Duration scrollToChapterDuration = Duration(milliseconds: 2000);

///Return value for scrollToChapter
enum DidScroll {
  scrolled,
  no,
  url,
}

///Usable in CodeHolders and such
///Returns tri-state value: DidScroll
///       scrolled= Scrolled to chapter
///       no = Chapter was null
///       url = Chapter wasn't in view, so we went to a new page
Future<DidScroll> scrollToChapter(Chapter? chapter,
    {required BuildContext? context,
    Duration? duration,
    Curve? curve,
    double? alignment}) async {
  /// Scroll to chapter, if possible.
  /// Returns true if scrolled
  if (chapter == null) {
    //TODO: Don't allow null, remove tri-state enum
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

///Copy to clipboard & show standardized snackbar
///Trying to copy null shows "No text" to user
void copyText(BuildContext context, String? text) {
  if (text == null) {
    return;
  }

//Copy text
  //Set Clipboard data
  Clipboard.setData(ClipboardData(text: text));
  //Show snackbar
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      //Simple snackbar
      SnackBar(
          showCloseIcon: true,
          //Simple custom content
          content: CopiedSnackbarContent(text: text)));
}

///TODO: Move, defer load
class CopiedSnackbarContent extends StatelessWidget {
  final String text;
  const CopiedSnackbarContent({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
//Remove newlines
    String text = this.text.replaceAll('\n', ' ');

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Copy icon for clarity
          const Icon(
            Icons.copy_rounded,
            size: 24,
          ),
          //Visual space
          const SizedBox(
            width: 6,
          ),
          //Show as much of text as possible
          Expanded(
              child: Text(
            'Copied "$text"',
            //(\j: Press Ctrl+V to see the rest)
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            //appFont
            style: Theme.of(context).textTheme.bodyMedium,
          )),
        ]);
  }
}
