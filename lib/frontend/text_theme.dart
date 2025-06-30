import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import 'base_text_theme.dart';

TextTheme textTheme = const TextTheme(
  //todo: try fontVariations: [FontVariation.width(1.5)]
  displayLarge: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 57,
      fontWeight: FontWeight.w700,
      height: 64 / 57),
  displayMedium: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 45,
      fontWeight: FontWeight.w600,
      height: 52 / 45),
  displaySmall: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 36,
      fontWeight: FontWeight.w500,
      height: 44 / 36),
  headlineLarge: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 40 / 32),
  headlineMedium: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 28,
      fontWeight: FontWeight.w500,
      height: 36 / 28),
  headlineSmall: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 32 / 24),
  titleLarge: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 28 / 22),
  titleMedium: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 16,
      fontWeight: FontWeight.w300,
      height: 24 / 16),
  titleSmall: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 20 / 14),
  bodyLarge: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16),
  bodyMedium: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 14,
      fontWeight: FontWeight.w300,
      height: 20 / 14),
  bodySmall: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 12,
      fontWeight: FontWeight.w200,
      height: 16 / 12),
  labelLarge: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14),
  labelMedium: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12),
  labelSmall: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 16 / 11),
);

final ThemeData theme = ThemeData.from(
    colorScheme: colorScheme, useMaterial3: true, textTheme: textTheme);

// ), textTheme: GoogleFonts.rubikTextTheme(), useMaterial3: true);

TextTheme bookTextTheme = const TextTheme(
  //todo: try fontVariations: [FontVariation.width(1.5)]
  displayLarge: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 57,
      fontWeight: FontWeight.w700,
      height: 64 / 57),
  displayMedium: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 45,
      fontWeight: FontWeight.w600,
      height: 52 / 45),
  displaySmall: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 36,
      fontWeight: FontWeight.w500,
      height: 44 / 36),
  headlineLarge: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 40 / 32),
  headlineMedium: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 28,
      fontWeight: FontWeight.w500,
      height: 36 / 28),
  headlineSmall: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 32 / 24),
  titleLarge: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 28 / 22),
  titleMedium: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 16,
      fontWeight: FontWeight.w300,
      height: 24 / 16),
  titleSmall: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 20 / 14),
  bodyLarge: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16),
  bodyMedium: TextStyle(
      fontFamily: 'Palatino',
      fontSize: 14,
      fontWeight: FontWeight.w300,
      height: 20 / 14),
  bodySmall: TextStyle(
      fontFamily: 'Palatino',
      fontStyle: FontStyle.italic,
      fontSize: 12,
      fontWeight: FontWeight.w200,
      height: 16 / 12),
  labelLarge: TextStyle(
      fontFamily: 'Palatino',
      // fontStyle: FontStyle.italic,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14),
  labelMedium: TextStyle(
      fontFamily: 'Palatino',
      fontStyle: FontStyle.italic,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12),
  labelSmall: TextStyle(
      fontFamily: 'Palatino',
      fontStyle: FontStyle.italic,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 16 / 11),
);

final ThemeData bookTheme = ThemeData.from(
    colorScheme: colorScheme, useMaterial3: true, textTheme: bookTextTheme);

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

const TextStyle pollingMachineHeader = TextStyle(
  fontFamily: 'Andale Mono',
  fontSize: 12 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w700,
);

const TextStyle pollingMachineLabel = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w900,
);
const TextStyle pollingMachineBody = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w500,
);

//MK Ultra Witches
const TextStyle spookyErrorFont = TextStyle(
  fontFamily: 'Anonymous Pro',
  fontSize: 24 * fontScale,
  color: Color(0xb0000000),
  fontWeight: FontWeight.w800,
);
