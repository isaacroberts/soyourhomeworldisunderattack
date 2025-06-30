// import 'dart:math' as math;
// import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import '../../../backend/font_interm.dart';
import '../../base_text_theme.dart';
import 'holder_base.dart';

export 'misc_holders.dart';

// ============ MultiSpan Fragments ============================

//Assumed to be a paragraph.
class SpanOfText extends Holder {
  final List<FragOfText> spans;
  final TextAlign align;
  final int tabs;
  const SpanOfText(
      {required this.spans, this.align = TextAlign.left, this.tabs = 0});

  @override
  Future load() async {
    for (FragOfText span in spans) {
      if (!span.isLoaded()) {
        await span.load();
      }
    }
    return null;
  }

  @override
  bool isLoaded() {
    for (FragOfText span in spans) {
      if (!span.isLoaded()) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget element(BuildContext context) {
    return wrapInTabs(
        tabs,
        align,
        RichText(
          textAlign: align,
          text: TextSpan(children: [
            for (int n = 0; n < spans.length; ++n) spans[n].span(context),
          ]),
        ));
  }

  @override
  Widget fallback(BuildContext context) {
    return wrapInTabs(
        tabs,
        align,
        RichText(
          textAlign: align,
          text: TextSpan(children: [
            for (int n = 0; n < spans.length; ++n) spans[n].fallback(context),
          ]),
        ));
  }
}

abstract class FragOfText {
  const FragOfText();
  InlineSpan span(BuildContext context);

  Future load() async {
    return null;
  }

  bool isLoaded() => true;
  InlineSpan fallback(BuildContext context) {
    return span(context);
  }
}

class FragBody extends FragOfText {
  final String text;
  const FragBody(this.text);

  @override
  InlineSpan span(BuildContext context) {
    return TextSpan(text: text, style: bodyFont);
  }
}

class FragCustom extends FragOfText {
  final FontInterm font;
  final String text;
  final Color? color;
  const FragCustom(this.text, this.font, {this.color});

  @override
  Future load() async {
    return font.load();
  }

  @override
  bool isLoaded() => font.isLoaded();

  @override
  InlineSpan span(BuildContext context) {
    return TextSpan(text: text, style: font.instance());
  }

  @override
  InlineSpan fallback(BuildContext context) {
    return TextSpan(text: text, style: font.fallback());
  }
}

class FragColoredBox extends FragOfText {
  final double width;
  final double height;
  final Color color;
  const FragColoredBox(
      {required this.width, required this.height, required this.color});

  @override
  InlineSpan span(BuildContext context) {
    return WidgetSpan(
        child: Container(
            width: width * fontScale,
            height: height * fontScale,
            color: color));
  }
}
