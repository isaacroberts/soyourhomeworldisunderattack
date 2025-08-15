import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/text_theme.dart';

import 'base_text_theme.dart';
import 'color_scheme.dart';
import 'colors.dart';

ThemeData get theme {
  return ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
    textTheme: textTheme,
  ).copyWith(
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ButtonStyle(
    //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(24))),
    //         backgroundColor:
    //             ButtonBackgroundColorProperty(colorScheme.onPrimaryContainer),
    //         textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
    //         foregroundColor: WidgetStatePropertyAll(Primary.shadec),
    //         overlayColor: ButtonOverlayColorProperty(
    //             color: colorScheme.primary,
    //             selectedColor: colorScheme.primary))),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ButtonStyle(
    //       shape: WidgetStatePropertyAll(RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(24))),
    //       backgroundColor:
    //           ButtonBackgroundColorProperty(colorScheme.primaryContainer),
    //       textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
    //       foregroundColor:
    //           ButtonTextColorProperty(colorScheme.onPrimaryContainer),
    //       overlayColor: ButtonOverlayColorProperty(
    //           color: Color(0xffffffff),
    //           selectedColor: colorScheme.secondary)),
    // ),
    cardTheme: CardThemeData(
        color: colorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        surfaceTintColor: colorScheme.secondary,
        shadowColor: const Color(0xff000000),
        // shadowColor: colorScheme.secondary,
        // surfaceTintColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
    tooltipTheme: TooltipThemeData(
      textStyle: appFont,
      //Haptics seem like too much for an e-Reader
      enableFeedback: false,
      triggerMode: TooltipTriggerMode.longPress,
      waitDuration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
      decoration: BoxDecoration(
          color: Primary.shade4,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1.5, color: canvasFade)),
    ),
    drawerTheme: DrawerThemeData(
        elevation: 5,
        backgroundColor: Secondary.shade7,
        scrimColor: Secondary.shade1.withAlpha(128),
        surfaceTintColor: Secondary.shade1,
        shadowColor: Secondary.shade0),
    // chipTheme: ChipThemeData(
    //   shape:
    // )
  );
}
// ), textTheme: GoogleFonts.rubikTextTheme(), useMaterial3: true);
