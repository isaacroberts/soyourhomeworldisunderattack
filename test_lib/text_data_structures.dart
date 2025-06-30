import 'font_interm.dart';

const double k = 15;

enum TextAlign {
  left,
  right,
  center;
}

// ============ Misc ============================

abstract class TextHolder {
  const TextHolder();

  String totext();
}

class SpanHoldingCode extends TextHolder {
  final List<TextHolder> spans;
  const SpanHoldingCode({required this.spans});

  @override
  String totext() {
    return 'Span';
  }
}

//This is your fanfares and shit
abstract class CustomElement extends TextHolder {}

class BodyTextElement extends TextHolder {
  final String text;
  final int tabs;
  const BodyTextElement(this.text, {this.tabs = 0});
  @override
  String totext() {
    return text;
  }
}

class CustomFontText extends TextHolder {
  final String text;
  final FontInterm font;
  final TextAlign align;
  final int tabs;
  const CustomFontText(this.text, this.font,
      {this.align = TextAlign.left, this.tabs = 0});
  @override
  String totext() {
    return text;
  }
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

  @override
  String totext() {
    return text;
  }
}

class AlignedBodyText extends TextHolder {
  final String text;
  final TextAlign align;
  final int tabs;
  const AlignedBodyText(this.text, {required this.align, this.tabs = 0});
  @override
  String totext() {
    return text;
  }
}
// ============ Headers ============================

class HeaderOfText extends TextHolder {
  final String text;
  const HeaderOfText(this.text);
  @override
  String totext() {
    return text;
  }
}

class EmptyHeaderZero extends HeaderOfText {
  const EmptyHeaderZero() : super('');
  @override
  String totext() {
    return '[EmptyHeader]';
  }
}

class CustomHeaderOfText extends HeaderOfText {
  final FontInterm font;
  final TextAlign align;

  const CustomHeaderOfText(super.text, this.font,
      {this.align = TextAlign.left});
  @override
  String totext() {
    return text;
  }
}
// ============ MultiSpan Fragments ============================

abstract class FragOfText {
  const FragOfText();

  String toText();
}

class FragBody extends FragOfText {
  final String text;
  const FragBody(this.text);
  @override
  String toText() {
    return text;
  }
}

class FragCustom extends FragOfText {
  final String text;
  final FontInterm font;
  const FragCustom(this.text, this.font);
  @override
  String toText() {
    return text;
  }
}

class FragHilite extends FragOfText {
  final String text;
  final FontInterm font;
  final int color;
  const FragHilite(this.text, this.font, {required this.color});
  @override
  String toText() {
    return text;
  }
}

//Assumed to be a paragraph.
class SpanOfText extends TextHolder {
  final List<FragOfText> lines;
  final TextAlign align;
  final int tabs;
  const SpanOfText(this.lines, {this.align = TextAlign.left, this.tabs = 0});
  @override
  String totext() {
    String s = '';
    for (var l in lines) {
      s += l.toText();
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
  @override
  String totext() {
    return '[Newline: $height]';
  }
}

class PageBreakOfText extends TextHolder {
  const PageBreakOfText();
  @override
  String totext() {
    return '[BREAK]';
  }
}

class EndOfChapterText extends TextHolder {
  final int chapNo;
  const EndOfChapterText(this.chapNo);
  @override
  String totext() {
    return '[EndOfChap]';
  }
}
