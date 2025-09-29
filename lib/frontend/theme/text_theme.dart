import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/parts/noir_theme.dart';

import 'base_text_theme.dart';

//TODO: Consider finding sans serif version of palatino
const appFontFamily = 'Palatino';

TextTheme textTheme = const TextTheme(
  //todo: try fontVariations: [FontVariation.width(1.5)]
  displayLarge: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 57,
      fontWeight: FontWeight.w700,
      color: appTextColor,
      height: 64 / 57),
  displayMedium: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 45,
      fontWeight: FontWeight.w600,
      color: appTextColor,
      height: 52 / 45),
  displaySmall: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: appTextColor,
      height: 44 / 36),
  headlineLarge: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: appTextColor,
      height: 40 / 32),
  headlineMedium: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: appTextColor,
      height: 36 / 28),
  headlineSmall: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: appTextColor,
      height: 32 / 24),
  titleLarge: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: appTextColor,
      height: 28 / 22),
  titleMedium: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: appTextColor,
      height: 24 / 16),
  titleSmall: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: appTextColor,
      height: 20 / 14),
  bodyLarge: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: appTextColor,
      height: 24 / 16),
  bodyMedium: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: appTextColor,
      height: 20 / 14),
  bodySmall: TextStyle(
      fontFamily: appFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w200,
      color: appTextColor,
      height: 16 / 12),
  labelLarge: TextStyle(
    fontFamily: appFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    color: labelTextColor,
  ),
  labelMedium: TextStyle(
    fontFamily: appFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    color: labelTextColor,
  ),
  labelSmall: TextStyle(
    fontFamily: appFontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    color: labelTextColor,
  ),
);

TextTheme bookTextTheme = const TextTheme(
  //todo: try fontVariations: [FontVariation.width(1.5)]
  displayLarge: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 57 * fontScale,
      fontWeight: FontWeight.w700,
      color: textColor,
      height: 64 / 57),
  displayMedium: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 45 * fontScale,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 52 / 45),
  displaySmall: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 36 * fontScale,
      fontWeight: FontWeight.w500,
      color: textColor,
      height: 44 / 36),
  headlineLarge: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 32 * fontScale,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 40 / 32),
  headlineMedium: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 28 * fontScale,
      fontWeight: FontWeight.w500,
      color: textColor,
      height: 36 / 28),
  headlineSmall: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 24 * fontScale,
      fontWeight: FontWeight.w400,
      color: textColor,
      height: 32 / 24),
  titleLarge: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 22 * fontScale,
      fontWeight: FontWeight.w400,
      color: textColor,
      height: 28 / 22),
  titleMedium: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 16 * fontScale,
      fontWeight: FontWeight.w300,
      color: textColor,
      height: 24 / 16),
  titleSmall: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 14 * fontScale,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 20 / 14),
  bodyLarge: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 16 * fontScale,
      fontWeight: FontWeight.w400,
      color: textColor,
      height: 24 / 16),
  bodyMedium: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 14 * fontScale,
      fontWeight: FontWeight.w300,
      color: textColor,
      height: 20 / 14),
  bodySmall: TextStyle(
      fontFamily: 'Palatino',
      fontStyle: FontStyle.italic,
      fontSize: 12 * fontScale,
      fontWeight: FontWeight.w200,
      color: textColor,
      height: 16 / 12),
  labelLarge: TextStyle(
    fontFamily: 'Palatino',
    // fontStyle: FontStyle.italic,
    fontSize: 14 * fontScale,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    color: labelTextColor,
  ),
  labelMedium: TextStyle(
    fontFamily: 'Palatino',
    fontStyle: FontStyle.italic,
    fontSize: 12 * fontScale,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    color: labelTextColor,
  ),
  labelSmall: TextStyle(
    fontFamily: 'Palatino',
    fontStyle: FontStyle.italic,
    fontSize: 11 * fontScale,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    color: labelTextColor,
  ),
);

//TODO: Move
final ThemeData bookTheme = noirTheme.copyWith(textTheme: bookTextTheme);

const TextStyle boldBodyFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w700,
);

const TextStyle italicBodyFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  color: textColor,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w300,
);

const TextStyle monoFont = TextStyle(
  fontFamily: 'Andale Mono',
  fontSize: 12 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w500,
);
const TextStyle siliconeValleyFont = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 24 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w500,
);
