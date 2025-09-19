import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/index/searched_tile.dart'
    deferred as search_lib;

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';

Future<List<Widget>> splitParts(Book book) async {
  await _loadLibrary();
  return search_lib.splitParts(book);
}

Widget searchedTile(Chapter chapter, String searchTerm) {
  return search_lib.SearchedChapterTile(
      key: Key('searched_${chapter.id}'),
      chapter: chapter.info,
      searchTerm: searchTerm);
}

Future<bool> _ll() async {
  await search_lib.loadLibrary();
  return true;
}

Future<bool> _loadLibrary() async {
  if (_load != null) {
    return _load!;
  }
  _load = _ll();
  _arrived = await _load!;
  return _arrived;
}

Future<bool>? _load;
bool _arrived = false;
