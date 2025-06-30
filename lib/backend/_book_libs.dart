import 'dart:async';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/chapter_parser.dart'
    deferred as chapter_parser_lib;
import 'package:soyourhomeworld/backend/server.dart';

import 'binary_utils/buffer_ptr.dart';
import 'book.dart';
import 'chapter.dart';
import 'error_handler.dart';

Future<Book?> loadBookLoader(BookLoader that) async {
  if (that.book != null) {
    return that.book;
  }
  ByteBuffer buffer = await getFileFromServer('book_binary/${that.id}.book');

  ByteData bytes = buffer.asByteData();
  BufferPtr ptr = BufferPtr(bytes.buffer);

  try {
    parseBookLoader(that, ptr);
    await parseBookIndex(that);

    // id.isNotEmpty && title.isNotEmpty && chapters.isNotEmpty;

    if (that.wellFormed()) {
      that.book = that.convert();
      return that.book;
    } else {
      ErrorList.logError(ChapterFormatException(
          'Malformed book id=${that.id} title=${that.title} chp.length=${that.chapters.length}',
          debugId: "Book_${that.id}"));
      return null;
    }
  } catch (exception, trace) {
    dev.log(" ! Book Loading Exception: $exception");
    ErrorList.logError(exception, trace);
    return null;
  }
}

void parseBookLoader(BookLoader that, BufferPtr ptr) {
  //TODO: Update that

  dev.log('Parsing ${that.id}');

  ptr.assertConsume('.', debugId: that.id);
  ptr.assertConsume('.', debugId: that.id);
  ptr.assertConsume('\\', debugId: that.id);
  ptr.assertConsume('/', debugId: that.id);
  ptr.assertConsume('.', debugId: that.id);
  ptr.assertConsume('.', debugId: that.id);

  // dev.log('--1-');
  String? id = ptr.consumeText();
  assert(id == that.id);

  ptr.assertConsume('T', debugId: that.id);
  ptr.assertConsume(':', debugId: that.id);

// ptr += pack_text(title)
  String? title = ptr.consumeText();
  if (title == null) {
    throw ChapterFormatException("Null title in book header", debugId: that.id);
  } else {
    that.title = title;
  }

  // dev.log('--2-');
// ptr += '='
  ptr.assertConsume('C', debugId: that.id);
  ptr.assertConsume(':', debugId: that.id);
  Color? c = ptr.consumeColor();
  if (c != null) {
    that.color = c;
  }

  // dev.log('-3--');
  ptr.assertConsume('B', debugId: that.id);
  ptr.assertConsume(':', debugId: that.id);
  String? byline = ptr.consumeText();

  if (byline != null) {
    that.byline = byline;
  }
  // dev.log('4---');
// ptr += '>-*/\\*-<'
  ptr.assertConsume('>', debugId: that.id);
  ptr.assertConsume('-', debugId: that.id);
  ptr.assertConsume('*', debugId: that.id);
  ptr.assertConsume('/', debugId: that.id);
  ptr.assertConsume('\\', debugId: that.id);
  ptr.assertConsume('*', debugId: that.id);
  ptr.assertConsume('-', debugId: that.id);
  ptr.assertConsume('<', debugId: that.id);

  dev.log(
      'Book loaded. Id = $id title = $title byline = ${that.byline.substring(0, 5)}...');
  assert(!ptr.hasMore());
}

Future<void> parseBookIndex(BookLoader that) async {
  ByteBuffer buffer = await getFileFromServer('book_binary/${that.id}/index');

  ByteData bytes = buffer.asByteData();
  BufferPtr ptr = BufferPtr(bytes.buffer);
  await chapter_parser_lib.loadLibrary();
  var parser =
      chapter_parser_lib.ChapterParser(debugId: 'book${that.id}', ptr: ptr);
  ptr.assertConsume('+', debugId: that.id);
  while (ptr.hasMore() && ptr.getChar() == '(') {
    ChapterInfo? chapter = await parser.parseBookHeader(that.chapters.length);
    if (chapter != null) {
      that.chapters.add(ChapterHolder(chapter));
    }
  }
  ptr.assertConsume(';', debugId: that.id);
  dev.log('${that.chapters.length} chapters in book ${that.id}');
}
