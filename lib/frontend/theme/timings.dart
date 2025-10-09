import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  //TODO: Nobody's allowed to use context.go. Instead, they must use this function, which scrolls if possible.
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
    if (context?.canPop() ?? false) {
      context?.pop();
    }
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
          //The close button is confusing because it still opens
          showCloseIcon: false,
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

Future<bool> openLink(String? link, BuildContext context) async {
  if (link == null) {
    return false;
  }
  bool canOpen = await canLaunchUrlString(link);
  ValueNotifier<bool> shouldOpen = ValueNotifier(canOpen);
  if (context.mounted) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        //Simple snackbar
        SnackBar(
            showCloseIcon: true,
            //Simple custom content
            content:
                OpenUrlSnackbarContent(shouldOpen: shouldOpen, link: link)));
  } else {
    return false;
  }
  await Future.delayed(Duration(seconds: 3));

  if (context.mounted) {
    if (shouldOpen.value) {
      launchUrlString(link, mode: LaunchMode.inAppBrowserView);
      return true;
    }
  }
  return false;
}

///TODO: Move, defer load
class OpenUrlSnackbarContent extends StatelessWidget {
  final String? link;
  final ValueNotifier<bool> shouldOpen;
  const OpenUrlSnackbarContent({
    super.key,
    required this.link,
    required this.shouldOpen,
  });

  void cancel() {
    shouldOpen.value = false;
  }

  void toggle() {
    shouldOpen.value = !shouldOpen.value;
  }

  void copyLink() {
    //Presumably user doesn't want to do both
    shouldOpen.value = false;
    Clipboard.setData(ClipboardData(text: link ?? '?'));
  }

  Widget iconBuilder(BuildContext context, Widget? previous) {
    return IconButton(
        onPressed: toggle,
        icon: Icon(
          shouldOpen.value ? Icons.link : Icons.link_off,
          size: 24,
        ));
  }

  Widget textBuilder(BuildContext context, Widget? previous) {
    return Text(
      '${shouldOpen.value ? 'Opening' : 'Not opening'} [$link]',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      //appFont
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  @override
  Widget build(BuildContext context) {
//Remove newlines

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Copy icon for clarity

          ListenableBuilder(listenable: shouldOpen, builder: iconBuilder),
          //Visual space
          const SizedBox(
            width: 6,
          ),
          //Show as much of text as possible
          Expanded(
              child: ListenableBuilder(
                  listenable: shouldOpen, builder: textBuilder)),
          FilledButton(onPressed: cancel, child: const Text("Cancel")),
          IconButton(onPressed: copyLink, icon: const Icon(Icons.copy))
        ]);
  }
}
