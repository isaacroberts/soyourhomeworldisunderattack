import 'dart:async';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';

import '../frontend/elements/holders/holder_base.dart';
//Deferred loads
import 'binary_utils/buffer_ptr.dart' deferred as buffer_lib;
import 'chapter.dart';
import 'chapter_info.dart';
import 'chapter_parser.dart' deferred as parser_lib;

typedef ChapterAndStream = (Chapter, Stream<Holder>);

class ChapterHolder {
  /// This one stores the chapter, as a cache.
  /// ChapterInfo is more transient, and can be moved around
  final ChapterInfo info;
  Chapter? chapter;
  Stream<Holder>? stream;
  Future<ChapterAndStream>? startedStream;
  late final GlobalKey globalKey;

  ChapterLoadNotifier loadNotifier = ChapterLoadNotifier();

  // =Headers
  ChapterKey get id => info.id;
  String get varName => info.varName;
  String get displayName => info.displayName;
  String get filename => info.filename;
  bool get isPart => info.isPart;

//Can't be final because of object creation
  ChapterHolder? next;
  ChapterHolder? previous;

  ChapterKey? get previousId => previous?.id;
  ChapterKey? get nextId => next?.id;

  ChapterHolder(this.info)
      : globalKey = GlobalKey(debugLabel: 'Chapter_${info.varName}');

  static const String bookId = 'SoYourHomeworld';

  Future<ChapterAndStream> load() {
    return getOrLoadChapter();
  }

  CancelableOperation<ChapterAndStream> loadCancellable() {
    return CancelableOperation.fromFuture(getOrLoadChapter());
  }

  bool get needsLoad => chapter == null && !loading;
  bool get loading => startedStream != null || _loading;
  //TODO: Don't show loader once stream is running
  bool get showLoader => (chapter == null); // || (startedStream != null);
  bool _loading = false;

  Future<ChapterAndStream> getOrLoadChapter() async {
    if (startedStream != null) {
      return startedStream!;
    }
    if (chapter == null) {
      _loading = true;
      String path = 'book_binary/${info.filename}';
      dev.log("LOad path: $path");
      ByteBuffer buffer = await getFileFromServer(path);
      ByteData data = buffer.asByteData();
      await buffer_lib.loadLibrary();
      var ptr = buffer_lib.BufferPtr(data.buffer);
      await parser_lib.loadLibrary();
      var parser = parser_lib.ChapterParser(debugId: info.varName, ptr: ptr);

      startedStream = parser.getChapterAndStream(info, handleErrors: true);
      _loading = false;

      startedStream?.then((ChapterAndStream c) {
        chapter = c.$1;
        stream = c.$2;
        startedStream = null;
        loadNotifier.notify();
      });
      loadNotifier.notify();
      return startedStream!;
    } else {
      return (chapter!, stream!);
    }
    // return chapter!;
  }

  bool loaded() {
    return chapter != null;
  }

  bool matchesSearchTerm(String searchTerm) {
    //TODO: A ranking might be smarter
    if (displayName.contains(searchTerm)) {
      return true;
    }
    if (searchTerm.contains(displayName)) {
      return true;
    }
    if (varName.contains(searchTerm)) {
      return true;
    }
    if (searchTerm.contains(varName)) {
      return true;
    }
    String? headerText = chapter?.header?.text;
    if (headerText != null && headerText.isNotEmpty) {
      if (headerText.contains(searchTerm)) {
        return true;
      }
      if (searchTerm.contains(headerText)) {
        return true;
      }
    }

    return false;
  }
}
