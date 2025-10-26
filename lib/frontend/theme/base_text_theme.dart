import 'package:flutter/material.dart';

import 'font_family.dart';

const double fontScale = 1.5;
const double k = 12 * fontScale;

const double bookLetterSpacing = 1.1;

const TextStyle bodyFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  height: 1.5,
  letterSpacing: 1.05,
  color: Color(0xffffffff),
  fontWeight: FontWeight.w300,
  inherit: false,
);

TextStyle headerFont({required Color color, double fontSize = 24}) {
  return TextStyle(
    fontFamily: globalFontFamily,
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w500,
  );
}

TextStyle appFont(
    {required Color color,
    double fontSize = 12,
    fontWeight = FontWeight.w500}) {
  return TextStyle(
      fontFamily: globalFontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight);
}

TextStyle errorFont = const TextStyle(
  fontFamily: 'Source Code Mono',
  fontSize: 12,
  color: Color(0xffffffff),
  fontWeight: FontWeight.w600,
);
