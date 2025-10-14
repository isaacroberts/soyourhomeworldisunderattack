import 'package:soyourhomeworld/backend/bookmark_saver.dart';

import 'book.dart';
import 'chapter.dart';

///Convenience classes for moving tree out of scroller
const defaultStartChapter = NoStartChapter();

abstract class StartChapter {
  const StartChapter();
  Future<Chapter?> getStart(Book book);
}

class SearchedStartChapter extends StartChapter {
  final String term;
  const SearchedStartChapter(this.term);
  @override
  Future<Chapter?> getStart(Book book) async {
    return book.findChapterBySearchTerm(term);
  }

  @override
  toString() {
    return 'SearchedStartChapter: "$term"';
  }
}

class IntStartChapter extends StartChapter {
  final int id;
  const IntStartChapter(this.id);
  @override
  Future<Chapter?> getStart(Book book) async {
    if (id >= 0 && id < book.chapterAmt) {
      return book.chapters[id];
    }
    return null;
  }

  @override
  toString() {
    return 'IntStartChapter: $id';
  }
}

class NoStartChapter extends StartChapter {
  const NoStartChapter();
  @override
  Future<Chapter?> getStart(Book book) async {
    int? chapterIx = await GlobalBookmark.instance.getStartChapter();
    //If non-null & in bounds
    if (chapterIx != null) {
      if (chapterIx >= 0 && chapterIx < book.chapterAmt) {
        return book.chapters[chapterIx];
      }
    }
    return book.chapters[0];
  }

  @override
  toString() {
    return 'NoStartChapter';
  }
}

///For when a start was attempted but failed.
///Does not attempt to recover bookmarks
///Scaffold should add Snackbar
class FailedStartChapter extends StartChapter {
  final String reason;
  const FailedStartChapter(this.reason);
  @override
  Future<Chapter?> getStart(Book book) async {
    return book.chapters[0];
  }

  @override
  toString() {
    return 'FailedStartChapter: ($reason)';
  }
}
