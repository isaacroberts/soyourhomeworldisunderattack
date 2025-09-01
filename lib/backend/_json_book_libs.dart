import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';

import 'book.dart';
import 'chapter_info.dart';
import 'error_handler.dart';

Color? hexToColor(String? code) {
  if (code == null) {
    return null;
  }
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Future<Book> loadBookLoader(BookLoader that) async {
  var data = await getJsonFileFromServer('book_binary/${that.id}.json');
  if (data == null) {
    throw ChapterFormatException('Null data from ${that.id}.json',
        debugId: '${that.id}.book');
  }
  String? id = data['id'];
  assert(id == that.id, 'Json IDs dont match: $id != ${that.id}');
  String? title = data['title'];
  String? byline = data['byline'];
  //html hex #aabbcc
  String? colorHex = data['color'];
  Color? color = hexToColor(colorHex);

  that.title = title ?? 'Untitled';
  that.byline = byline ?? 'Unbylined';
  that.color = color ?? Colors.black;

  that.chapters = await loadIndex(that);
  return that.convert();
}

Future<List<ChapterInfo>> loadIndex(BookLoader that) async {
  var data = await getJsonFileFromServer('book_binary/${that.id}/index.json');

  if (data == null) {
    //Log but don't throw; there's no benefit to throwing, when it'll cause unclear errors in FutureBuilders and such
    ErrorList.logError(ChapterFormatException(
        'Null chapter index in index.json',
        debugId: '${that.id} Index'));
    return [];
  }
  List<ChapterInfo> chapters = [];
  for (var elem in data) {
    chapters.add(ChapterInfo.fromJson(chapters.length, elem));
  }
  return chapters;
}
