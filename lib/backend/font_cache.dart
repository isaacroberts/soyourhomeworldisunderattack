import 'dart:developer' as dev;
import 'dart:ui';

import 'package:dynamic_cached_fonts/dynamic_cached_fonts.dart';
import 'package:soyourhomeworld/backend/server.dart';

import 'error_handler.dart';

enum _LoadStatus {
  unloaded,
  loading,
  loaded,
  failed;
}

class FontFile {
  ///Id within chapterFormat
  final int id;

  ///Urls of all weights & italic
  final List<String> urls;

  ///Family name, which is not stored in the ChapterFormat
  final String family;

  _LoadStatus _status;
  DynamicCachedFonts? cache;

  FontFile.err()
      : id = -1,
        urls = [],
        family = 'Null',
        _status = _LoadStatus.failed,
        cache = DynamicCachedFonts(url: 'null', fontFamily: 'Null');

  //TODO: DynamicCachedFonts might not be useful because you're already loading them
  //I think DynamicCachedFonts is just a cache system, and I'm using a small amount of code for that
  //I could move the variables in DynamicCachedFonts into this object.
  //Seeing as I'm already handling the caching
  FontFile({required this.id, required this.urls, required this.family})
      : cache = urls.length > 2
            ? DynamicCachedFonts.family(
                urls: urls,
                fontFamily: family,
                cacheStalePeriod: const Duration(days: 30))
            : DynamicCachedFonts(
                url: urls[0],
                fontFamily: family,
                cacheStalePeriod: const Duration(days: 30)),
        _status = _LoadStatus.unloaded;

  //API
  Future<bool> load() async {
    if (_status == _LoadStatus.unloaded) {
      _status = _LoadStatus.loading;
      // dev.log("Loading font $id: $family");

      await cache?.load().then(_markLoaded, onError: _downloadError);
      return true;
    }
    return false;
  }

  //Getters
  String loadStatus() => _status.name;
  bool isLoaded() => _status == _LoadStatus.loaded;
  bool doneLoading() {
    return _status == _LoadStatus.loaded || _status == _LoadStatus.failed;
  }

  bool failed() => _status == _LoadStatus.failed;

  //Callbacks
  void _markLoaded(Iterable<FileInfo> infos) {
    // FileInfo info = infos.first;
    // dev.log("Font load sxs: $family");
    _status = _LoadStatus.loaded;
  }

  void _downloadError(excep, trace) {
    ErrorList.showError(excep, trace);
    _status = _LoadStatus.failed;
  }

  @override
  String toString() {
    return '[Font: $id $family]';
  }
}

const Set<String> builtinFontFamilies = {'Palatino', 'Rubik'};

class FontCache {
//Singleton
  static FontCache? _instance;
  static FontCache getInstance() {
    _instance ??= FontCache();
    return _instance!;
  }

  final Map<int, FontFile?> files;

//Constructor
  FontCache() : files = {};

  Future<void> readFontTable() async {
    var data = await getJsonFileFromServer('/book_binary/font_files.json');

    // dev.log("Data: '$data'");
    if (data != null) {
      for (var font in data) {
        int id = font['i'];
        String family = font['f'];
        List<dynamic> rawUrls = font['l'];
        final String endpointUrl = '${getServerURL()}/hosted_fonts/';
        List<String> urls = rawUrls
            .map((e) => endpointUrl + e.toString())
            .toList(growable: false);
        files[id] = FontFile(id: id, urls: urls, family: family);
      }
    }
    // dev.log("Files: $files");
    return;
  }

  FontFile? getFontFile(int id) {
    if (files.containsKey(id)) {
      if (files[id] == null) {
        // dev.log("(Font) FontFile name is null! $id");
        throw FontException("Null FontFile in FontCache", family: 'F$id');
      }
      return files[id];
    }
    //Sry, no FontFile today
    return null;
  }

  FontFile? getFontFileFromFamily(String family) {
    for (FontFile? file in files.values) {
      if (file?.family == family) {
        return file;
      }
    }
    return null;
  }

  FontFile? getAndLoadFontFile(int id) {
    FontFile? file = getFontFile(id);
    if (file == null) {
      return null;
    }
    file.load();
    return file;
  }

  static FontWeight intToWeight(int? value) {
    if (value == null) {
      return FontWeight.w500;
    }
    if (value <= 100) {
      return FontWeight.w100;
    } else if (value <= 200) {
      return FontWeight.w200;
    } else if (value <= 300) {
      return FontWeight.w300;
    } else if (value <= 400) {
      return FontWeight.w400;
    } else if (value <= 500) {
      return FontWeight.w500;
    } else if (value <= 600) {
      return FontWeight.w600;
    } else if (value <= 700) {
      return FontWeight.w700;
    } else if (value <= 800) {
      return FontWeight.w800;
    } else if (value <= 1000) {
      return FontWeight.w900;
    } else {
      dev.log("Bad font weight. $value");
      return FontWeight.w500;
    }
  }
}
