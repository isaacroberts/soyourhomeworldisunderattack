import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/splash_bg.dart';

import '../../base_text_theme.dart';
import '../holders/holder_base.dart';

const String titleText = "My Home Planet is under Attack!";
const String authorText = "by Joseph Silverstein";

class TitleHolder extends Holder {
  @override
  Widget element(BuildContext context) {
    return const TitleWidget();
  }

  @override
  Widget fallback(BuildContext context) {
    return const TitleFallbackWidget();
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  Widget builder(BuildContext context, BoxConstraints constraints) {
    Size size = MediaQuery.of(context).size;
    if (size.width < 600) {
      //Put author name at the bottom of the screen
      return SplashBgWidget(
          width: size.width,
          height: size.height,
          key: const Key("SplashBGWidget"),
          child: _TitleTextPhone(key: const Key("titleTextPhone"), size: size));
    } else {
      //Standard Title & AUthor name
      return SplashBgWidget(
          width: size.width,
          height: size.height,
          key: const Key("SplashBGWidget"),
          child: _TitleTextWide(key: const Key("titleTextPhone"), size: size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }
}

class TitleFallbackWidget extends StatelessWidget {
  const TitleFallbackWidget({super.key});

  Widget builder(BuildContext context, BoxConstraints constraints) {
    Size size = MediaQuery.of(context).size;
    if (size.width < 600) {
      //Put author name at the bottom of the screen
      return Container(
          color: harveyDarkColor,
          child: _TitleTextPhone(key: const Key("titleTextPhone"), size: size));
    } else {
      //Standard Title & AUthor name
      return Container(
          color: harveyDarkColor,
          child: _TitleTextWide(key: const Key("titleTextPhone"), size: size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }
}

class _TitleTextWide extends StatelessWidget {
  ///
  /// Standard Title & Author name
  /// Centered
  ///
  const _TitleTextWide({
    super.key,
    required this.size,
  });

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
              ],
            )));
  }
}

class _TitleTextPhone extends StatelessWidget {
  ///
  /// Put author name at the bottom of the screen
  ///
  const _TitleTextPhone({
    super.key,
    required this.size,
  });

  final Size size;

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
              ],
            )));
  }
}

TextStyle get titleFont => bodyFont.copyWith(fontVariations: [
      FontVariation.width(2000),
      // FontVariation.slant(60),
      // FontVariation.italic(100)
    ], color: textColor, fontSize: 48, fontWeight: FontWeight.w700);

TextStyle get authorFont => bodyFont.copyWith(
    color: textColor, fontWeight: FontWeight.w400, fontSize: 24);
