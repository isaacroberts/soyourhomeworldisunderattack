import 'package:flutter/material.dart';

import '../../base_text_theme.dart';

const String titleText = "Help! My Home Planet is under Attack!";
const String authorText = "by Joseph Silverstein";

class TitleTextWide extends StatelessWidget {
  ///
  /// Standard Title & Author name
  /// Centered
  ///
  ///
  final Widget? child;
  const TitleTextWide({super.key, required this.size, this.child});

  void onPressed() {}

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //Center
              mainAxisAlignment: MainAxisAlignment.end,
              //Left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: titleFont,
                ),
                Text(authorText, style: authorFont),
                const SizedBox(
                  height: 48,
                ),
                if (child != null) child!
              ],
            )));
  }
}

class TitleTextPhone extends StatelessWidget {
  ///
  /// Put author name at the bottom of the screen
  ///
  final Widget? child;
  const TitleTextPhone({
    super.key,
    required this.size,
    this.child,
  });

  final Size size;

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              //Put author name at the bottom of the screen
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(titleText, textAlign: TextAlign.left, style: titleFont),
                Text(authorText, textAlign: TextAlign.left, style: authorFont),
                if (child != null) child!
              ],
            )));
  }
}

TextStyle get titleFont => bodyFont.copyWith(
    color: textColor, fontSize: 48, fontWeight: FontWeight.w700);

TextStyle get authorFont => bodyFont.copyWith(
    color: textColor, fontWeight: FontWeight.w400, fontSize: 24);
