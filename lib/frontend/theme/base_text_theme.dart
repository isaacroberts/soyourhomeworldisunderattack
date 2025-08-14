import 'package:flutter/material.dart';

import 'colors.dart';

const double fontScale = 2;

// const Color appTextColor = Color(0xffffffff);
// const Color textColor = Color(0xddffffff);
// const Color fallbackTextColor = Color(0xb2ffffff);
// const Color labelTextColor = Color(0x88ffffff);
const Color appTextColor = Primary.shaded;
const Color textColor = Primary.shadef;
const Color fallbackTextColor = Primary.shadee;
const Color labelTextColor = Primary.shadec;

const TextStyle bodyFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  height: 1.5,
  color: textColor,
  fontWeight: FontWeight.w300,
  inherit: false,
);

const TextStyle headerFont = TextStyle(
  fontFamily: 'Palatino',
  fontSize: 12 * fontScale,
  color: textColor,
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
