import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/backend/part_id.dart';
import 'package:soyourhomeworld/frontend/elements/holders/future_holder.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';

import '../frontend/elements/holders/holder_base.dart';
import '../frontend/elements/holders/textholders.dart';
import '../frontend/image/base_image_holder.dart';
import '../frontend/image/image_holder.dart';
import 'chapter_info.dart';

class ChapterExtra {
  final String? subtitle;
  final String? where;
  final String? when;
  final String? recap, contentWarning, what;
  final String? audioUrl;
  const ChapterExtra(
      {this.subtitle,
      this.where,
      this.when,
      this.recap,
      this.contentWarning,
      this.what,
      this.audioUrl});

  const ChapterExtra.title()
      : contentWarning = null,
        subtitle = 'Loyally and without hesitation',
        where = 'Earth',
        when = '2025',
        recap = 'Donald Trump is destroying the US Planet',
        audioUrl = null,
        what = null;

  const ChapterExtra.fromNull({String? showErr})
      : contentWarning = showErr,
        subtitle = null,
        where = null,
        when = null,
        recap = null,
        what = null,
        audioUrl = null;

  bool get hasAnyChips {
    return subtitle != null ||
        where != null ||
        when != null ||
        recap != null ||
        contentWarning != null;
  }

  static ChapterExtra fromJson(data) {
    if (data == null) {
      //Normal - some chapters don't have data
      return const ChapterExtra.fromNull();
    }

    return ChapterExtra(
        subtitle: data['Subtitle'],
        where: data['Where'],
        when: data['When'],
        recap: data['Recap'],
        what: data['What'],
        contentWarning: data['CW']);
  }
}

class ChapterData {
  /// Stores the spans themselves, and can notify listeners while unpacking
  ///
  final ChapterInfo info;

  Stream<Holder>? stream;

  final List<Holder> lines = [];
  //TODO: We're not using the header
  HeaderOfText? header; // = const HeaderOfText('Loading...');

  // ====  Ids ======
  String get key => info.id.toString();
  ChapterKey get id => info.id;
  String get varName => info.varName;
  String get displayTitle => info.displayName;
  String get filename => info.filename;
  ChapterKey? get nextId => info.next;

  // Constructors

  ChapterData.fromChapterInfoAndStream(this.info, this.stream) {
    stream!.listen(_addHolderFromStream,
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

  ///Used for rounding up images for display & dipose
  Iterable<StdImageHolder> getImages() sync* {
    sweepForFutures();
    for (Holder holder in lines) {
      if (holder is StdImageHolder) {
        yield holder;
      }
    }
  }

  ///First image, for summaries
  ImageHolder? getFirstImage() {
    sweepForFutures();
    dev.log("First image: (${lines.length} lines)");
    for (Holder holder in lines) {
      if (holder is ImageHolder) {
        dev.log("\t$holder");
        return holder;
      }
    }
    return null;
  }

  void sweepForFutures() {
    for (int ix = 0; ix < lines.length; ++ix) {
      Holder holder = lines[ix];
      if (holder is FutureHolder) {
        if (holder.resolvedHolder != null) {
          //Remove Future wrapper
          lines[ix] = holder.resolvedHolder!;
        }
      }
    }
  }

  bool hasCodeSpan() {
    for (int ix = 0; ix < lines.length; ++ix) {
      Holder holder = lines[ix];
      if (holder is CodeHolder) {
        return true;
      }
    }
    return false;
  }

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
    lines.add(h);
  }

  //======== Errors =======================

  void addAndRegisterError(Object exception, [StackTrace? trace]) {
    dev.log('Exception: $exception');
    trace ??= StackTrace.current;

    dev.log(trace.toString());
    ExceptionHolder errorElem =
        ExceptionHolder(exception: exception, stackTrace: trace);
    lines.add(errorElem);
    ErrorList.logErrorHolder(errorElem);
  }

  //TODO: Move elsewhere
  Color? getColorToSweepFor(PartId part) {
    //TODO: Put this on the part objects, so we can tell when the object's switched out.
    switch (part) {
      case PartId.noir:
        //Already matches page background
        return null;
      case PartId.greenland:
      case PartId.redemption:
      case PartId.revolution:
        //Bring me Joseph Silverstein
        return const Color(0xffffffff);
    }
  }

  Future<void> sweepForColors() async {
    //TODO: Do this on the python_writer later
    //Can't do it there now, because I'm constantly turning the colorSwitching on and off.

    //Page background
    Color? colorToSweepFor = getColorToSweepFor(info.partId);
    if (colorToSweepFor != null) {
      //TODO: Await part loading
      Color repl = getPartImmediate(info.partId).textColor;
      for (Holder line in lines) {
        //Sets the color to null
        //This is why the Holders don't have const constructors
        line.sweepForColor(colorToSweepFor, repl);
      }
    }
  }

  void postLoadCleanup() async {
    sweepForFutures();

    await sweepForColors();

    if (lines.isNotEmpty) {
      Holder? topElement = lines[0];
      if (topElement is HeaderOfText) {
        header = topElement;
        lines.removeAt(0);
      }
    }
    stream = null;
  }

  ///Preload
  void cacheImages(BuildContext context) {
    sweepForFutures();
    for (StdImageHolder image in getImages()) {
      image.cacheImage(context);
    }
  }

  ///Save memory
  void disposeImages() {
    sweepForFutures();
    for (StdImageHolder image in getImages()) {
      image.dispose();
    }
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

    // notifyListeners();
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
