import 'dart:developer';
import 'dart:math' as math;


import 'font_interm.dart';
import 'styles.dart';

const double k = 15;

enum TextAlign {
  left, right, center;

}


// ============ Misc ============================

abstract class TextHolder {
  const TextHolder();

  String totext();
}

class SpanHoldingCode extends TextHolder {
  final List<TextHolder> spans;
  const SpanHoldingCode({required this.spans});

  String totext() { return 'Span';}

}

//This is your fanfares and shit
abstract class CustomElement extends TextHolder {}

class BodyTextElement extends TextHolder {
  final String text;
  final int tabs;
  const BodyTextElement(this.text, {this.tabs = 0});

  String totext() { return text;}

}

class StyledText extends TextHolder {
  final String text;
  final TextAlign align;
  final StyleType style;
  final int tabs;

  const StyledText(this.text, this.style,
      {this.align = TextAlign.left, this.tabs = 0});

  String totext() { return text;}

}

class CustomFontText extends TextHolder {
  final String text;
  final FontInterm font;
  final TextAlign align;
  final int tabs;
  const CustomFontText(this.text, this.font,
      {this.align = TextAlign.left, this.tabs = 0});

      String totext() { return text;}

}

class HiliteStyleText extends TextHolder {
  final String text;
  final TextAlign align;
  final StyleType style;
  final int tabs;
  const HiliteStyleText(this.text, this.style,
      {this.align = TextAlign.left, this.tabs = 0});

      String totext() { return text;}

}

class HiliteFontText extends TextHolder {
  final String text;
  final FontInterm font;
  final TextAlign align;
  // final Color color;
  final int color;
  final int tabs;
  const HiliteFontText(this.text, this.font,
      {required this.color, this.align = TextAlign.left, this.tabs = 0});
      String totext() { return text;}

}

class AlignedBodyText extends TextHolder {
  final String text;
  final TextAlign align;
  final int tabs;
  const AlignedBodyText(this.text, {required this.align, this.tabs = 0});
  String totext() { return text;}

}
// ============ Headers ============================

class HeaderOfText extends TextHolder {
  final String text;
  const HeaderOfText(this.text);
  String totext() { return text;}

}

class EmptyHeaderZero extends HeaderOfText {
  const EmptyHeaderZero() : super('');
  String totext() { return '[EmptyHeader]';}

}

class CustomHeaderOfText extends HeaderOfText {
  final FontInterm font;
  final TextAlign align;

  const CustomHeaderOfText(super.text, this.font,
      {this.align = TextAlign.left});
    String totext() { return text;}

}
// ============ MultiSpan Fragments ============================

abstract class FragOfText {
  const FragOfText();
  String totext();

}

class FragBody extends FragOfText {
  final String text;
  const FragBody(this.text);
  String totext() { return text;}

}

class FragStyled extends FragOfText {
  final String text;
  final StyleType style;
  const FragStyled(this.text, this.style);
  String totext() { return text;}

}

class FragStyledHilite extends FragOfText {
  final String text;
  final StyleType style;
  const FragStyledHilite(this.text, this.style);
  String totext() { return text;}

}

class FragCustom extends FragOfText {
  final String text;
  final FontInterm font;
  const FragCustom(this.text, this.font);
  String totext() { return text;}

}

class FragHilite extends FragOfText {
  final String text;
  final FontInterm font;
  final int color;
  const FragHilite(this.text, this.font, {required this.color});
  String totext() { return text;}

}

//Assumed to be a paragraph.
class SpanOfText extends TextHolder {
  final List<FragOfText> lines;
  final TextAlign align;
  final int tabs;
  const SpanOfText(this.lines, {this.align = TextAlign.left, this.tabs = 0});

  String totext() {
  String s = '';
for (var l in lines) {
  s += l.totext();
  s += '|';
  }
  s = s.substring(0, s.length - 1);
  return s;
  }

}

// ============ Misc ============================

class BlankOfText extends TextHolder {
  final double height;
  const BlankOfText({required this.height});
  String totext() { return '[Newline: ${height}]';}


}

class PageBreakOfText extends TextHolder {
  const PageBreakOfText();
  String totext() { return '[BREAK]';}

}

class EndOfChapterText extends TextHolder {
  final int chapNo;
  const EndOfChapterText(this.chapNo);
  String totext() { return '[EndOfChap]';}

}
