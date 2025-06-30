import 'package:flutter/material.dart';

const double fontScale = 2;
const Color textColor = Color(0xffbfbfbf);
const Color fallbackTextColor = textColor;

const TextStyle bodyFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  height: 1.5,
  color: textColor,
  fontWeight: FontWeight.w300,
  inherit: false,
);

const TextStyle headerFont = TextStyle(
  fontFamily: 'Rubik',
  fontSize: 24 * fontScale,
  color: textColor,
  fontWeight: FontWeight.w800,
);

const TextStyle appFont =
    TextStyle(fontFamily: 'Rubik', fontSize: 12, fontWeight: FontWeight.w500);

const TextStyle appMonoFont = TextStyle(
    fontFamily: 'Roboto Mono', fontSize: 12, fontWeight: FontWeight.w200);
