import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soyourhomeworld/frontend/chapter_heading/noir/title.dart';
import 'package:soyourhomeworld/frontend/parts/noir_colors.dart';

enum BookmarkSaveStatus {
  current,
  saving,
  failed,
  uninitialized;

  IconData get icon {
    switch (this) {
      case BookmarkSaveStatus.current:
        return Icons.bookmark;
      case BookmarkSaveStatus.saving:
        return Symbols.bookmark_border;
      case BookmarkSaveStatus.failed:
        return Symbols.bookmark_remove_rounded;
      case BookmarkSaveStatus.uninitialized:
        return Symbols.book_ribbon_rounded;
    }
  }

  String get tooltip {
    switch (this) {
      case BookmarkSaveStatus.current:
        return "Bookmark saved";
      case BookmarkSaveStatus.saving:
        return 'Saving bookmark...';
      case BookmarkSaveStatus.failed:
        return 'Bookmark failed.';
      case BookmarkSaveStatus.uninitialized:
        return 'Bookmarks not yet loaded';
    }
  }
}

class GlobalBookmark {
  static GlobalBookmark? _instance;
  static GlobalBookmark get instance {
    _instance ??= GlobalBookmark._privateConstructor();
    return _instance!;
  }

  final ValueNotifier<BookmarkSaveStatus> bookmarkStatus =
      ValueNotifier(BookmarkSaveStatus.uninitialized);
  final ValueNotifier<int?> savedBookmark = ValueNotifier(null);
  final ValueNotifier<int?> _currentChapter = ValueNotifier(null);

  ValueNotifier<int?> get currentChapterNotifier => _currentChapter;

  int? uuid;

  set currentChapter(int? set) {
    //Currently, if currentChapter is null, that means title screen (since it doesn't have a detector)
    set ??= 0;
    if (set != _currentChapter.value) {
      _currentChapter.value = set;
      currentChapterChanged();
    }
  }

  int? get currentChapter => _currentChapter.value;

  void _setCurrentChapter(int? set) {
    _currentChapter.value = set;
  }

  GlobalBookmark._privateConstructor() {
    // currentChapter.addListener(currentChapterChanged);
  }

  ///I don't think this will ever be called
  void dispose() {
    // currentChapter.removeListener(currentChapterChanged);
  }

  Future<int?> startupLoad() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _setCurrentChapter(prefs.getInt('bookmark'));
    uuid = prefs.getInt('session_id');
    //-1 = null
    if (uuid == -1) {
      //Null value
      uuid = null;
    }
    return currentChapter;
  }

  void currentChapterChanged() {
    //If currentChapter is null, (currently) that means it's on zero
    bookmarkStatus.value = BookmarkSaveStatus.saving;
    int index = currentChapter ?? 0;
    bookmarkCurrentChapter(index);
  }

  ///Save current chapter to cookies
  void bookmarkCurrentChapter(int ix) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await Future.delayed(Duration(seconds: 1));
    bool set = await prefs.setInt('bookmark', ix);
    if (set) {
      savedBookmark.value = ix;
      bookmarkStatus.value = BookmarkSaveStatus.current;
    } else {
      bookmarkStatus.value = BookmarkSaveStatus.failed;
    }
  }

  ///Get current chapter from cookies
  Future<int?> getStartChapter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? prefsBkmk = prefs.getInt('bookmark');
    loadUUID();
    if (prefsBkmk != null) {
      savedBookmark.value = prefsBkmk;
      currentChapter = prefsBkmk;
      bookmarkStatus.value = BookmarkSaveStatus.current;
      return savedBookmark.value;
    } else {
      //TODO: Prompt user to use other methods
      return null;
    }
  }

  Future<int?> loadUUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uuid = prefs.getInt('session_id');
    //-1 === null
    if (uuid == -1) {
      //Null value
      uuid = null;
    }
    return uuid;
  }

  void saveUUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('session_id', uuid ?? -1);
  }
}

class BookmarkSaveStatusIcon extends StatelessWidget {
  const BookmarkSaveStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: GlobalBookmark.instance.bookmarkStatus, builder: builder);
  }

  Widget builder(BuildContext context, Widget? previous) {
    BookmarkSaveStatus status = GlobalBookmark.instance.bookmarkStatus.value;
    //TODO: Some animation with previous, maybe an animatedSwitcher
    //TODO: Respond to part/theme correctly
    // dev.log("Bkmk Icon Builder: $status");
    return Tooltip(
        message: status.tooltip,
        child: Icon(
          status.icon,
          color: NoirPrimary.shadec,
          size: 24,
        ));
  }
}

///Shows user that bookmark is correct
class BookmarkNumberDisplay extends StatelessWidget {
  const BookmarkNumberDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        key: const Key('bkmkDispTt'),
        message: 'Saved bookmark',
        child: ListenableBuilder(
            key: const Key('bkmkDispBldr'),
            listenable: GlobalBookmark.instance.savedBookmark,
            builder: builder));
  }

  Widget builder(BuildContext context, Widget? previous) {
    int? index = GlobalBookmark.instance.savedBookmark.value;
    return ChapterNumber(key: const Key('bkmkDisp'), index: index);
  }
}
