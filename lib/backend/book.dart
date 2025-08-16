import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '_book_libs.dart' deferred as book_lib;
import 'chapter.dart';
import 'chapter_data.dart';
import 'chapter_info.dart';
import 'error_handler.dart';

const String defaultBook = 'SoYourHomeworld';

class BookProvider extends InheritedWidget {
  final Book book;
  const BookProvider({super.key, required super.child, required this.book});

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
    if (kDebugMode) {
      for (int ch = 0; ch < chapters.length; ++ch) {
        assert(chapters[ch].index == ch);
      }
    }
  }

  // Book.mckinsey() : id = 'SoYourHomeworld';

  int get chapterAmt => chapters.length;

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

  int? findChapterBySearchTerm(String name) {
    name = name.toLowerCase();
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (chapters[ix].varName.toLowerCase() == name) {
        return ix;
      }
    }
    //Oops! Now check other methods
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (chapters[ix].varName.toLowerCase() == name) {
        return ix;
      } else {
        dev.log(
            '  > Search Chapter: ${chapters[ix].varName.toLowerCase()} =/= $name');
      }
    }
    return null;
  }

  bool hasKey(ChapterKey key) {
    return (key >= 0 && key < chapters.length);
  }

  Future<ChapterData> getAndLoadChapter(ChapterKey key) async {
    var tup = await chapters[key].getOrLoadChapter();
    return tup.$1;
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

  Future<Book?> load() async {
    if (book != null) {
      return book;
    }
    await book_lib.loadLibrary();
    return book_lib.loadBookLoader(this);
  }
}
