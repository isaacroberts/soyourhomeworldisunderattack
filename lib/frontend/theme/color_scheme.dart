import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/styles.dart';

import 'extra_colors.dart';

//
ColorScheme get colorScheme => ColorScheme.fromSeed(
    seedColor: harveyDarkColor,
    secondary: rachelDarkColor,
    tertiary: planColor,
    brightness: Brightness.dark,
    dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
    contrastLevel: 0,
    surface: canvasColor);
//
// ColorScheme get colorScheme => ColorScheme.dark(
//     primary: harveyDarkColor,
//     secondary: planColor,
//
//     brightness: Brightness.dark,
//     // dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
//     // contrastLevel: 0,
//     surface: canvasColor);
