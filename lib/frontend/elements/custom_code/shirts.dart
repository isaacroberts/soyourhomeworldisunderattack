import 'package:flutter/material.dart';

import '../holders/font_wanters.dart';
import '../holders/holder_base.dart';
import '../holders/span_holding_code.dart';

class Shirt extends SpanHoldingCode {
  late final Color color;
  final double width;
  final double height;
  Shirt({required super.spans, double? width, double? height})
      : width = width ?? 500,
        height = height ?? 600 {
    color = firstHilite() ?? Colors.white;
  }

  Color? firstHilite() {
    if (spans.isNotEmpty) {
      for (var span in spans) {
        if (span is HiliteFontText) {
          return span.color;
        }
      }
    }
    return null;
  }

  @override
  Widget renderSpans(BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) {
    return Column(
        key: const Key('shirtcol'),
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [for (Holder s in spans) s.element(context)]);
  }

  Widget neck(BuildContext context) {
    return ColoredBox(
        key: const Key('neck'),
        color: color,
        child: SizedBox(height: 10, width: width / 5));
  }

  Widget textAndSleeve(BuildContext context) {
    return SizedBox(
        key: const Key('tasSize'),
        width: width + 200,
        child: Stack(
          key: const Key('tasStack'),
          alignment: Alignment.topCenter,
          children: [
            torso(context),
            sleeves(context),
            Positioned.fill(
                key: const Key('tasFill'),
                child: Align(
                    key: const Key('tasAlign'),
                    alignment: const Alignment(0, -.5),
                    child: shirtText(context)))
            // shirtText(context),
          ],
        ));
  }

  Widget shirtText(BuildContext context) {
    return FittedBox(
        key: const Key('txtFit'),
        fit: BoxFit.fitWidth,
        child: SizedBox(width: width, child: renderSpans(context)));
  }

  Widget sleeves(BuildContext context) {
    return ColoredBox(
        key: const Key("sleeveColor"),
        color: color,
        child: SizedBox(
            key: const Key('sleeveSize'), height: 200, width: width + 200));
  }

  Widget torso(BuildContext context) {
    return ColoredBox(
        key: const Key('torso_color'),
        color: color,
        child: SizedBox(
          key: const Key('torso_size'),
          height: 650,
          width: width,
        ));
  }

  @override
  Widget element(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        key: const Key('shirt_size'),
        width: screenWidth,
        height: 800,
        child: Center(
            key: const Key('shirt_C'),
            child: FittedBox(
                key: const Key('shirt_fit'), child: textAndSleeve(context))));
    // columns(context));
  }
}

class BumperSticker extends SpanHoldingCode {
  late final Color color;
  final bool printExact;
  final double width;
  final double height;
  BumperSticker(
      {required super.spans,
      this.printExact = false,
      double? width,
      double? height})
      : width = width ?? 800,
        height = height ?? 300 {
    color = firstHilite() ?? Colors.white;
  }

  Color? firstHilite() {
    if (spans.isNotEmpty) {
      for (var span in spans) {
        if (span is HiliteFontText) {
          return span.color;
        }
      }
    }
    return null;
  }

  @override
  Widget element(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
            child: FittedBox(
                child: Container(
                    color: color,
                    height: 300,
                    width: 800,
                    alignment: Alignment.center,
                    child: super.renderSpans(context,
                        crossAxisAlignment: CrossAxisAlignment.center)))));
  }
}

class ChapterShirt extends Shirt {
  final String? link;
  ChapterShirt({required this.link, required super.spans});
}
