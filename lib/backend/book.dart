import 'dart:async';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/backend/chapter_parser.dart';
import 'package:soyourhomeworld/backend/server.dart';

import '../frontend/pages/scrollers/test_rig_scroller.dart';
import 'binary_utils/buffer_ptr.dart';
import 'chapter.dart';
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
  final List<ChapterHolder> chapters;
  final String byline;

  Book(
      {required this.id,
      required this.title,
      required this.color,
      required this.chapters,
      required this.byline});
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
//Oops! Now check
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

  Future<Chapter> getAndLoadChapter(ChapterKey key) {
    return chapters[key].getOrLoadChapter();
  }

  Chapter? getChapterIfLoaded(ChapterKey key) {
    return chapters[key].chapter;
  }

  Future<Chapter> refreshChapter(ChapterKey key) {
    if (TEST_RIG) {
      chapters[key].chapter = null;
      return chapters[key].getOrLoadChapter();
    } else {
      throw Exception("Requesting a reload without the test rig - impossible!");
    }
  }

  Future<Chapter?> getNextChapter(Chapter? current) async {
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
  final String id;

  //Loaded
  String title = '';
  Color color = const Color(0xff888888);
  List<ChapterHolder> chapters = [];
  String byline = '';

  BookLoader(this.id);
  BookLoader.mckinsey() : id = defaultBook;

  Book convert() {
    return Book(
        id: id, title: title, color: color, chapters: chapters, byline: byline);
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

  int? findChapterByVarname(String name) {
    name = name.toLowerCase();
    for (int ix = 0; ix < chapters.length; ++ix) {
      if (chapters[ix].varName.toLowerCase() == name) {
        return ix;
      }
    }
    dev.log("Couldn't find chapter $name");
    for (int ix = 0; ix < chapters.length; ++ix) {
      dev.log(
          '$ix: varName=${chapters[ix].varName} display=${chapters[ix].displayName}');
      if (chapters[ix].varName.toLowerCase() == name) {
        return ix;
      }
    }
    return null;
  }

  Future<Book?> load() async {
    ByteBuffer buffer = await getFileFromServer('book_binary/$id.book');

    ByteData bytes = buffer.asByteData();
    BufferPtr ptr = BufferPtr(bytes.buffer);

    try {
      parse(ptr);
      await parseIndex();

      // id.isNotEmpty && title.isNotEmpty && chapters.isNotEmpty;

      if (wellFormed()) {
        return convert();
      } else {
        ErrorList.logError(ChapterFormatException(
            'Malformed book id=$id title=$title chp.length=${chapters.length}',
            debugId: "Book_$id"));
        return null;
      }
    } catch (exception, trace) {
      dev.log(" ! Book Loading Exception: $exception");
      ErrorList.logError(exception, trace);
      return null;
    }
  }

  void parse(BufferPtr ptr) {
    //TODO: Update this

    dev.log('Parsing ${this.id}');

    ptr.assertConsume('.', debugId: this.id);
    ptr.assertConsume('.', debugId: this.id);
    ptr.assertConsume('\\', debugId: this.id);
    ptr.assertConsume('/', debugId: this.id);
    ptr.assertConsume('.', debugId: this.id);
    ptr.assertConsume('.', debugId: this.id);

    // dev.log('--1-');
    String? id = ptr.consumeText();
    assert(id == this.id);

    ptr.assertConsume('T', debugId: this.id);
    ptr.assertConsume(':', debugId: this.id);

// ptr += pack_text(title)
    String? title = ptr.consumeText();
    if (title == null) {
      throw ChapterFormatException("Null title in book header",
          debugId: this.id);
    } else {
      this.title = title;
    }

    // dev.log('--2-');
// ptr += '='
    ptr.assertConsume('C', debugId: this.id);
    ptr.assertConsume(':', debugId: this.id);
    Color? c = ptr.consumeColor();
    if (c != null) {
      color = c;
    }

    // dev.log('-3--');
    ptr.assertConsume('B', debugId: this.id);
    ptr.assertConsume(':', debugId: this.id);
    String? byline = ptr.consumeText();

    if (byline != null) {
      this.byline = byline;
    }
    // dev.log('4---');
// ptr += '>-*/\\*-<'
    ptr.assertConsume('>', debugId: this.id);
    ptr.assertConsume('-', debugId: this.id);
    ptr.assertConsume('*', debugId: this.id);
    ptr.assertConsume('/', debugId: this.id);
    ptr.assertConsume('\\', debugId: this.id);
    ptr.assertConsume('*', debugId: this.id);
    ptr.assertConsume('-', debugId: this.id);
    ptr.assertConsume('<', debugId: this.id);

    dev.log(
        'Book loaded. Id = $id title = $title byline = ${this.byline.substring(0, 5)}...');
    assert(!ptr.hasMore());
  }

  Future<void> parseIndex() async {
    ByteBuffer buffer = await getFileFromServer('book_binary/$id/index');

    ByteData bytes = buffer.asByteData();
    BufferPtr ptr = BufferPtr(bytes.buffer);
    ChapterParser parser = ChapterParser(debugId: 'book$id', ptr: ptr);
    ptr.assertConsume('+', debugId: id);
    while (ptr.hasMore() && ptr.getChar() == '(') {
      ChapterInfo? chapter = await parser.parseBookHeader(chapters.length);
      if (chapter != null) {
        chapters.add(ChapterHolder(chapter));
      }
    }
    ptr.assertConsume(';', debugId: id);
    dev.log('${chapters.length} chapters in book $id');
  }
}
