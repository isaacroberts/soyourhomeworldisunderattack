import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_copy.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_game.dart';
import 'package:soyourhomeworld/frontend/theme/extra_colors.dart';

import '../../elements/holders/holder_base.dart';

const bool showOnDebug = true;

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

  @override
  String toText() {
    return '$titleText\n$authorText\n';
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //My CPU is STRUGGLING
    if (kDebugMode && !showOnDebug) {
      return SizedBox(
          width: size.width,
          height: size.height,
          child: const TitleFallbackWidget(
            key: Key('TitleLowCPU'),
          ));
    } else {
      //Standard Title & AUthor name
      return SplashBgWidget(
        width: size.width,
        height: size.height,
        key: const Key("SplashBGWidget"),
      );
    }
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
