import 'dart:convert';
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
  final int id;
  final List<String> urls;
  final String family;

  _LoadStatus _status;
  DynamicCachedFonts? cache;

  FontFile.err()
      : id = -1,
        urls = [],
        family = 'Null',
        _status = _LoadStatus.failed,
        cache = DynamicCachedFonts(url: 'null', fontFamily: 'Null');

  static Future<FontFile> fromId(int id) async {
    // var response;
    // try {
    //   var response = await sendGet('font_info/$id');
    // } catch (excep, trace) {
    //   ErrorList.showError(excep, trace);
    //   return FontFile.err();
    // }
    var response = await send('font_post_info', {'id': id});
    // dev.log("Sending for Font:$id");
    if (response.statusCode != 200) {
      dev.log("Font get error: $id");
      dev.log(response.body);

      throw FontException(
          'Font error code=${response.statusCode}: ${response.reasonPhrase}',
          family: null);
    } else {
      var data = json.decode(response.body);

      if (data == null) {
        throw FontException("Null Data from server.", family: id.toString());
      }
      dev.log('data: $data');
      List<dynamic>? files = data['file'];
      //Ensure they're all strings

      String? family = data['family'];
      dev.log("Font: [id]:$id [family]:$family [url]:$files");

      if (files == null || family == null) {
        throw FontException(
            "Null url/family received. family=$family url=$files",
            family: family);
      }
//Convert to strings
      List<String> urls =
          files.map((e) => e.toString()).toList(growable: false);
      //Convert to URLs
      for (int n = 0; n < files.length; ++n) {
        urls[n] = fontUrl(urls[n]);
      }
      // dev.log("Got font info: $url");
      return FontFile(id: id, urls: urls, family: family);
    }
  }

  FontFile.builtin({required this.id, required this.family})
      : _status = _LoadStatus.loaded,
        urls = const <String>[];

  //TODO: DynamicCachedFonts might not be useful because you're already loading them
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
  Future load() async {
    if (_status == _LoadStatus.unloaded) {
      _status = _LoadStatus.loading;
      dev.log("Loading font $id: $family");

      await cache?.load().then(_markLoaded, onError: _downloadError);
    }
    return null;
  }

  Future loadWithFuture() {
    dev.log("Loading font $id: $family");
    return cache!.load();
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
}

const Set<String> builtinFontFamilies = {'Palatino', 'Rubik'};

class FontCache {
//Singleton
  static FontCache? _instance;
  static FontCache getInstance() {
    _instance ??= FontCache();
    return _instance!;
  }

  Map<int, FontFile?> files;

//Constructor
  FontCache() : files = {};

  /*
  TODO: I think we still need to create a DynamicCachedFonts object for each fileId.
  Then we can store whether it's loaded, store the future, etc.
   */

  String? builtinFontFamilies(int id) {
    switch (id) {
      case 0:
        return 'Palatino';
      case 1:
        return 'Rubik';
    }
    return null;
  }

  bool needsFontFile(int id) {
    return (id != 0 && id != 1);
  }

  Future<FontFile?> getFontFile(int id) async {
    if (files.containsKey(id)) {
      if (files[id] == null) {
        // dev.log("(Font) FontFile name is null! $id");
        throw FontException("Null FontFile in FontCache", family: 'F$id');
      }
      return files[id];
    } else {
      if (needsFontFile(id)) {
        FontFile f = await FontFile.fromId(id);
        dev.log("(Font) Fetched name $id = ${f.family}");
        assert(f.id == id);
        files[id] = f;
        return f;
      } else {
        String? family = builtinFontFamilies(id);
        family!;
        FontFile f = FontFile.builtin(id: id, family: family);
        dev.log("(Font) Fetched builtin name $id= $family");
        assert(f.id == id);
        files[id] = f;
        return f;
      }
    }
  }

  Future<FontFile?> getAndLoadFontFile(int id) async {
    FontFile? file = await getFontFile(id);
    if (file == null) {
      return null;
    }
    await file.loadWithFuture();
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
