import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/holders/future_holder.dart';

import '../frontend/elements/holders/holder_base.dart';
import '../frontend/elements/holders/textholders.dart';
import 'chapter_info.dart';

//TODO: I think remove the ChangeNotifier, since that's on the Holder now
class ChapterExtra {
  final String? subtitle;
  final String? where;
  final String? when;
  final String? audioUrl;
  const ChapterExtra(
      {required this.subtitle,
      required this.where,
      required this.when,
      this.audioUrl});
}

class Chapter extends ChangeNotifier {
  /// Stores the spans themselves, and can notify listeners while unpacking
  ///
  final ChapterInfo info;
  final ChapterExtra extra;

  String? get subtitle => extra.subtitle;
  String? get where => extra.where;
  String? get when => extra.when;

  final List<Holder> lines = [];
  HeaderOfText? header; // = const HeaderOfText('Loading...');

  // ====  Ids ======
  String get key => info.id.toString();
  ChapterKey get id => info.id;
  String get varName => info.varName;
  String get displayTitle => info.displayName;
  String get filename => info.filename;
  ChapterKey? get nextId => info.next;

  // Constructors

  Chapter.fromChapterInfo(this.info, {required this.extra});

  Chapter.fromChapterInfoAndStream(this.info, Stream<Holder> stream,
      {required this.extra}) {
    stream.listen(_addHolderFromStream,
        onDone: postLoadCleanup,
        onError: addAndRegisterError,
        cancelOnError: false);
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

  static String readingLengthDescriptor(int n) {
    return "${n * 2}k chars";
  }

  int get readingLength {
    double x = getText().length.toDouble();
    x /= 2000;
    return x.ceil();
  }

  HeaderOfText get headerOrPlaceholder =>
      header ?? const HeaderOfText(text: 'Loading...');

  /* =========================================================================
                                 Loading
   ======================================================================== */

  // LoadStatus get loadStatus => _loadStatus;
  // bool get loaded => _loadStatus == LoadStatus.loaded;
  // bool get loading => _loadStatus == LoadStatus.loading;
  // bool get readyToShow => _loadStatus.readyToShow();
  // bool get notYetLoaded => _loadStatus.notStartedLoading();

  String get debugId => varName;
  ChapterKey get cacheKey => id;

  static ValueNotifier<bool> canLoad = ValueNotifier(true);

  void _addHolderFromStream(Holder h) {
    // int ix = lines.length;
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

  void postLoadCleanup() async {
    if (lines.isNotEmpty) {
      Holder? topElement = lines[0];
      if (topElement is HeaderOfText) {
        header = topElement;
        lines.removeAt(0);
      }
    }
    awaitFutures();
    notifyListeners();
  }

  void awaitFutures() async {
    for (int ix = 0; ix < lines.length; ++ix) {
      Holder holder = lines[ix];
      if (holder is FutureHolder) {
        try {
          Holder newHolder = await holder.holder;
          lines[ix] = newHolder;
        } catch (exception, trace) {
          ErrorList.logError(exception, trace);
        }
      }
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

  String getText() {
    /// All text in chapter.
    // All holders
    return lines
        .map((l) =>
            //Concatenate with line endings
            l.toText())
        .join('\n')
        //Cut out extra line endings/spaces
        .trim();
  }

  void copyText() {
    String str = getText();
    // str = str.trim();
    Clipboard.setData(ClipboardData(text: str));
  }
}

class ChapterLoadNotifier extends ChangeNotifier {
  void notify() {
    super.notifyListeners();
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
