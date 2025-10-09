import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/font_cache.dart';

import '_json_book_libs.dart' deferred as loader_lib;
import 'chapter.dart';
import 'chapter_data.dart';
import 'chapter_info.dart';
// import '_binary_book_libs.dart' deferred as book_lib;

import 'chapter_search.dart' deferred as search_lib;
import 'error_handler.dart';

const String defaultBook = 'SoYourHomeworld';

class BookProvider extends InheritedWidget {
  final Book book;
  const BookProvider({super.key, required this.book, required super.child});

  static BookProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BookProvider>();
  }

  static BookProvider of(BuildContext context) {
    BookProvider? bp = maybeOf(context);
    if (bp == null) {
      ErrorList.logError('No BookProvider in context.');
      assert(false, "No BookProvider in context.");
    }
    return bp!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is! BookProvider) {
      return true;
    } else if (book != oldWidget.book) {
      return true;
    }
    return false;
  }
}

class Book {
  final String id;

  //Loaded
  final String title;
  final Color color;
  //TODO: Make private, and add null-aware [] operator
  final List<Chapter> chapters;
  Iterable<Chapter> get parts => chapters.where((p) => p.isPart);
  final String byline;

  Book(
      {required this.id,
      required this.title,
      required this.color,
      required this.chapters,
      required this.byline}) {
    //Urls & names of font families
    FontCache.getInstance().readFontTable();
    if (kDebugMode) {
      for (int ch = 0; ch < chapters.length; ++ch) {
        assert(chapters[ch].index == ch,
            '${chapters[ch]} has incorrect id: ${chapters[ch].index}; in position $ch');
      }
    }
  }

  // Book.mckinsey() : id = 'SoYourHomeworld';

  int get chapterAmt => chapters.length;

  bool inBounds(int chapterIndex) {
    return chapterIndex >= 0 && chapterIndex < chapterAmt;
  }

  static Book? maybeOf(BuildContext context) {
    return BookProvider.maybeOf(context)?.book;
  }

  static Book of(BuildContext context) {
    return BookProvider.of(context).book;
  }

  @override
  String toString() {
    return '($id) $title';
  }

  @override
  bool operator ==(Object other) {
    if (other is! Book) {
      return false;
    }
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  String getChapterName(int ix) {
    return chapters[ix].displayName;
  }

  int? findChapterByVarname(String name) {
    name = name.toLowerCase();
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (chapters[ix].varName.toLowerCase() == name) {
        return ix;
      }
    }
    return null;
  }

  static bool hasEverPrintedAllBefore = false;

