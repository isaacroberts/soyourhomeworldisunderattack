import 'dart:async';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/part_id.dart';
import 'package:soyourhomeworld/backend/server.dart';

import '../frontend/elements/holders/holder_base.dart';
//Deferred loads
import '../frontend/parts/part.dart';
import 'binary_utils/buffer_ptr.dart' deferred as buffer_lib;
import 'chapter_data.dart';
import 'chapter_info.dart';
import 'chapter_parser.dart' deferred as parser_lib;
import 'error_handler.dart';

typedef ChapterAndStream = (ChapterData, Stream<Holder>);

class Chapter {
  /// This one stores the chapter, as a cache.
  /// ChapterInfo is more transient, and can be moved around
  final ChapterInfo info;
  ChapterData? data;
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
  String get displayTitle => info.displayName;
  String get filename => info.filename;
  bool get isPart => info.isPart;
  PartId get part => info.partId;

  @override
  String toString() {
    return 'Chapter $varName ($id)';
  }

//Can't be final because of object creation
  Chapter? next;
  Chapter? previous;

  ChapterKey? get previousId => previous?.id;
  ChapterKey? get nextId => next?.id;

  String get searchUrl => '/search/$varName';
  String get scrollUrl => '/scroll/$id';

  Chapter(this.info)
      : globalKey = GlobalKey(debugLabel: 'Chapter_${info.varName}');

  static Chapter of(BuildContext context) {
    return ChapterProvider.of(context).chapter!;
  }

  static Chapter? maybeOf(BuildContext context) {
    return ChapterProvider.maybeOf(context)?.chapter;
  }

  static const String bookId = 'SoYourHomeworld';

  Future<ChapterAndStream> load() {
    return getOrLoadChapter();
  }

  CancelableOperation<ChapterAndStream> loadCancellable() {
    return CancelableOperation.fromFuture(getOrLoadChapter());
  }

  bool get needsLoad => data == null && !loading;
  bool get loading => startedStream != null || _loading;
  //TODO: Don't show loader once stream is running
  bool get showLoader => (data == null); // || (startedStream != null);
  bool _loading = false;

  Future<ChapterAndStream> getOrLoadChapter() async {
    if (startedStream != null) {
      return startedStream!;
    } else if (data == null) {
      //If loading already marked
      if (_loading) {
        //Wait for other stream to be ready
        await Future.delayed(const Duration(seconds: 1));
        //startedStream object should be ready
        if (startedStream != null) {
          return startedStream!;
        }
        //If not check, if chapter has already finished
        else if (this.data != null) {
          if (stream != null) {
            return (this.data!, stream!);
          } else {
            //Frankly, if stream object is null, we should wait another few seconds
            await Future.delayed(const Duration(milliseconds: 10));
            //Try again
            if (stream != null) {
              return (this.data!, stream!);
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
        this.data = c.$1;
        stream = c.$2;
        startedStream = null;
        loadNotifier.notify();
      });
      loadNotifier.notify();
      return startedStream!;
    } else {
      return (data!, stream!);
    }
    // return chapter!;
  }

  bool loaded() {
    return data != null;
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
    String? headerText = data?.header?.text;
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
      return data?.subtitle;
    } else if (data != null) {
      return data!.subtitle;
    } else {
      await startedStream;
      return data?.subtitle;
    }
  }

  Future<String?> awaitWhere() async {
    if (needsLoad) {
      await load();
      return data?.where;
    } else if (data != null) {
      return data!.where;
    } else {
      await startedStream;
      return data?.where;
    }
  }

  Future<String?> awaitWhen() async {
    if (needsLoad) {
      await load();
      return data?.when;
    } else if (data != null) {
      return data!.when;
    } else {
      await startedStream;
      return data?.when;
    }
  }
}

class ChapterProvider extends InheritedWidget {
  final Chapter? chapter;
  final Part part;

  const ChapterProvider(
      {required super.key,
      required this.chapter,
      required this.part,
      required super.child});

  @override
  // TODO: implement child
  Widget get child => Theme(data: part.theme, child: super.child);

  static ChapterProvider of(BuildContext context) {
    return maybeOf(context)!;
  }

  static ChapterProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChapterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is ChapterProvider) {
      return oldWidget.chapter?.id != chapter?.id;
    } else {
      return true;
    }
  }
}
