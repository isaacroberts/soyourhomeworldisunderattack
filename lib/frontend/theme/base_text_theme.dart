import 'package:flutter/material.dart';

import '../parts/noir_colors.dart';
import 'font_family.dart';

const double fontScale = 1.5;
const double k = 12 * fontScale;
// const Color appTextColor = Color(0xffffffff);
// const Color textColor = Color(0xddffffff);
// const Color fallbackTextColor = Color(0xb2ffffff);
// const Color labelTextColor = Color(0x88ffffff);
//TODO: Remove all of these
const Color appTextColor = NoirPrimary.shaded;
const Color textColor = NoirPrimary.shadef;
const Color headerColor = NoirPrimary.shadee;
const Color fallbackTextColor = NoirPrimary.shadee;
const Color labelTextColor = NoirPrimary.shadec;

const double bookLetterSpacing = 1.1;

const TextStyle bodyFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  height: 1.5,
  letterSpacing: 1.05,
  color: textColor,
  fontWeight: FontWeight.w300,
  inherit: false,
);

const TextStyle headerFont = TextStyle(
  fontFamily: globalFontFamily,
  fontSize: 24,
  color: headerColor,
  fontWeight: FontWeight.w500,
);

const TextStyle appFont = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 12,
    color: appTextColor,
    fontWeight: FontWeight.w500);

const TextStyle appMonoFont = TextStyle(
    fontFamily: 'Roboto Mono',
    fontSize: 12,
    color: labelTextColor,
    fontWeight: FontWeight.w200);
