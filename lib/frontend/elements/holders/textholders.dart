// import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/components/sliver_center.dart';

import '../../../backend/chapter.dart';
import '../../../backend/font_interm.dart';
import '../../components/deferrals/debug_wrap.dart';
import '../../parts/part.dart';
import '../../theme/base_text_theme.dart';
import 'holder_base.dart';

export 'misc_holders.dart';
export 'span_holders.dart';

bool _hyphenatorInitialized = false;
Future initHyphenator() async {
  if (!_hyphenatorInitialized) {
    // return initHyphenation();
    _hyphenatorInitialized = true;
  }
  return null;
}

const double k = 12;

// ========== Base ================
///Standard text elements
/// Has text which can be extracted
///Do not override with CodeHolders
abstract class TextHolder extends Holder {
  final String text;
  const TextHolder({required this.text});

  @override
  String toText() {
    return text;
  }
}

class BodyTextElement extends TextHolder {
  // final int tabs;
  const BodyTextElement(String text) : super(text: text);

  @override
  Widget element(BuildContext context) {
    //Get the part!
    TextStyle bodyFont = ChapterProvider.bodyFontOf(context);
    return Text(
      text,
      style: bodyFont,
    );
  }

  @override
  Widget sliver(BuildContext context) {
    TextStyle bodyFont = ChapterProvider.bodyFontOf(context);
    return SliverToText(
        child: Text(
      text,
      style: bodyFont,
    ));
  }

  @override
  Widget debugSliver(BuildContext context) {
    return DeferredBodyDebugSliver(holder: this);
  }

//No color
  @override
  void sweepForColor(Color find, Color? repl) {}
}

// ==== Basics ========================
class AlignedBodyText extends TextHolder {
  final TextAlign align;
  final int tabs;
  const AlignedBodyText(
      {required super.text, required this.align, this.tabs = 0});

  @override
  Widget element(BuildContext context) {
    TextStyle bodyFont = ChapterProvider.bodyFontOf(context);

    return WrapInTabs(
        key: Key("tabs$hashCode"),
        tabs: tabs,
        align: align,
        child: Text(
          text,
          style: bodyFont,
          textAlign: align,
        ));
  }

  @override
  Widget sliver(BuildContext context) {
    TextStyle bodyFont = ChapterProvider.bodyFontOf(context);

    return SliverTabs(
        key: Key("Tabs$hashCode"),
        tabs: tabs,
        align: align,
        child: Text(
          text,
          style: bodyFont,
          textAlign: align,
        ));
  }

  @override
  Widget debugSliver(BuildContext context) {
    return DeferredTextHolderDebugSliver(holder: this);
  }

  //No color
  @override
  void sweepForColor(Color find, Color? repl) {}
}

// ============ Headers ============================

class HeaderOfText extends TextHolder {
  final int level;
  const HeaderOfText({required this.level, required super.text});

  @override
  Widget element(BuildContext context) {
// I don't think we're using this
    return Text(
      text,
      style: headerFont(color: Part.of(context).primary.se),
      // style: font.instance(),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget sliver(BuildContext context) {
// I don't think we're using this
    return SliverCenter(
        sliver: SliverToBoxAdapter(
            child: Text(
      text,
      style: headerFont(color: Part.of(context).primary.se),
      // style: font.instance(),
      textAlign: TextAlign.center,
    )));
  }

  @override
  Widget debugSliver(BuildContext context) {
    //Calls sliver
    return DeferredTextHolderDebugSliver(holder: this);
  }

  @override
  String toText() {
    return '\n$text\n';
  }

  //No free labor, king.
  @override
  void sweepForColor(Color find, Color? repl) {}
}

class CustomHeaderOfText extends HeaderOfText {
  final TextAlign align;
  FontInterm font;
  CustomHeaderOfText(
      {required super.level,
      required super.text,
      required this.font,
      this.align = TextAlign.center});

  @override
  Widget element(BuildContext context) {
    return Align(
        alignment: textAlignToHoriz(align),
        child: Text(
          text,
          style: font.instance(),
          textAlign: align,
        ));
  }

  //No free labor, king.
  @override
  void sweepForColor(Color find, Color? repl) {
    if (font.color == null || font.color == find) {
      font = font.copyWithColor(repl);
    }
  }
}

//============ Utils =====================

Alignment textAlignToHoriz(TextAlign align) {
  switch (align) {
    case TextAlign.left:
    case TextAlign.start:
    case TextAlign.justify:
      return Alignment.topLeft;
    case TextAlign.center:
      return Alignment.topCenter;
    case TextAlign.right:
    case TextAlign.end:
      return Alignment.topRight;
  }
}

class WrapInTabs extends StatelessWidget {
  final int tabs;
  final TextAlign align;
  final Widget child;
  const WrapInTabs(
      {required super.key,
      required this.tabs,
      required this.align,
      required this.child});

  @override
  Widget build(BuildContext context) {
    Alignment horizAlign = textAlignToHoriz(align);

    double tabSize = math.min(24, MediaQuery.sizeOf(context).width / 8);

    Widget alignWrap;
    if (horizAlign == Alignment.topLeft) {
      alignWrap = child;
    } else {
      alignWrap = Align(alignment: horizAlign, child: child);
    }

    if (tabs == 0) {
      return alignWrap;
    } else {
      //Left align
      if (align == TextAlign.left || align == TextAlign.start) {
        //Left tabs
        return Padding(
            padding: EdgeInsets.only(left: 12 + tabSize * tabs),
            child: alignWrap);
      } else {
        //Right tabs
        return Padding(
            padding: EdgeInsets.only(right: 12 + tabSize * tabs),
            child: alignWrap);
      }
    }
  }
}

class SliverTabs extends StatelessWidget {
  final int tabs;
  final TextAlign align;
  final Widget child;
  const SliverTabs(
      {required super.key,
      required this.tabs,
      required this.align,
      required this.child});

  @override
  Widget build(BuildContext context) {
    Alignment horizAlign = textAlignToHoriz(align);
    double width = MediaQuery.sizeOf(context).width;
    double tabSize = math.min(24, width / 8);

    Widget alignWrap;
    alignWrap = SliverToBoxAdapter(child: child);

    if (horizAlign == Alignment.topLeft) {
      // alignWrap = alignWrap;
    } else {
      alignWrap = SliverCenter(
        sliver: alignWrap,
        align: horizAlign.x,
      );
    }

    if (tabs == 0) {
      //Base padding
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        sliver: alignWrap,
      );
    } else {
      //Left align
      if (align == TextAlign.left || align == TextAlign.start) {
        //Left tabs
        return SliverPadding(
            padding: EdgeInsets.only(left: 12 + tabSize * tabs, right: 12),
            sliver: alignWrap);
      } else {
        //Right tabs
        return SliverPadding(
            padding: EdgeInsets.only(right: 12 + tabSize * tabs, left: 12),
            sliver: alignWrap);
      }
    }
  }
}
