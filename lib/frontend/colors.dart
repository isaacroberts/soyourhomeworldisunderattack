import 'package:flutter/material.dart';

const Color harveyDarkColor = Color(0xff17324f);
const Color harveyBrightColor = Color(0xff607d9c);

const Color rachelBrightColor = Color(0xff28c14c);
const Color rachelDarkColor = Color(0xff007d1c);

const Color peterThielColor = Color(0xff5b008a);

const Color fireOrangeColor = Color(0xfffc5006);

class HarveyColor extends MaterialColor {
  static const Color primary = harveyDarkColor;
  static const int primaryValue = 0xff17324f;
  static const Color shade1 = Color(0xff060e20);
  static const Color shade2 = Color(0xff060e20);
  static const Color shade3 = Color(0xff060e20);
  static const Color shade4 = Color(0xff17324f);
  static const Color shade5 = Color(0xff17324f);
  static const Color shade6 = Color(0xff17324f);
  static const Color shade7 = Color(0xff607d9c);
  static const Color shade8 = Color(0xff607d9c);
  static const Color shade9 = Color(0xff607d9c);
  static const Color shade10 = Color(0xffa2b5e4);

  static const swatches = <int, Color>{
    100: shade1,
    200: shade2,
    300: shade3,
    400: shade4,
    500: shade5,
    600: shade6,
    700: shade7,
    800: shade8,
    900: shade9,
    1000: shade10,
  };

  const HarveyColor() : super(primaryValue, swatches);
}
