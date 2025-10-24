// import 'dart:math' as math;
// import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/chapter.dart';
import 'package:soyourhomeworld/frontend/components/deferrals/debug_wrap.dart';
import 'package:soyourhomeworld/frontend/components/selectable_span.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import '../../../backend/font_interm.dart';
import '../../../backend/text_utils.dart';
import '../../theme/base_text_theme.dart';
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
  Future load({required String? debugId}) async {
    for (FragOfText span in spans) {
      if (!span.isLoaded()) {
        await span.load(debugId: debugId);
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

  ///Uses a selectionSpan that allows copying
  Widget selectableElement(BuildContext context) =>
      SelectableSpan(key: Key("span$hashCode"), spans: spans, align: align);

  ///Skips SelectionSpan in case it's not working
  Widget unselectableElement(BuildContext context) => RichText(
        text: TextSpan(children: [
          for (int n = 0; n < spans.length; ++n) spans[n].span(context),
        ]),
        textAlign: align,
      );

  @override
  Widget element(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: unselectableElement(context));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: unselectableElement(context));
  }

  @override
  Widget debugSliver(BuildContext context) {
    return DeferredHolderDebugSliver(holder: this);
  }

  @override
  String toText() {
    return spans.map((e) => e.toText()).join();
  }

  @override
  void sweepForColor(Color find, Color? repl) {
    for (FragOfText span in spans) {
      if (span is FragColoredBox) {
        //No free labor, king
      } else if (span is FragCustom) {
        if (span.font.color == null || span.font.color == find) {
          span.font = span.font.copyWithColor(repl);
        }
      } else if (span is FragSubSuper) {
        if (span.font.color == null || span.font.color == find) {
          span.font = span.font.copyWithColor(repl);
        }
      }
    }
  }
}

abstract class FragOfText {
  const FragOfText();
  InlineSpan span(BuildContext context);

  String toText();

  Future load({required String? debugId}) async {
    return null;
  }

  bool isLoaded() => true;
}

class FragBody extends FragOfText {
  final String text;
  const FragBody(this.text);

  @override
  String toText() {
    return text;
  }

  @override
  InlineSpan span(BuildContext context) {
    TextStyle bodyFont = ChapterProvider.of(context).part.bodyFont;
    return TextSpan(text: text, style: bodyFont);
  }
}

class FragCustom extends FragOfText {
  FontInterm font;
  final String text;
  Color? bgColor;
  FragCustom(this.text, this.font, {this.bgColor});

  @override
  String toText() {
    return text;
  }

  @override
  Future load({required String? debugId}) async {
    return font.load(debugId: debugId);
  }

  @override
  bool isLoaded() => font.isLoaded();

  @override
  InlineSpan span(BuildContext context) {
    return TextSpan(text: text, style: font.instanceWithColor(bgColor));
  }
}

class FragSubSuper extends FragOfText {
  FontInterm font;
  final String text;
  final Color? color;
  final SubSuper subSuper;
  FragSubSuper(this.text, this.font, {this.color, required this.subSuper});

  @override
  String toText() {
    return text;
  }

  @override
  Future load({required String? debugId}) async {
    return font.load(debugId: debugId);
  }

  @override
  bool isLoaded() => font.isLoaded();

  Widget colorWrap({required Widget child}) {
    if (color == null) {
      return child;
    } else {
      return ColoredBox(color: color!, child: child);
    }
  }

  InlineSpan subSuperSpan(BuildContext context) {
    TextStyle style = font.instance();
    if (subSuper == SubSuper.superscript) {
      style = style.copyWith(
        fontSize: style.fontSize! / 2,
        height: 2,
      );
      return WidgetSpan(
          child: colorWrap(
              child: Text(
            text,
            style: style,
          )),
          alignment: PlaceholderAlignment.aboveBaseline,
          baseline: TextBaseline.alphabetic,
          style: style);
    } else if (subSuper == SubSuper.subscript) {
      style = style.copyWith(
        fontSize: style.fontSize! / 2,
        height: 1,
      );
      return WidgetSpan(
          child: colorWrap(
              child: Text(
            text,
            style: style,
          )),
          alignment: PlaceholderAlignment.bottom,
          baseline: TextBaseline.alphabetic,
          style: style);
    } else {
      throw Exception('Wrong usage of subSuperSpan function');
    }
  }

  @override
  InlineSpan span(BuildContext context) {
    if (subSuper.special) {
      return subSuperSpan(context);
    } else {
      return TextSpan(text: text, style: font.instanceWithColor(color));
    }
  }
}

class FragColoredBox extends FragOfText {
  final double width;
  final double height;
  Color color;
  FragColoredBox(
      {required this.width, required this.height, required this.color});

  @override
  String toText() {
    return ' ';
  }

  @override
  InlineSpan span(BuildContext context) {
    return WidgetSpan(
        child: Container(
            width: width * fontScale,
            height: height * fontScale,
            color: color));
  }
}
