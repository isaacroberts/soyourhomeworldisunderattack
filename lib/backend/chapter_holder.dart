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
import 'error_handler.dart';

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
  String get key => info.id.toString();
  ChapterKey get id => info.id;
  int get index => info.id;
  String get varName => info.varName;
  String get displayName => info.displayName;
  String get filename => info.filename;
  bool get isPart => info.isPart;

//Can't be final because of object creation
  ChapterHolder? next;
  ChapterHolder? previous;

  ChapterKey? get previousId => previous?.id;
  ChapterKey? get nextId => next?.id;

  String get searchUrl => '/search/$varName';
  String get scrollUrl => '/scroll/$id';

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
    } else if (chapter == null) {
      //If loading already marked
      if (_loading) {
        //Wait for other stream to be ready
        await Future.delayed(const Duration(seconds: 1));
        //startedStream object should be ready
        if (startedStream != null) {
          return startedStream!;
        }
        //If not check, if chapter has already finished
        else if (chapter != null) {
          if (stream != null) {
            return (chapter!, stream!);
          } else {
            //Frankly, if stream object is null, we should wait another few seconds
            await Future.delayed(const Duration(milliseconds: 10));
            //Try again
            if (stream != null) {
              return (chapter!, stream!);
            }
          }
        } else {
          //Otherwise, continue loading, which will re-load the chapter object
          ErrorList.logWarning('Reloading chapter $varName');
        }
      }

      _loading = true;
      String path = 'book_binary/${info.filename}';
      dev.log("(ChapterHolder) Load: $path");
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

  Future<String?> awaitSubtitle() async {
    ///Future for Subtitle. Technically might not return
    if (needsLoad) {
      await load();
      return chapter?.subtitle;
    } else if (chapter != null) {
      return chapter!.subtitle;
    } else {
      await startedStream;
      return chapter?.subtitle;
    }
  }

  Future<String?> awaitWhere() async {
    if (needsLoad) {
      await load();
      return chapter?.where;
    } else if (chapter != null) {
      return chapter!.where;
    } else {
      await startedStream;
      return chapter?.where;
    }
  }

  Future<String?> awaitWhen() async {
    if (needsLoad) {
      await load();
      return chapter?.when;
    } else if (chapter != null) {
      return chapter!.when;
    } else {
      await startedStream;
      return chapter?.when;
    }
  }
}
