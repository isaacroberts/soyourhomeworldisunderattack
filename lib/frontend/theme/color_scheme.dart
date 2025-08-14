import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/colors.dart';

// //
ColorScheme get colorScheme => ColorScheme.fromSeed(
      seedColor: const Primary(),
      primary: const Primary(),
      secondary: const Secondary(),
      tertiary: const Tertiary(),

      onPrimary: Primary.shadef,
      onSecondary: Secondary.shadef,
      onTertiary: Colors.black,

      //Fixed: Middle between light/dark
      primaryFixed: Primary.shadea,
      secondaryFixed: Secondary.shadea,
      tertiaryFixed: Tertiary.shadea,
      //On Fixed
      onPrimaryFixed: Primary.shade5,
      onSecondaryFixed: Secondary.shade5,
      onTertiaryFixed: Tertiary.shade0,
      //FixedVariant: just an off version
      onPrimaryFixedVariant: Primary.shaded,
      onSecondaryFixedVariant: Secondary.shaded,
      onTertiaryFixedVariant: Tertiary.shade2,

      //Dims -  as in lighting
      primaryFixedDim: Primary.shade7,
      secondaryFixedDim: Secondary.shade7,
      tertiaryFixedDim: Tertiary.shade7,

      //BG
      surface: Primary.shade2,
      surfaceBright: Primary.shade7,
      surfaceDim: Primary.shade2,

      //Container shades
      surfaceContainerLowest: Primary.shade2,
      surfaceContainerLow: Primary.shade3,
      surfaceContainer: Primary.shade4,
      surfaceContainerHigh: Primary.shade5,
      surfaceContainerHighest: Primary.shade6,

      inversePrimary: Primary.shadec,
      inverseSurface: Primary.shadea,
      onInverseSurface: Primary.shade0,
      //Ons
      onSurface: Primary.shadef,

//Containers
      primaryContainer: Primary.shade7,
      secondaryContainer: Secondary.shade7,
      tertiaryContainer: Tertiary.shade7,

      //On Containers
      onPrimaryContainer: Primary.shade0,
      onSecondaryContainer: Secondary.shade0,
      onTertiaryContainer: Tertiary.shade0,

      //Outline
      outline: Primary.shadee,
      outlineVariant: Primary.shaded,
//Highlights
      surfaceTint: Primary.shadea,
      shadow: Primary.shade0,
      //Behind drawer
      scrim: Primary.shade1,

      //Error
      error: errorColor,
      onError: onError,
      errorContainer: errorBg,

      // secondary: const BrightPrimary(),
      // tertiary: planColor,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
      contrastLevel: 0,
    );

// ColorScheme get colorScheme => const ColorScheme.dark(
//       brightness: Brightness.dark,
//
//       //Mains
//       primary: Primary.shade5,
//       secondary: Secondary.shade9,
//       tertiary: Tertiary.shade5,
//       onPrimary: Primary.shadef,
//       onSecondary: Secondary.shadef,
//       onTertiary: Colors.black,
//
//       //Fixed: Middle between light/dark
//       primaryFixed: Primary.shadea,
//       secondaryFixed: Secondary.shadea,
//       tertiaryFixed: Tertiary.shadea,
//       //On Fixed
//       onPrimaryFixed: Primary.shade5,
//       onSecondaryFixed: Secondary.shade5,
//       onTertiaryFixed: Tertiary.shade0,
//       //FixedVariant: just an off version
//       onPrimaryFixedVariant: Primary.shaded,
//       onSecondaryFixedVariant: Secondary.shaded,
//       onTertiaryFixedVariant: Tertiary.shade2,
//
//       //Dims -  as in lighting
//       primaryFixedDim: Primary.shade7,
//       secondaryFixedDim: Secondary.shade7,
//       tertiaryFixedDim: Tertiary.shade7,
//
//       //BG
//       surface: Primary.shade2,
//       surfaceTint: Primary.shadea,
//       surfaceBright: Primary.shade7,
//       surfaceDim: Primary.shade1,
//
//       //Container shades
//       surfaceContainerLowest: Primary.shade2,
//       surfaceContainerLow: Primary.shade3,
//       surfaceContainer: Primary.shade4,
//       surfaceContainerHigh: Primary.shade5,
//       surfaceContainerHighest: Primary.shade6,
//
//       inversePrimary: Primary.shadec,
//       inverseSurface: Primary.shadea,
//       onInverseSurface: Primary.shade0,
//       //Ons
//       onSurface: Primary.shadef,
//
// //Containers
//       primaryContainer: Primary.shade7,
//       secondaryContainer: Secondary.shade7,
//       tertiaryContainer: Tertiary.shade7,
//
//       //On Containers
//       onPrimaryContainer: Primary.shade0,
//       onSecondaryContainer: Secondary.shade0,
//       onTertiaryContainer: Tertiary.shade0,
//
//       //Outline
//       outline: Primary.shadee,
//       outlineVariant: Primary.shaded,
// //Shadow
//       shadow: Primary.shade0,
//       //Behind drawer
//       scrim: Primary.shade1,
//
//       //Error
//       error: errorColor,
//       onError: onError,
//       errorContainer: errorBg,
//     );
//
// ColorScheme get colorScheme => ColorScheme.dark(
//     primary: harveyDarkColor,
//     secondary: planColor,
//
//     brightness: Brightness.dark,
//     // dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
//     // contrastLevel: 0,
//     surface: canvasColor);
