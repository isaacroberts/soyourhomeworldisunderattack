import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/backend/font_interm.dart';

import '../holders/holder_base.dart';

///Scrolling Marquee doing the "A Elbereth... Gilthoniel"
class ElvenChorusHolder extends CodeHolder {
  final int? speed;
  const ElvenChorusHolder({required this.speed});

  @override
  Widget element(BuildContext context) {
    return ElvenChorus(key: Key("elvenChorus_$id"), speed: speed ?? 1);
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverToBoxAdapter(
        key: Key('ElvenChorusStba_$id'),
        child: SizedBox(
            height: 48 + 12,
            child:
                ElvenChorus(key: const Key('elvenChorus'), speed: speed ?? 1)));
  }

  @override
  String toText() {
    return chorus;
  }
}

class ElvenChorus extends StatefulWidget {
  //0=Normal, 1 = Quick, 2 = Comically fast
  final int speed;
  // int get speed => 2;
  const ElvenChorus({super.key, required this.speed});

  @override
  State<ElvenChorus> createState() => _ElvenChorusState();

  TextStyle get style => elvesFont.style;

  double get textScaleFactor => 1;

  double get blankSpace => 5;

  double get velocity => 10;

  double get startPadding => 0;
}

const Color elvesColor = Color(0xff0f250e);

final FontPremadeInterm elvesFont = FontPremadeInterm(
    style: const TextStyle(
  fontFamily: 'Celtic Garamond the 2nd',
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: elvesColor,
  height: 1,
));

const String chorus = 'A Elbereth! Gilthoniel!';

const List<String> verses = [
  "Fanuilos heryn aglar / Rîn athar annún-aearath / Calad ammen i reniar / Mi 'aladhremmin ennorath!",
  // "/ I chîn a thûl lin míriel / Fanuilos le linnathon / Ne ndor haer thar i aearon / A elin na gaim eglerib / Ned în ben-anor trerennin / Si silivrin ne pherth 'waewib / Cenim lyth thílyn thuiennin",
  // "Men echenim sí derthiel / Ne chaered hen nu 'aladhath / Ngilith or annún-aearath"
];

