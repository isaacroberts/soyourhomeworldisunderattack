// import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/components/sliver_center.dart';

import '../../../backend/chapter.dart';
import '../../../backend/font_interm.dart';
import '../../../backend/text_utils.dart';
import '../../components/deferrals/debug_wrap.dart';
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
}

// ======= Special Fonts ==============
abstract class FontWanterTextHolder extends TextHolder {
  final FontInterm font;
  const FontWanterTextHolder(this.font, {required super.text});

  @override
  Future load({required String? debugId}) {
    return font.load(debugId: debugId);
  }

  @override
  bool isLoaded() {
    // dev.log("Isloaded: ${font.family}");
    return font.isLoaded();
  }

  Widget loadingElement(BuildContext context) {
    return SizedBox(width: text.length * 5.0, height: font.size);
  }
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
}

// ========= Styles ======================
class CustomFontText extends FontWanterTextHolder {
  final TextAlign align;
  final int tabs;
  const CustomFontText(super.font,
      {required super.text, this.align = TextAlign.start, this.tabs = 0});

  @override
  Future load({required String? debugId}) async {
    // await initHyphenation();
    return font.load(debugId: debugId);
  }

  @override
  bool isLoaded() {
    // dev.log("Isloaded: ${font.family}");
    return _hyphenatorInitialized && font.isLoaded();
  }

  Widget textElement(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    if (font.size > 20) {
      if (screenWidth < 500) {
        //TODO: Large fonts should use word wrap

        return Text(
          text,
          style: font.instance(),
          // selectable: true,

          textAlign: align,
        );
      }
    }
    //Otherwise use regular text
    return Text(
      text,
      style: font.instance(),
      textAlign: align,
    );
  }

  @override
  Widget element(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: textElement(context));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverTabs(
        key: Key('Tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: textElement(context));
  }

  @override
  Widget debugSliver(BuildContext context) {
    return DeferredTextHolderDebugSliver(holder: this);
  }
}

class HiliteFontText extends FontWanterTextHolder {
  final TextAlign align;
  final Color color;
  final int tabs;
  const HiliteFontText(super.font,
      {required super.text,
      required this.color,
      this.align = TextAlign.left,
      this.tabs = 0});

  @override
  Widget element(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.instanceWithColor(color), textAlign: align));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverTabs(
        key: Key('Tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.instanceWithColor(color), textAlign: align));
  }

  @override
  Widget debugSliver(BuildContext context) {
    //Calls sliver
    return DeferredTextHolderDebugSliver(holder: this);
  }
}

class SubSuperFontText extends FontWanterTextHolder {
  ///Covers all complex cases
  final TextAlign align;
  final Color color;
  final int tabs;
  final SubSuper subSuper;
  const SubSuperFontText(super.font,
      {required super.text,
      required this.color,
      this.align = TextAlign.left,
      this.tabs = 0,
      required this.subSuper});

  Widget scriptAlign(BuildContext context) {
    if (subSuper == SubSuper.superscript) {
      TextStyle style = font.instanceWithColor(color);
      style = style.copyWith(
        fontSize: style.fontSize! / 2,
        height: 2,
      );
      return Align(
          alignment: Alignment.topLeft,
          child: Text(text, style: style, textAlign: align));
    } else if (subSuper == SubSuper.subscript) {
      TextStyle style = font.instanceWithColor(color);
      style = style.copyWith(fontSize: style.fontSize! / 2, height: 2);
      return Align(
          alignment: Alignment.bottomLeft,
          child: Text(text, style: style, textAlign: align));
    } else {
      return Text(text, style: font.instanceWithColor(color), textAlign: align);
    }
  }

  @override
  Widget element(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: scriptAlign(context));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.instanceWithColor(color), textAlign: align));
  }

  @override
  Widget debugSliver(BuildContext context) {
    //Calls sliver
    return DeferredTextHolderDebugSliver(holder: this);
  }
}

// ============ Headers ============================

class HeaderOfText extends TextHolder {
  const HeaderOfText({required super.text});

  @override
  Widget element(BuildContext context) {
// I don't think we're using this
    return Text(
      text,
      style: headerFont,
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
      style: headerFont,
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
}

class CustomHeaderOfText extends HeaderOfText {
  final TextAlign align;
  final FontInterm font;
  const CustomHeaderOfText(
      {required super.text, required this.font, this.align = TextAlign.center});

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

    double tabSize = math.min(24, MediaQuery.sizeOf(context).width / 8);

    Widget alignWrap;
    if (horizAlign == Alignment.topLeft) {
      alignWrap = child;
    } else {
      //TODO: Sliverify
      alignWrap = Align(alignment: horizAlign, child: child);
    }
    alignWrap = SliverToBoxAdapter(child: alignWrap);

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
