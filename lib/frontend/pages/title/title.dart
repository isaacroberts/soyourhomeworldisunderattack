import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_copy.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_game.dart';

import '../../elements/holders/holder_base.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const McScaffold(
        source: 'home',
        child: TitleWidget(
          key: Key("title_Widget"),
        ));
  }
}

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
      );
    } else {
      //Standard Title & AUthor name
      return SplashBgWidget(
        width: size.width,
        height: size.height,
        key: const Key("SplashBGWidget"),
      );
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
          child: TitleTextPhone(key: const Key("titleTextPhone"), size: size));
    } else {
      //Standard Title & AUthor name
      return Container(
          color: harveyDarkColor,
          child: TitleTextWide(key: const Key("titleTextPhone"), size: size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }
}
