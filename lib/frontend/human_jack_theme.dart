import 'package:flutter/material.dart';

import 'styles.dart';

const Color humanJack0 = Color(0xff001f33);
const Color humanJack1 = Color(0xff052f45);
const Color humanJack2 = Color(0xff114466);
const Color humanJack3 = Color(0xff1177aa);
const Color humanJack4 = Color(0xff1188cc);
const Color humanJack5 = Color(0xff11aaff);
const Color humanJack6 = Color(0xff22ccff);
const Color humanJack7 = Color(0xff55faff);
const Color humanJack8 = Color(0xff99ffff);
const Color humanJack9 = Color(0xffccffff);

const MaterialColor humanJackColor = MaterialColor(0xff1188cc, {
  100: humanJack0,
  200: humanJack1,
  300: humanJack2,
  400: humanJack3,
  500: humanJack4,
  600: humanJack5,
  700: humanJack6,
  800: humanJack7,
  900: humanJack8,
  1000: humanJack9
});

const TextStyle humanJackBody = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12,
  color: textColor,
  fontWeight: FontWeight.w200,
);

const TextStyle humanJackDisplay = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 18,
  color: humanJackColor,
  fontWeight: FontWeight.w700,
);

const TextStyle humanJackHeader = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 24,
  color: textColor,
  fontWeight: FontWeight.w500,
);

const TextStyle humanJackLabel = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12,
  color: textColor,
  fontWeight: FontWeight.w200,
);

TextTheme humanJackTextTheme = TextTheme(
  bodyLarge: humanJackBody.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
  bodyMedium: humanJackBody.copyWith(fontSize: 12, fontWeight: FontWeight.w300),
  bodySmall: humanJackBody.copyWith(fontSize: 12, fontWeight: FontWeight.w200),
  displayLarge:
      humanJackDisplay.copyWith(fontSize: 32, fontWeight: FontWeight.w500),
  displayMedium:
      humanJackDisplay.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
  displaySmall:
      humanJackDisplay.copyWith(fontSize: 16, fontWeight: FontWeight.w200),
  headlineLarge:
      humanJackHeader.copyWith(fontSize: 36, fontWeight: FontWeight.w700),
  headlineMedium:
      humanJackHeader.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
  headlineSmall:
      humanJackHeader.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
  titleLarge:
      humanJackHeader.copyWith(fontSize: 36, fontWeight: FontWeight.w900),
  titleMedium: humanJackHeader.copyWith(fontSize: 24),
  titleSmall:
      humanJackHeader.copyWith(fontSize: 18, fontWeight: FontWeight.w300),
  labelLarge:
      humanJackLabel.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
  labelMedium:
      humanJackLabel.copyWith(fontSize: 12, fontWeight: FontWeight.w300),
  labelSmall: humanJackLabel.copyWith(fontSize: 6, fontWeight: FontWeight.w200),
);

ThemeData humanJackTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
        seedColor: humanJackColor, brightness: Brightness.light),
    textTheme: humanJackTextTheme);
