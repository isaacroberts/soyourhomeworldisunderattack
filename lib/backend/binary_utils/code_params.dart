import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:ui';

import '../case_insensitive_equality.dart';
import '../error_handler.dart';

class CodeParams {
  ///Stores CodeParams on mobile & modifiable object
  ///Main is also stored in the dict as 'main'
  final String? main;
  final Map<String, dynamic> dict;
  const CodeParams({this.main, this.dict = const {}});
  const CodeParams.dict(this.dict) : main = null;

  const CodeParams.empty()
      : main = null,
        dict = const {};

  void print() {
    dev.log("CodeParams: main=$main;\n\tdict = $dict");
  }

  dynamic operator [](String key) {
    //TODO: Key = key.lower()
    return dict[key];
  }

  T readParam<T>(String key, T defaultValue) {
    if (dict.containsKey(key)) {
      try {
        //I assume if this can't convert to type T it'll throw an error
        return dict[key];
      } catch (exception, trace) {
        ErrorList.logWarning(exception, trace);
      }
    }
    return defaultValue;
  }

  double? readDouble(String key) {
    var val = this[key];
    if (val == null) {
      return null;
    } else if (val is double) {
      return val;
    } else if (val is num) {
      return val.toDouble();
    } else if (val is String) {
      return double.tryParse(val);
    }
    //This probably crashes?
    return val;
  }

  int? readInt(String key) {
    var val = this[key];
    if (val == null) {
      return null;
    } else if (val is int) {
      return val;
    } else if (val is num) {
      return val.toInt();
    } else if (val is String) {
      return int.tryParse(val);
    }
    //This probably crashes?
    return val;
  }

  String? readString(String key) {
    return this[key]?.toString();
  }

  bool? readBool(String key) {
    var val = this[key];
    if (val is bool) {
      return val;
    }
    if (val is String) {
      //TODO: I don't know what this should be
      return val.toLowerCase() == 'true';
    }
    if (val is int) {
      return val > 0;
    }
    if (val is double) {
      return val > .5;
    }
    return val;
  }

  Color? _convertColor(String? hexString) {
    if (hexString == null) {
      return null;
    }
    if (hexString.length == 6) {
      hexString = 'ff$hexString';
    }
    int? hexInt = int.tryParse(hexString, radix: 16);
    if (hexInt == null) {
      ErrorList.logWarning(
          'Could not parse hex string: $hexString', StackTrace.current);
      return null;
    }

    return Color(hexInt);
  }

  Color? color(String key) {
    return _convertColor(dict[key].toString());
  }

  List<Color>? colorList(String key) {
    List<dynamic>? hexes = dict[key];
    if (hexes == null) {
      return null;
    }
    List<Color> colors = [];
    for (var hexString in hexes) {
      hexString = hexString.toString();
      Color? color = _convertColor(hexString);
      if (color != null) {
        colors.add(color);
      }
    }
    return colors;
  }

  String? readLink(String key) {
    //TODO: Sanitize or something
    String? link = this[key];
    if (link == null) {
      return null;
    }
    if (equalsIgnoreAsciiCase(link, 'null')) {
      return null;
    }
    return link;
  }

  static CodeParams fromJson(String jsonString) {
    Map<String, dynamic> params = jsonDecode(jsonString);
    String? main = params['main'];
    return CodeParams(main: main, dict: params);
  }
}
