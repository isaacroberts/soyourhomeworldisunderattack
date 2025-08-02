import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/text_theme.dart';

import 'button_state_property.dart';
import 'color_scheme.dart';

ThemeData get theme {
  return ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
    textTheme: textTheme,
  ).copyWith(
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24))),
              backgroundColor:
                  ButtonBackgroundColorProperty(colorScheme.onPrimaryContainer),
              textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
              foregroundColor:
                  WidgetStatePropertyAll(colorScheme.primaryContainer),
              overlayColor: ButtonOverlayColorProperty(
                  color: colorScheme.primary,
                  selectedColor: colorScheme.primary))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
            backgroundColor:
                ButtonBackgroundColorProperty(colorScheme.primaryContainer),
            textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
            foregroundColor:
                ButtonTextColorProperty(colorScheme.onPrimaryContainer),
            overlayColor: ButtonOverlayColorProperty(
                color: Color(0xffffffff),
                selectedColor: colorScheme.secondary)),
      ),
      cardTheme: CardThemeData(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          surfaceTintColor: colorScheme.secondary,
          shadowColor: const Color(0xff000000),
          // shadowColor: colorScheme.secondary,
          // surfaceTintColor: colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))));
}
// ), textTheme: GoogleFonts.rubikTextTheme(), useMaterial3: true);
