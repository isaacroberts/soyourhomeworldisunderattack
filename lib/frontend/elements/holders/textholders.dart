import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/span_holders.dart';

import '../../../backend/font_interm.dart';
import '../../styles.dart';
import '../custom_code/code_holders.dart';

export 'misc_holders.dart';
export 'span_holders.dart';

const double k = 12;

// ============ Base ============================

abstract class Holder {
  const Holder();

  Widget elementOrFallback(BuildContext context, bool showFonts) {
    if (showFonts) {
      return element(context);
    } else {
      return fallback(context);
    }
  }

  Widget elementCheckingFallback(BuildContext context) {
    bool showFonts = IsFallbackProvider.shouldShowFonts(context);
    if (showFonts) {
      return element(context);
    } else {
      return fallback(context);
    }
  }

  Widget element(BuildContext context);
  Widget fallback(BuildContext context);

  Future load() async {
    return null;
  }

  bool isLoaded() {
    return true;
  }

  //Visual utilities

  static Widget fallbackWrap(Widget child) {
    return child;
  }

  static String stripOutTextFromFrags(List<FragOfText> frags) {
    String text = '';
    for (FragOfText f in frags) {
      if (f is FragBody) {
        text += f.text;
      }
    }
    return text;
  }

  static String stripOutText(List<Holder> holders) {
    String text = '';
    for (Holder h in holders) {
      if (h is TextHolder) {
        text += h.text;
        text += '\n';
      } else if (h is SpanOfText) {
        text += stripOutTextFromFrags(h.spans);
        text += '\n';
      } else if (h is SpanHoldingCode) {
        text += stripOutText(h.spans);
        text += '\n';
      }
    }
    return text;
  }
}

// ========== Base ================

abstract class TextHolder extends Holder {
  final String text;
  const TextHolder({required this.text});
}

class BodyTextElement extends TextHolder {
  // final int tabs;
  const BodyTextElement(String text) : super(text: text);

  @override
  Widget element(BuildContext context) {
    return Text(
      text,
      style: bodyFont,
    );
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

// ======= Special Fonts ==============
abstract class FontWanterTextHolder extends TextHolder {
  final FontInterm font;
  const FontWanterTextHolder(this.font, {required super.text});

  @override
  Future load() {
    return font.load();
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
    return wrapInTabs(
        tabs,
        align,
        Text(
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

class HeaderOfText extends TextHolder {
  const HeaderOfText({required super.text});

  @override
  Widget element(BuildContext context) {
    return Container(
        height: 36,
        color: const Color(0x88000000),
        alignment: Alignment.center,
        child: Text(text,
            textAlign: TextAlign.center,
            style: headerFont.copyWith(
              color: const Color(0xbbffffff),
              fontSize: 24,
              // fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              // color: const Color(0xff000000),
              decorationColor: const Color(0xbbffffff),
              decoration: TextDecoration.underline,
            )));
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

class HiddenTextElement extends Holder {
  const HiddenTextElement();
  @override
  Widget element(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget fallback(BuildContext context) {
    return const SizedBox.shrink();
  }
}

// ========= Styles ======================
class CustomFontText extends FontWanterTextHolder {
  final TextAlign align;
  final int tabs;
  const CustomFontText(super.font,
      {required super.text, this.align = TextAlign.left, this.tabs = 0});

  @override
  Widget element(BuildContext context) {
    return wrapInTabs(
        tabs,
        align,
        Text(
          text,
          style: font.instance(),
          textAlign: align,
        ));
  }

  @override
  Widget fallback(BuildContext context) {
    return (wrapInTabs(
        tabs,
        align,
        Text(
          text,
          style: font.fallback(),
          textAlign: align,
        )));
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
    return wrapInTabs(
        tabs,
        align,
        Text(('\t' * tabs) + text,
            style: font.instanceWithColor(color), textAlign: align));
  }

  @override
  Widget fallback(BuildContext context) {
    return wrapInTabs(
        tabs,
        align,
        Text(('\t' * tabs) + text,
            style: font.fallbackWithColor(color), textAlign: align));
  }
}

// ============ Headers ============================

class CustomHeaderOfText extends HeaderOfText {
  final TextAlign align;
  final FontInterm font;
  const CustomHeaderOfText(
      {required super.text, required this.font, this.align = TextAlign.center});

  @override
  Widget element(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x6f770077), width: 1)),
        child: Align(
            alignment: textAlignToHoriz(align),
            child: Text(
              text,
              style: font.instance(),
              textAlign: align,
            )));
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

const double tabSize = 50;
Widget wrapInTabs(int tabs, TextAlign align, Widget child) {
  Alignment horizAlign = textAlignToHoriz(align);

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
