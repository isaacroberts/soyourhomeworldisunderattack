import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/text_utils.dart';

import '../frontend/theme/base_text_theme.dart';
import '../frontend/theme/colors.dart';
import 'font_cache.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:soyourhomeworld/textholders.dart';

// You want an enum for font iDs

//Second enum for bold /ital

class FontInterm {
  // final String family;
  final int fileId;
  final double size;
  // final bool? bold;
  // final bool italic;
  // final int? weight;
  bool get italic => wousi.italic;
  bool get strikethrough => wousi.strikethrough;
  bool get underline => wousi.underline;
  bool get overline => wousi.overline;
  int get weight => wousi.weight;
  final WousiByte wousi;

  final Color? color;

  FontFile? file;

  //TODO: Save fontCache object
  // FontFile? fontCache;

  FontInterm(
      {required this.fileId,
      required this.size,
      required this.wousi,
      // required this.italic,
      // this.weight,
      this.color});

  @override
  String toString() {
    return "[id:$fileId size:$size weight:$weight ital:$italic]";
  }

  //FontFile ====================

  String? get family => file?.family;

  List<String>? get fileUrl => file?.urls;

  String loadStatus() =>
      file?.loadStatus() ?? (file == null ? "Null file" : 'Unfetched/Default');

  Future load() async {
    file ??= await getFontFile();
    await file?.load();
    return file;
  }

  bool isLoaded() => file?.isLoaded() ?? false;

  bool isDoneLoading() => file?.doneLoading() ?? true;

  bool isFailed() => file?.failed() ?? false;

  FontWeight? get fontWeight {
    if (fileId == 0) {
      return FontCache.intToWeight(weight - 100);
    } else {
      return FontCache.intToWeight(weight);
    }
  }

  TextStyle instance() {
    return TextStyle(
      fontFamily: family,
      fontSize: size * fontScale,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? textColor,
      decoration: wousi.textDecoration(),
      decorationColor: color ?? textColor,
    );
  }

  TextStyle fallback() {
    return TextStyle(
      fontFamily: fallbackFamily,
      fontSize: size * fontScale,
      fontWeight: fontWeight,
      color: color ?? fallbackTextColor,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      decoration: wousi.textDecoration(),
      decorationColor: color ?? fallbackTextColor,
    );
  }

  TextStyle instanceWithColor(Color? bgColor) {
    return TextStyle(
      fontFamily: family,
      fontSize: size * fontScale,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? textColor,
      backgroundColor: bgColor,
      decoration: wousi.textDecoration(),
      decorationColor: color ?? textColor,
    );
  }

  TextStyle fallbackWithColor(Color? bgColor) {
    return TextStyle(
      fontSize: size * fontScale,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color ?? fallbackTextColor,
      fontFamily: 'Rubik',
      backgroundColor: bgColor,
      decoration: wousi.textDecoration(),
      decorationColor: color ?? fallbackTextColor,
    );
  }

  //==== Internals ============

  //TODO: Save this Future I think
  Future<FontFile?> getFontFile() async {
    if (file == null) {
      return FontCache.getInstance().getFontFile(fileId);
    }
    return file;
  }
}

class FontPremadeInterm {
  final TextStyle style;
  FontFile? file;

  String get family => style.fontFamily!;

  FontPremadeInterm({required this.style}) : assert(style.fontFamily != null);

  String loadStatus() =>
      file?.loadStatus() ?? (file == null ? "Null file" : 'Unfetched/Default');

  Future load() async {
    file ??= await getFontFile();
    await file!.load();
    return file!;
  }

  bool isLoaded() => file?.isLoaded() ?? false;

  bool isDoneLoading() => file?.doneLoading() ?? true;

  bool isFailed() => file?.failed() ?? false;

  //TODO: Save this Future I think
  Future<FontFile?> getFontFile() async {
    if (file == null) {
      return FontCache.getInstance().getFontFileFromFamily(family);
    }
    return file;
  }
}
