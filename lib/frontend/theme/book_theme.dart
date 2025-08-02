import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

abstract class BookTheme {
  Color get primary;

  final ThemeData theme;

  final TextStyle bodyStyle;
  final TextStyle headerStyle;

  BookTheme(
      {required this.theme,
      required this.bodyStyle,
      required this.headerStyle});

  TextTheme generateTextTheme(String fontFamily) {
    return TextTheme(
      //todo: try fontVariations: [FontVariation.width(1.5)]
      displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 57,
          fontWeight: FontWeight.w700,
          color: textColor,
          height: 64 / 57),
      displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w600,
          color: textColor,
          height: 52 / 45),
      displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w500,
          color: textColor,
          height: 44 / 36),
      headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: textColor,
          height: 40 / 32),
      headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: textColor,
          height: 36 / 28),
      headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 32 / 24),
      titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 28 / 22),
      titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: textColor,
          height: 24 / 16),
      titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 20 / 14),
      bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 24 / 16),
      bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: textColor,
          height: 20 / 14),
      bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w200,
          color: textColor,
          height: 16 / 12),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        color: labelTextColor,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        color: labelTextColor,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 16 / 11,
        color: labelTextColor,
      ),
    );
  }
}
