import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/title/bg_container.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_copy.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_game.dart';
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';
import 'package:soyourhomeworld/frontend/theme/extra_colors.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../components/fadein.dart';
import '../../elements/chapter_heading/sliver_header.dart';
import '../../elements/holders/holder_base.dart';
import '../../parts/part.dart';

const bool showOnDebug = false;

class TitlePage extends StatelessWidget {
  const TitlePage({required super.key});

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
  final double shrinkHeight;
  const TitleWidget({super.key, this.shrinkHeight = 0});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    size = Size(size.width, size.height - shrinkHeight);
//Noir image instead of custom art
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageUrl('noir_gun_shadows.jpg')),
              fit: BoxFit.cover,
              alignment: const Alignment(-.4, 0))),
      child: FlameWidget(
          key: const Key('title'), width: size.width, height: size.height),
    );

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

      Widget flames = FlameWidget(
        width: size.width,
        height: size.height,
        key: const Key("FireWidget"),
      );
      Widget bg = SplashBgWidget(
          key: const Key("BgWidget"), width: size.width, height: size.height);
      flames = FadeIn(
          key: const Key('fadeIn'),
          delay: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 500),
          child: flames);

      return Stack(
        key: const Key("titleStack"),
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [bg, flames],
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

class TitleSliver extends StatelessWidget {
  const TitleSliver({required super.key});

  @override
  Widget build(BuildContext context) {
    Chapter chapter = Book.of(context).chapters[0];
    Part partData = const PartNoir();
    return ChapterProvider(
        key: Key("Chp${chapter.key}"),
        chapter: chapter,
        part: partData,
        child: const SliverMainAxisGroup(slivers: [
          SliverHeader(key: Key("Header")),
          SliverToBoxAdapter(
            key: Key('titleWidgStba'),
            child: TitleWidget(
              key: Key('title'),
              shrinkHeight: 120,
            ),
          )
        ]));
  }
}
