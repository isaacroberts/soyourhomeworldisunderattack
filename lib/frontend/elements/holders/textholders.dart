// import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';
import '../../../backend/font_interm.dart';
import '../../../backend/text_utils.dart';
import '../../theme/base_text_theme.dart';
// import '../custom_code/code_holders.dart';

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

abstract class TextHolder extends Holder {
  /// Has text which can be extracted
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
  Widget fallback(BuildContext context) {
    //Get the part!
    TextStyle bodyFont = ChapterProvider.bodyFontOf(context);
    return Text(
      text,
      style: bodyFont,
    );
    // return element(context);
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
  Widget fallback(BuildContext context) {
    return element(context);
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
        return Text(
          text,
          style: font.instance(),
          // selectable: true,
          textAlign: align,
        );
      }
      //Large fonts should use word wrap
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
  Widget fallback(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: Text(
          text,
          style: font.fallback(),
          textAlign: align,
        ));
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
  Widget fallback(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.fallbackWithColor(color), textAlign: align));
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
  Widget fallback(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.fallbackWithColor(color), textAlign: align));
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
  Widget fallback(BuildContext context) {
    return element(context);
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

  @override
  Widget fallback(BuildContext context) {
    //Show standard header
    return super.fallback(context);
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

    double tabSize = MediaQuery.sizeOf(context).width / 8;

    Widget alignWrap;
    if (horizAlign == Alignment.topLeft) {
      alignWrap = child;
    } else {
      alignWrap = Align(alignment: horizAlign, child: child);
    }

    if (tabs == 0) {
      return alignWrap;
    } else {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15 + tabSize * tabs),
          child: alignWrap);
    }
  }
}
