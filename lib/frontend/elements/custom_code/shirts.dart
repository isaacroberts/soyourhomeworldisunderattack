import 'package:flutter/material.dart';

import '../holders/holder_base.dart';
import '../holders/span_holding_code.dart';
import '../holders/textholders.dart';

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
    bool showFonts = IsFallbackProvider.shouldShowFonts(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (Holder s in spans)
            showFonts ? s.element(context) : s.fallback(context)
        ]);
  }

  Widget neck(BuildContext context) {
    return ColoredBox(
        color: color, child: SizedBox(height: 10, width: width / 5));
  }

  Widget textAndSleeve(BuildContext context) {
    return SizedBox(
        width: width + 200,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            torso(context),
            sleeves(context),
            Positioned.fill(
                child: Align(
                    alignment: Alignment(0, -.5), child: shirtText(context)))
            // shirtText(context),
          ],
        ));
  }

  Widget shirtText(BuildContext context) {
    return FittedBox(
        child: SizedBox(width: width, child: renderSpans(context)));
  }

  Widget sleeves(BuildContext context) {
    return ColoredBox(
        color: color, child: SizedBox(height: 200, width: width + 200));
  }

  Widget torso(BuildContext context) {
    return ColoredBox(
        color: color,
        child: SizedBox(
          height: 650,
          width: width,
        ));
  }

  @override
  Widget element(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: screenWidth,
        height: 800,
        child: Center(child: FittedBox(child: textAndSleeve(context))));
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

  @override
  Widget element(BuildContext context) {
    return super.element(context);
  }
}
