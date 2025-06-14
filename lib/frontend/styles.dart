import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';

//todo: wrap in static class & use typedef

// TextStyle bodyFont = GoogleFonts.rubik(
//     fontSize: 12, fontWeight: FontWeight.w300, color: textColor);
// TextStyle headerFont = GoogleFonts.rubik(
//     fontSize: 24, fontWeight: FontWeight.w900, color: textColor);

const Color boring0 = Color(0xff000001);
const Color boring1 = Color(0xff06060b);
const Color boring2 = Color(0xff121318);
const Color boring3 = Color(0xff23232c);
const Color boring4 = Color(0xff34343d);
const Color boring5 = Color(0xff484865);
const Color boring6 = Color(0xff505080);
const Color boring7 = Color(0xff707090);
const Color boring8 = Color(0xFF9090a0);
const Color boring9 = Color(0xffababc0);

const Color canvasColor = Color(0XFF060615);

const MaterialColor boringColor = MaterialColor(0xff484865, {
  100: boring0,
  200: boring1,
  300: boring2,
  400: boring3,
  500: boring4,
  600: boring5,
  700: boring6,
  800: boring7,
  900: boring8,
  1000: boring9
});

const Color textColor = Color(0xffbfbfbf);
const Color fallbackTextColor = textColor;

//Ring of Power  color
const Color planColor = Color(0xffff6811);

// const Color headerHilite = KevinColor.shade6;

//Change these to PeterThiel
const errorColor = Color(0xff7b6bff);
const errorSecondary = Color(0xff5246ff);
const errorHilite = Color(0xff7627ff);
const errorBg = Color(0xff443d80);

//I actually kind of don't like this
const MaterialColor primary = HarveyColor();

ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: harveyDarkColor,
    secondary: rachelDarkColor,
    brightness: Brightness.dark,
    surface: canvasColor);

const Brightness brightness = Brightness.dark;

/*
    TODO: Application text theme!
 */

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

const double fontScale = 2;

const TextStyle bodyFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  height: 1.5,
  color: textColor,
  fontWeight: FontWeight.w300,
  inherit: false,
);

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

const TextStyle headerFont = TextStyle(
  fontFamily: 'Rubik',
  fontSize: 24 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w700,
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

class TransparentWidgetColor extends WidgetStateColor {
  const TransparentWidgetColor() : super(0x00ffffff);

  @override
  Color resolve(Set<WidgetState> states) {
    return Colors.transparent;
  }
}
