import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/part_id.dart';
import 'package:soyourhomeworld/backend/server.dart';

//Deferred loads
import '../frontend/image/image_constants.dart';
import '../frontend/parts/part.dart';
import 'binary_utils/buffer_ptr.dart' deferred as buffer_lib;
import 'chapter_data.dart';
import 'chapter_info.dart';
import 'chapter_parser.dart' deferred as parser_lib;
import 'error_handler.dart';

class Chapter {
  /// This one stores the chapter, as a cache.
  /// ChapterInfo is more transient, and can be moved around
  ///

  final ChapterInfo info;

  ByteBuffer? binary;
  ChapterExtra? extra;

  ChapterData? data;
  Future<ChapterData>? startedStream;
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
    return 'Chp.$id:$varName;';
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

  Future<ChapterData?> load() {
    return getOrLoadChapter();
  }

  bool get needsLoad => data == null && !loading;
  bool get loading => startedStream != null || _loading;
  bool get showLoader => (data == null || (startedStream != null));
  bool _loading = false;
  bool _shouldCancelLoad = false;

  Future<ChapterData?> getOrLoadChapter() async {
    if (startedStream != null) {
      if (_shouldCancelLoad) {
        return null;
      } else {
        return startedStream;
      }
    } else if (data == null) {
      //If loading already marked
      if (_loading) {
        //If thread  cancelled

        if (_shouldCancelLoad) {
          return null;
        }
        //Continue loading, which will re-load the chapter object
        ErrorList.logWarning('Reloading chapter $varName');
      } else {
        _shouldCancelLoad = false;
      }

      _loading = true;
      String path = 'book_binary/${info.filename}';
      // dev.log("(ChapterHolder) Load: $path");
      binary ??= await getFileFromServer(path);
      //Check thread wasn't cancelled
      if (_shouldCancelLoad) {
        return null;
      }
      ByteData data = binary!.asByteData();

      //TODO: Move to defer wrapper
      await buffer_lib.loadLibrary();
      //Check thread wasn't cancelled
      if (_shouldCancelLoad) {
        return null;
      }
      await parser_lib.loadLibrary();
      //Check thread wasn't cancelled
      if (_shouldCancelLoad) {
        return null;
      }
      //Create objects
      var ptr = buffer_lib.BufferPtr(data.buffer);
      var parser = parser_lib.ChapterParser(debugId: info.varName, ptr: ptr);
//Save future

      //Check thread wasn't cancelled
      if (_shouldCancelLoad) {
        return null;
      }

      //TODO: This could crash since the header could get loaded twice
      extra ??= await parser.parseHeader();
      parser.skipToHeaderSeparator();

      //Check thread wasn't cancelled
      if (_shouldCancelLoad) {
        return null;
      }
      startedStream =
          parser.parseWithExistingChapterInfo(info, handleErrors: true);
//Set callback
      startedStream?.then((ChapterData c) {
        startedStream = null;
        binary = null;
        _loading = false;
        //Check thread wasn't cancelled
        if (!_shouldCancelLoad) {
          this.data = c;
          loadNotifier.notify();
        }
      });

      //Check thread wasn't cancelled
      if (!_shouldCancelLoad) {
        //Ring bell
        loadNotifier.notify();
        //Return stream
        return startedStream!;
      } else {
        return null;
      }
    } else {
      //Return already-created data
      return data!;
    }
  }

  Future<ChapterExtra> peekExtra() async {
    //Check thread wasn't cancelled
    if (extra != null) {
      return extra!;
    }
    String path = 'book_binary/${info.filename}';
    // dev.log("(ChapterHolder) Load: $path");
    binary ??= await getFileFromServer(path);
    ByteData data = binary!.asByteData();
    //TODO: Move to defer wrapper
    await buffer_lib.loadLibrary();
    await parser_lib.loadLibrary();
    //Create objects
    var ptr = buffer_lib.BufferPtr(data.buffer);
    var parser = parser_lib.ChapterParser(debugId: info.varName, ptr: ptr);
    extra = await parser.parseHeader();
    return extra!;
  }

  void cancelLoad() {
    _shouldCancelLoad = true;
  }

  bool needsDispose() {
    return data != null || _loading;
  }

  ///Experimental
  void unloadCompletely() async {
    //Cancel load thread
    _shouldCancelLoad = true;
    //Images won't unload until this is finished
    await startedStream;
    data?.disposeImages();
    data = null;
    //Cancel running stream for the worst case
    _loading = false;
    startedStream = null;
  }

  bool loaded() {
    return data != null;
  }

  String? get subtitle => extra?.subtitle;
  String? get where => extra?.where;
  String? get when => extra?.when;

  Color? getUniqueColor() {
    return data?.getFirstImage()?.colorHint?.foreColor;
  }

  ColorHint? getFirstColorHint() {
    return data?.getFirstImage()?.colorHint;
  }

  Future<String?> awaitSubtitle() async {
    ///Future for Subtitle. Technically might not return
    if (needsLoad) {
      await load();
      return extra?.subtitle;
    } else if (extra != null) {
      return extra!.subtitle;
    } else {
      await startedStream;
      return extra?.subtitle;
    }
  }

  Future<String?> awaitWhere() async {
    if (needsLoad) {
      await load();
      return extra?.where;
    } else if (extra != null) {
      return extra!.where;
    } else {
      await startedStream;
      return extra?.where;
    }
  }

  Future<String?> awaitWhen() async {
    if (needsLoad) {
      await load();
      return extra?.when;
    } else if (extra != null) {
      return extra!.when;
    } else {
      await startedStream;
      return extra?.when;
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

  ChapterProvider copyWith({required Widget child}) {
    return ChapterProvider(
        key: key, chapter: chapter, part: part, child: child);
  }

  // @override
  // Widget get child => super.child);

  static ChapterProvider of(BuildContext context) {
    return maybeOf(context)!;
  }

  static ChapterProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChapterProvider>();
  }

  static Part partOf(BuildContext context) {
    return ChapterProvider.of(context).part;
  }

  ///Part always has a value, even if Chapter doesn't, for fallback-ability
  static Part? partMaybeOf(BuildContext context) {
    return ChapterProvider.maybeOf(context)?.part;
  }

  static TextStyle bodyFontOf(BuildContext context) {
    return ChapterProvider.of(context).part.bodyFont;
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