  Future<Chapter?> findChapterBySearchTerm(String name) async {
    await search_lib.loadLibrary();
    name = name.toLowerCase();
    assert(name != 'null');
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (search_lib.chapterMatchesSearchTermDirect(chapters[ix], name)) {
        return chapters[ix];
      }
    }
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (search_lib.chapterMatchesSearchTermPermissive(chapters[ix], name)) {
        return chapters[ix];
      }
    }
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (search_lib.chapterMatchesSearchTermDesperate(chapters[ix], name)) {
        return chapters[ix];
      }
    }
    //It's actually really helpful to see that my links aren't working
    if (kDebugMode) {
      if (!hasEverPrintedAllBefore) {
        //Only print this behemoth once!
        hasEverPrintedAllBefore = true;
        //Look for where link should have been.
        //This is helpful because the author can navigate the chapter order
        for (int ix = 0; ix < chapters.length; ++ix) {
          search_lib.printChapterSearchTerms(chapters[ix], name);
        }
      }
    }
    dev.log("Couldn't find chapter: $name");
    return null;
  }

  Stream<Chapter> streamChapterBySearchTerm(String name) async* {
    name = name.toLowerCase();
    assert(name != 'null');
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (search_lib.chapterMatchesSearchTermDirect(chapters[ix], name)) {
        yield chapters[ix];
      }
    }
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (search_lib.chapterMatchesSearchTermPermissive(chapters[ix], name)) {
        yield chapters[ix];
      }
    }
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (search_lib.chapterMatchesSearchTermDesperate(chapters[ix], name)) {
        yield chapters[ix];
      }
    }
  }

  bool hasKey(ChapterKey key) {
    return (key >= 0 && key < chapters.length);
  }

  Future<ChapterData?> getAndLoadChapter(ChapterKey key) async {
    return chapters[key].getOrLoadChapter();
  }

  ChapterData? getChapterIfLoaded(ChapterKey key) {
    return chapters[key].data;
  }

  // Future<Chapter> refreshChapter(ChapterKey key) {
  //   if (TEST_RIG) {
  //     chapters[key].chapter = null;
  //     return chapters[key].getOrLoadChapter();
  //   } else {
  //     throw Exception("Requesting a reload without the test rig - impossible!");
  //   }
  // }

  Future<ChapterData?> getNextChapter(ChapterData? current) async {
    if (current == null) {
      return null;
    } else {
      int? id = current.nextId;
      if (id != null) {
        return getAndLoadChapter(id);
      } else {
        return null;
      }
    }
  }

  // Chapter? getPreviousChapter(Chapter? current) {
  //   int id = (current?.id ?? 1) - 1;
  //   return getChapter(id);
  // }
}

class BookLoader {
  // There can be only one McKinsey Plan.

  static BookLoader? _instance;
  static BookLoader get instance {
    _instance ??= BookLoader._mckinsey();
    return _instance!;
  }

  ///
  final String id;

  //
  Book? book;

  //Loaded
  String title = '';
  Color color = const Color(0xff888888);
  List<ChapterInfo> chapters = [];
  String byline = '';

  BookLoader(this.id);
  BookLoader._mckinsey() : id = defaultBook;

  Book convert() {
    List<Chapter> chapterHolders = [];
    //Add objects
    for (ChapterInfo info in chapters) {
      chapterHolders.add(Chapter(info));
    }
    //Match nexts
    for (int n = 0; n < chapterHolders.length; ++n) {
      int? nextId = chapters[n].next;
      if (nextId != null) {
        chapterHolders[n].next = chapterHolders[nextId];
      }
    }
//Set previous where modified
    for (int n = 0; n < chapterHolders.length; ++n) {
      chapterHolders[n].next?.previous = chapterHolders[n];
    }
//Fill defaults with n-1
    //Starting at 1
    for (int n = 1; n < chapterHolders.length; ++n) {
      chapterHolders[n].previous ??= chapterHolders[n - 1];
    }
    //Set partname

    return Book(
        id: id,
        title: title,
        color: color,
        chapters: chapterHolders,
        byline: byline);
  }

  bool wellFormed() {
    return id.isNotEmpty && title.isNotEmpty && chapters.isNotEmpty;
  }

  @override
  String toString() {
    return '($id) $title';
  }

  String getChapterName(int ix) {
    return chapters[ix].displayName;
  }

  // int? findChapterByVarname(String name) {
  //   name = name.toLowerCase();
  //   for (int ix = 0; ix < chapters.length; ++ix) {
  //     if (chapters[ix].varName.toLowerCase() == name) {
  //       return ix;
  //     }
  //   }
  //   dev.log("Couldn't find chapter $name");
  //   for (int ix = 0; ix < chapters.length; ++ix) {
  //     dev.log(
  //         '$ix: varName=${chapters[ix].varName} display=${chapters[ix].displayName}');
  //     if (chapters[ix].varName.toLowerCase() == name) {
  //       return ix;
  //     }
  //   }
  //   return null;
  // }

  Future<Book> load() async {
    if (book != null) {
      return book!;
    }
    await loader_lib.loadLibrary();
    book = await loader_lib.loadBookLoader(this);
    return book!;
  }
}
