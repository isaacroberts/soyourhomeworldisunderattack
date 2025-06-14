import 'package:flutter/material.dart';

import '../frontend/styles.dart';
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
  final bool italic;
  final int? weight;
  final Color? color;

  FontFile? file;

  //TODO: Save fontCache object
  // FontFile? fontCache;

  FontInterm(
      {required this.fileId,
      required this.size,
      required this.italic,
      this.weight,
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
    await file!.load();
    return file!;
  }

  bool isLoaded() => file?.isLoaded() ?? false;

  bool isDoneLoading() => file?.doneLoading() ?? true;

  bool isFailed() => file?.failed() ?? false;

  TextStyle instance() {
    // dev.log("Color=$color");
    return TextStyle(
        fontSize: size * fontScale,
        fontWeight: FontCache.intToWeight(weight),
        color: color ?? textColor,
        fontFamily: family);
  }

  TextStyle fallback() {
    return TextStyle(
        fontSize: size * fontScale,
        fontWeight: FontCache.intToWeight(weight),
        color: color ?? fallbackTextColor,
        fontFamily: 'Palatino');
  }

  TextStyle instanceWithColor(Color bgColor) {
    return TextStyle(
        fontSize: size * fontScale,
        fontWeight: FontCache.intToWeight(weight),
        color: color ?? textColor,
        fontFamily: family,
        backgroundColor: bgColor);
  }

  TextStyle fallbackWithColor(Color bgColor) {
    return TextStyle(
        fontSize: size * fontScale,
        fontWeight: FontCache.intToWeight(weight),
        color: color ?? fallbackTextColor,
        fontFamily: 'Rubik',
        backgroundColor: bgColor);
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
