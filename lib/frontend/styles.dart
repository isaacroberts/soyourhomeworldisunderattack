import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';

//todo: wrap in static class & use typedef

// TextStyle bodyFont = GoogleFonts.rubik(
//     fontSize: 12, fontWeight: FontWeight.w300, color: textColor);
// TextStyle headerFont = GoogleFonts.rubik(
//     fontSize: 24, fontWeight: FontWeight.w900, color: textColor);

const Color canvasColor = Color(0xFF060615);

const String fallbackFamily = "Palatino";

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
