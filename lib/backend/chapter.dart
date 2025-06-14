import 'dart:async';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/backend/server.dart';

import '../frontend/elements/holders/textholders.dart';
import 'binary_utils/buffer_ptr.dart';
import 'chapter_parser.dart';

typedef ChapterKey = int;

class ChapterInfo {
  /// Stores the information read from headers
  final ChapterKey id;
  final String displayName;
  final String filename;
  final String varName;
  final int? next;

  const ChapterInfo(
      {required this.id,
      required this.varName,
      required this.displayName,
      required this.filename,
      required this.next});

  // ChapterInfo.blank()
  //     : id = 0,
  //       varName = 'blank',
  //       displayName = '-',
  //       filename = '',
  //       next = null;
}

class Chapter extends ChangeNotifier {
  /// Stores the spans themselves, and can notify listeners while unpacking
  ///
  final ChapterInfo info;
  final List<Holder> lines = [];
  HeaderOfText? header; // = const HeaderOfText('Loading...');
  LoadStatus _loadStatus = LoadStatus.unloaded;

  // ====  Ids ======
  ChapterKey get id => info.id;
  String get varName => info.varName;
  String get displayTitle => info.displayName;
  String get filename => info.filename;
  ChapterKey? get nextId => info.next;

  // Constructors

  Chapter.fromChapterInfo(this.info);

  Chapter.fromChapterInfoAndStream(this.info, Stream<Holder> stream) {
    stream.listen(_addHolderFromStream,
        onDone: postLoadCleanup,
        onError: addAndRegisterError,
        cancelOnError: false);
  }

  // ==== Dev tool ====
//For testing elements without having to add them in the book
  void addGimme() {
    if (lines.length >= 4) {
      // lines.insert(4, NewHolder());
    }
  }

  /*  ================ Getters ===================  */

  Holder? operator [](int ix) {
    if (ix < lines.length) {
      return lines[ix];
    } else {
      return null;
    }
  }

  int get length => lines.length;

  bool get isEmpty => lines.length < 3;
  bool get isNotEmpty => lines.length >= 3;
  bool get isTitle => varName == 'Title';
  // ====  Info ======

  int get readingLength {
    var x = lines.length.toDouble();
    x /= 100;
    return x.ceil();
  }

  HeaderOfText get headerOrPlaceholder =>
      header ?? const HeaderOfText(text: 'Loading...');

  /* =========================================================================
                                 Loading
   ======================================================================== */

  LoadStatus get loadStatus => _loadStatus;
  bool get loaded => _loadStatus == LoadStatus.loaded;
  bool get loading => _loadStatus == LoadStatus.loading;
  bool get readyToShow => _loadStatus.readyToShow();
  bool get notYetLoaded => _loadStatus.notStartedLoading();

  String get debugId => varName;
  ChapterKey get cacheKey => id;

  static ValueNotifier<bool> canLoad = ValueNotifier(true);

  void _addHolderFromStream(Holder h) {
    lines.add(h);
    // notifyListeners();
  }

  //======== Errors =======================

  void addAndRegisterError(Object excep, [StackTrace? trace]) {
    dev.log('Exception: $excep');
    trace ??= StackTrace.current;

    dev.log(trace.toString());
    ExceptionHolder errorElem =
        ExceptionHolder(exception: excep, stackTrace: trace);
    lines.add(errorElem);
    ErrorList.logErrorHolder(errorElem);
  }

  void postLoadCleanup() {
    if (lines.isNotEmpty) {
      Holder? topElement = lines[0];
      if (topElement is HeaderOfText) {
        header = topElement;
        lines.removeAt(0);
      }
    }

    _loadStatus = LoadStatus.loaded;
    if (kDebugMode) {
      addGimme();
    }
    notifyListeners();
  }

  // ============ Handles =============

  void onTimeout() {
    dev.log("Timed out!");
    addAndRegisterError(
        TimeoutException("ChapterFormat read timed out $debugId"));
  }

  void handleLoadFailed() {
    dev.log("Load failed!");
    header ??= const HeaderOfText(text: '[Error]');
    if (lines.isEmpty) {
      lines.add(const BodyTextElement('[text]'));
    }
    // endWidget ??= EndOfChapterText(number);
  }

  void onFileReadError(object, StackTrace trace) {
    dev.log("FILE read ERROR");
    throw trace;
    // trace.toString()
  }

  void onFileReadDone() {
    dev.log('File read done.');
  }
}

class ChapterHolder {
  /// This one stores the chapter, as a cache.
  /// ChapterInfo is more transient, and can be moved around
  final ChapterInfo info;
  Chapter? chapter;

  // =Headers
  ChapterKey get id => info.id;
  String get varName => info.varName;
  String get displayName => info.displayName;
  String get filename => info.filename;
  ChapterKey? get next => info.next;

  ChapterHolder(this.info);

  static const String bookId = 'SoYourHomeworld';

  Future<Chapter> getOrLoadChapter() async {
    if (chapter == null) {
      String path = 'book_binary/${info.filename}';
      dev.log("LOad path: $path");
      ByteBuffer buffer = await getFileFromServer(path);
      ByteData data = buffer.asByteData();
      BufferPtr ptr = BufferPtr(data.buffer);
      ChapterParser parser = ChapterParser(debugId: info.varName, ptr: ptr);
      chapter =
          await parser.parseWithExistingChapterInfo(info, handleErrors: true);
    }
    return chapter!;
  }
}

enum LoadStatus {
  unloaded,
  loading,
  loaded,
  fileError,
  networkError,
  fmtError,
  codeError,
  unknownError,
  error;

  bool isError() {
    switch (this) {
      case LoadStatus.unloaded:
      case LoadStatus.loading:
      case LoadStatus.loaded:
        return false;
      case LoadStatus.error:
      case LoadStatus.fileError:
      case LoadStatus.networkError:
      case LoadStatus.fmtError:
      case LoadStatus.codeError:
      case LoadStatus.unknownError:
        return true;
    }
  }

  bool readyToShow() {
    return !(this == LoadStatus.unloaded);
  }

  bool notStartedLoading() {
    return (this == LoadStatus.unloaded);
  }
}
