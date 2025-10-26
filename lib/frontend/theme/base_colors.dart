import 'package:flutter/material.dart';

import '../parts/grand_swatch.dart';

class Tertiary extends GrandSwatch {
  const Tertiary();

  ///Reduced saturation, on- the BG
  static const Color shade0 = Color(0xff392707);
  //LibreOffice Background
  static const Color shade1 = Color(0xff42280a);
  static const Color shade2 = Color(0xff4e3612);
  static const Color shade3 = Color(0xff705104);
  static const Color shade4 = Color(0xff875b08);
  static const Color shade5 = Color(0xff8f660d);
  static const Color shade6 = Color(0xffc17c22);
  static const Color shade7 = Color(0xffbf7d26);
  static const Color shade8 = Color(0xffffa743);
  static const Color shade9 = Color(0xffffad5a);

  static const Color shadea = Color(0xffffa033);
  static const Color shadeb = Color(0xfffbb955);
  static const Color shadec = Color(0xffffb867);
  static const Color shaded = Color(0xfffad3a0);
  static const Color shadee = Color(0xffffeee2);
  static const Color shadef = Color(0xfffff5f0);

  //Boilerplate

  @override
  Color get s0 => shade0;
  @override
  Color get s1 => shade1;
  @override
  Color get s2 => shade2;
  @override
  Color get s3 => shade3;
  @override
  Color get s4 => shade4;
  @override
  Color get s5 => shade5;
  @override
  Color get s6 => shade6;
  @override
  Color get s7 => shade7;
  @override
  Color get s8 => shade8;
  @override
  Color get s9 => shade9;
  @override
  Color get sa => shadea;
  @override
  Color get sb => shadeb;
  @override
  Color get sc => shadec;
  @override
  Color get sd => shaded;
  @override
  Color get se => shadee;
  @override
  Color get sf => shadef;
}

//Ring of Power  color
const Color planColor = Color(0xfff09412);

// //Change these to PeterThiel
// const errorColor = Color(0xff7b6bff);
// const errorSecondary = Color(0xff5246ff);
// const errorHilite = Color(0xff7627ff);
// const errorBg = Color(0xff443d80);

const errorColor = Color(0xffff6811);
const errorMinor = Color(0xffffb789);

const onError = Color(0xff000000);
const errorBg = Color(0xff250c00);

// const MaterialColor primary = Primary();

const Brightness brightness = Brightness.dark;

const String fallbackFamily = "Palatino";
