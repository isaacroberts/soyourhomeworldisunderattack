import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/text_utils.dart';

import '../frontend/theme/base_colors.dart';
import '../frontend/theme/base_text_theme.dart';
import '../frontend/theme/font_family.dart';
import '../frontend/view_settings.dart';
import 'font_cache.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:soyourhomeworld/textholders.dart';

// You want an enum for font iDs

//Second enum for bold /ital

class FontInterm {
  final int fileId;
  final double size;
  // final bool? bold;
  // final bool italic;
  // final int? weight;
  bool get italic => wousi.italic;
  bool get strikethrough => wousi.strikethrough;
  bool get underline => wousi.underline;
  bool get overline => wousi.overline;

  final FontWeight weight;
  final WousiByte wousi;

  final Color? color;

  FontFile? _file;

  FontInterm(
      {required this.fileId,
      required this.size,
      required this.wousi,
      // required this.italic,
      // this.weight,
      this.color})
      : weight = FontCache.intToWeight(wousi.weight);

  @override
  String toString() {
    return "[id:$fileId size:$size weight:$weight ital:$italic]";
  }

  //FontFile ====================

  FontFile? get file {
    _file ??= FontCache.getInstance()
        .getFontFile(fileId, debugId: '(Sry, lost data)');
    return _file;
  }

  String? get family => file?.family;

  List<String>? get fileUrl => file?.urls;

  String loadStatus() =>
      file?.loadStatus() ?? (file == null ? "Null file" : 'Unfetched/Default');

  Future load({required String? debugId}) async {
    await file?.load(debugId: debugId);
    return file;
  }

  bool isLoaded() => file?.isLoaded() ?? false;

  bool isDoneLoading() => file?.doneLoading() ?? true;

  bool isFailed() => file?.failed() ?? false;

  TextStyle instance() {
    if (ViewSettings.instance.showFonts) {
      //Regular
      return TextStyle(
        fontFamily: family,
        fontSize: size * fontScale,
        fontWeight: weight,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        color: color ?? textColor,
        decoration: wousi.textDecoration(),
        decorationColor: color ?? textColor,
      );
    } else {
      //Fallback
      return TextStyle(
        fontFamily: fallbackFamily,
        fontSize: size * fontScale,
        fontWeight: weight,
        color: color ?? fallbackTextColor,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        decoration: wousi.textDecoration(),
        decorationColor: color ?? fallbackTextColor,
      );
    }
  }

  TextStyle instanceWithColor(Color? bgColor) {
    if (ViewSettings.instance.showFonts) {
      //Regular
      return TextStyle(
        fontFamily: family,
        fontSize: size * fontScale,
        fontWeight: weight,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        color: color ?? textColor,
        backgroundColor: bgColor,
        decoration: wousi.textDecoration(),
        decorationColor: color ?? textColor,
      );
    } else {
      //Fallback
      return TextStyle(
        fontSize: size * fontScale,
        fontWeight: weight,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        color: color ?? fallbackTextColor,
        fontFamily: globalBookFamily,
        backgroundColor: bgColor,
        decoration: wousi.textDecoration(),
        decorationColor: color ?? fallbackTextColor,
      );
    }
  }
}

class FontPremadeInterm {
  final TextStyle style;
  FontFile? _file;

  String get family => style.fontFamily!;

  FontPremadeInterm({required this.style}) : assert(style.fontFamily != null);

  FontFile? get file {
    _file ??= FontCache.getInstance().getFontFileFromFamily(family);
    return _file;
  }

  String loadStatus() =>
      file?.loadStatus() ?? (file == null ? "Null file" : 'Unfetched/Default');

  Future load({required String debugId}) async {
    await file!.load(debugId: debugId);
    return file!;
  }

  bool isLoaded() => file?.isLoaded() ?? false;

  bool isDoneLoading() => file?.doneLoading() ?? true;

  bool isFailed() => file?.failed() ?? false;
}