class _ElvenChorusState extends State<ElvenChorus>
    with SingleTickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  // final ScrollController controller2 = ScrollController();
  late final Timer timer;
  late final List<Widget> elements;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), checkScroll);
    elvesFont.load(debugId: 'ElvenChorus');
    super.initState();
  }

  bool get initted => textWidth > 0;

  double screenWidth = 0;
  double textWidth = 0;

  bool get wrap => widget.speed != 1;

  double get totalOffset => textWidth + 24 - (wrap ? screenWidth : 0);
  int get speedMultiplier {
    ///Milliseconds per pixel
    if (widget.speed == 0) {
      //Calm, readable
      return 12;
    } else if (widget.speed == 1) {
      //Quick, readable. Singing speed.
      return 6;
    } else if (widget.speed == 2) {
      //Comically fast
      return 1;
    }
    ErrorList.logWarning(
        'Incorrect speed on ElvenChorus: ${widget.speed}. Values should be 0-2.');
    return 12;
  }

  Duration get duration =>
      Duration(milliseconds: (totalOffset * speedMultiplier).toInt());

  Duration get backDuration =>
      Duration(milliseconds: (totalOffset * speedMultiplier * 3).toInt());
  void checkScroll(t) {
    if (mounted && controller.hasClients && initted) {
      // dev.log("Scroll @: ${controller.offset} / $totalOffset");
      if (controller.offset == 0) {
        dev.log("(ElvenChorus) Animate forward");
        Curve curve = Curves.linear;

        controller.animateTo(totalOffset + 10,
            duration: duration, curve: curve);
        // controller2.animateTo(totalOffset + 10,
        //     duration: duration, curve: curve);
      } else if (controller.offset >= totalOffset - 30) {
        //Animate backwards
        if (wrap) {
          //Jump back
          dev.log("(ElvenChorus) Jump back");
          controller.jumpTo(0);
          // controller2.jumpTo(0);
        } else {
          //Animate back
          dev.log("(ElvenChorus) Animate back");
          Curve curve = Curves.fastEaseInToSlowEaseOut;
          controller.animateTo(0, duration: backDuration, curve: curve);
          // controller2.animateTo(0, duration: backDuration, curve: curve);
        }
      }
    }
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  /// Calculates all necessary values for animating, then starts the animation.
  void _initialize(BuildContext context) {
    // Calculate lengths (amount of pixels that each phase needs).
    textWidth = getTextWidth(context);
  }

  double getTextWidth(BuildContext context) {
    return 2100;
    //CBA!!!
    double width = 0;
    double chorusWidth = _getTextWidth(context, chorus, 2);
    // width += 12;
    for (String verse in verses) {
      width += _getTextWidth(context, verse, 1);
      //spacing
      width += 24;
      width += chorusWidth;
      width += 12;
    }
    dev.log("Marquee text width = $width");
    return width;
  }

  /// Returns the width of the text.
  double _getTextWidth(BuildContext context, String string, double multiplier) {
    final span = TextSpan(text: string, style: elvesFont.style);

    const constraints = BoxConstraints(maxWidth: double.infinity);

    final richTextWidget = Text.rich(
      span,
      style: elvesFont.style,
    ).build(context) as RichText;
    final renderObject = richTextWidget.createRenderObject(context);
    renderObject.layout(constraints);

    final boxes = renderObject.getBoxesForSelection(TextSelection(
      baseOffset: 0,
      extentOffset: TextSpan(text: string).toPlainText().length,
    ));

    return boxes.last.right * multiplier;
  }

  Widget chorusElem(String w) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Text(w,
            maxLines: 1,
            style: elvesFont.style.copyWith(fontSize: 48, height: 1)));
  }

  Widget verseElem(String w) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          w,
          maxLines: 1,
          style: elvesFont.style,
        ));
  }

  Iterable<String> splitLen(String sentence) sync* {
    for (int n = 0; n < sentence.length; n += 100) {
      yield sentence.substring(n, math.min(n + 100, sentence.length));
    }

    // yield sentence.substring(sentence.length - sentence.length % 100);
  }

  List<Widget> text() {
    List<Widget> widgets = [];
    //
    // widgets.add(SizedBox(
    //   width: screenWidth,
    // ));

    widgets.add(const SizedBox(
      width: 12,
    ));
    Iterable<Widget> chorusW = splitLen(chorus).map(chorusElem);

    for (String verse in verses) {
      widgets.addAll(splitLen(verse).map(verseElem));

      widgets.add(const SizedBox(
        width: 24,
      ));
      widgets.addAll(chorusW);
      widgets.add(const SizedBox(
        width: 12,
      ));
    }
    widgets.add(SizedBox(
      //Extra to make sure loop can complete
      width: screenWidth,
    ));
    widgets.add(const SizedBox(
      width: 12,
    ));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    if (initted && w != screenWidth) {
      elements[0] = SizedBox(
        width: screenWidth,
      );
      elements.last = SizedBox(
        width: screenWidth,
      );
    }
    screenWidth = w;
    if (!initted) {
      _initialize(context);
      elements = text();
    }

    return Tooltip(
        message: "\"Passing of the Elves\"\nfrom Lord of the Rings",
        child: SizedBox(
            height: 48 + 12 * 2,
            width: screenWidth,
            // alignment: Alignment.centerRight,
            child: stackIfDebug(context,
                child: ListView(
                    primary: false,
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: elements))));
  }

  Widget stackIfDebug(BuildContext context, {required Widget child}) {
    // return Stack(
    //   children: [widthDebugListView(context), child],
    // );
    return child;
  }

  // Widget widthDebugListView(BuildContext context) {
  //   return ListView(
  //     primary: false,
  //     controller: controller2,
  //     scrollDirection: Axis.horizontal,
  //     children: [
  //       const SizedBox(
  //         width: 12,
  //       ),
  //       Container(
  //         color: Color(0xffffffff),
  //         width: textWidth,
  //       ),
  //       const SizedBox(
  //         width: 12,
  //       ),
  //       SizedBox(
  //         width: screenWidth - 50,
  //       ),
  //       Container(
  //         color: const Color(0xff557755),
  //         width: 50,
  //         child: const Text('1'),
  //       ),
  //       SizedBox(
  //         width: screenWidth - 50,
  //       ),
  //       Container(
  //         color: const Color(0xff557755),
  //         width: 50,
  //         child: const Text('2'),
  //       ),
  //       SizedBox(
  //         width: screenWidth - 50,
  //       ),
  //       Container(
  //         color: const Color(0xff557755),
  //         width: 50,
  //         child: const Text('3'),
  //       ),
  //     ],
  //   );
  // }
}
