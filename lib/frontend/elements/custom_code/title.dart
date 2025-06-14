import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/splash_bg.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../holders/textholders.dart';

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
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          //Center
          mainAxisAlignment: MainAxisAlignment.center,
          //Left
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "So, your Homeworld's under Attack.",
              style: headerFont,
            ),
            Text("by Isaac Levin Roberts, PhD", style: bodyFont),
            SizedBox(
              height: 48,
            ),
          ],
        ));
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
            child: const Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              //Put author name at the bottom of the screen
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "So, your Home World's under Attack.",
                  textAlign: TextAlign.left,
                  style: headerFont,
                ),
                Text("by Isaac Levin Roberts, PhD",
                    textAlign: TextAlign.left, style: bodyFont),
              ],
            )));
  }
}
