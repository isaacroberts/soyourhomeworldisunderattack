import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_copy.dart';
import 'package:soyourhomeworld/frontend/pages/title/water_painter.dart';
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';
import 'package:soyourhomeworld/frontend/theme/extra_colors.dart';

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../chapter_heading/sliver_header.dart';
import '../../elements/holders/holder_base.dart';
import '../../parts/part.dart';

const bool showOnDebug = true;

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
  Widget sliver(BuildContext context) {
    return const SliverToBoxAdapter(
      child: TitleWidget(),
    );
  }

  @override
  Widget debugSliver(BuildContext context) {
    //For speed, don't show TitleWidget
    double height = MediaQuery.sizeOf(context).height - 60;
    return DecoratedSliver(
        decoration: const BoxDecoration(color: Color(0xff113388)),
        sliver: SliverPadding(padding: EdgeInsets.only(bottom: height)));
  }

  @override
  String toText() {
    return '$titleText\n$authorText\n';
  }

  //No free labor, king.
  @override
  void sweepForColor(Color find, Color? repl) {}
}

class TitleWidget extends StatefulWidget {
  final double shrinkHeight;

  const TitleWidget({super.key, this.shrinkHeight = 0});
  @override
  State<StatefulWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final AnimationController shaderAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        debugLabel: 'TitleAnim',
        // animationBehavior: AnimationBehavior.preserve,
        // upperBound: 1,
        vsync: this);
    shaderAnimation = AnimationController(
        vsync: this, debugLabel: 'ShaderAnim', upperBound: 10);
    int minutes = 15;
    animationController.animateTo(minutes.toDouble(),
        duration: const Duration(seconds: 6));
    shaderAnimation.animateTo(minutes.toDouble(),
        duration: Duration(minutes: minutes));
    loadFragWaterShader();
  }

  @override
  void dispose() {
    animationController.dispose();
    shaderAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    size = Size(size.width, size.height - widget.shrinkHeight);
//Noir image instead of custom art

    return SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          fit: StackFit.expand,
          // alignment: Alignment.center,
          children: [
            // SmokeBg(key: Key('smoke'), width: size.width, height: size.height),
            // Container(
            //   color: NoirPrimary.shade2,
            //   child: const SizedBox.expand(),
            // ),

            if (!kDebugMode || showOnDebug)
              WaterWrap(key: const Key('water'), animation: shaderAnimation),

            // CustomPaint(
            //     key: const Key('waterStatic'),
            //     size: size,
            //     willChange: false,
            //     painter: WaterPainter(anim: 0)),
            // PainterWrapper(
            //     key: const Key('waterP'),
            //     animStart: 0,
            //     animationLength: 1,
            //     painter: (d) => WaterPainter(anim: d),
            //     size: size,
            //     animation: shaderAnimation,
            //     isComplex: true,
            //     needsClip: false),

            // const DukeLogo(
            //   key: Key('dukeLogo'),
            // ),

            // FlameWidget(
            //     key: const Key('title'),
            //     width: size.width,
            //     height: size.height),
            // FadingTitle(
            //     key: const Key('fadingTitle'),
            //     animationController: animationController),
            // const Align(
            //     alignment: Alignment.topLeft,
            //     child: TitleTextPhone(
            //       key: Key('ttp'),
            //       size: Size(100, 200),
            //     )),
            if (animationController.isCompleted)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: IconButton(
                      icon: const Icon(
                        Icons.replay,
                        color: Color(0x88ffffff),
                        size: 24,
                      ),
                      onPressed: onReset,
                    )),
              )
          ],
        ));
  }

  ///Callback for resetting animation
  void onReset() {
    animationController.reset();
  }
}

class FadingTitle extends StatelessWidget {
  const FadingTitle({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget child = size.width < 600
        ? TitleTextPhone(key: const Key('TitlePhone}'), size: size, child: null)
        : TitleTextWide(key: const Key('TitleWide'), size: size, child: null);
    return child;
    return FadeTransition(
        key: const Key('fadeIn'),
        opacity: TweenSequence<double>([
          TweenSequenceItem(
              tween: Tween<double>(begin: 0.0, end: 1.0), weight: 1),
          TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 10)
        ]).animate(animationController),
        child: child);
  }
}

class DukeLogo extends StatelessWidget {
  const DukeLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
                width: 200,
                // height: 100,
                child: Image(
                  key: const Key('dukeImg'),
                  image: NetworkImage(imageUrl('duke_logo.png')),
                  fit: BoxFit.fitWidth,
                  // width: 100,
                  opacity: const AlwaysStoppedAnimation(.7),
                  alignment: Alignment.bottomRight,
                ))));
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
    return LayoutBuilder(key: const Key('titleLayouter'), builder: builder);
  }
}

class TitleSliver extends StatelessWidget {
  const TitleSliver({required super.key});

  @override
  Widget build(BuildContext context) {
    Chapter chapter = Book.of(context).chapters[0];
    dev.log("Title title: ${chapter.displayName}");
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
