import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/binary_utils/binary.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/backend/font_interm.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../frontend/elements/holders/holder_base.dart';
import '../frontend/elements/holders/textholders.dart';
import 'binary_utils/buffer_ptr.dart';

class Wousi {
  late final int weight;
  late final bool italic;
  late final bool underline;
  late final bool overline;
  //TODO: Needs sub/superscript
  late final bool strikethrough;

  Wousi.basic()
      : weight = 500,
        italic = false,
        underline = false,
        overline = false,
        strikethrough = false;

  bool isBasic() {
    return weight == 500 &&
        !italic &&
        !underline &&
        !overline &&
        !strikethrough;
  }

  Wousi.fromByte(int byte) {
    if (byte < 15) {
      // throw FontException("Invalid Wousi byte: Weight=0. (byte=$byte)",
      //     family: '?');
      dev.log("Invalid Wousi byte: Weight=0. (byte=$byte)");
      //Invalid Weight
      weight = 500;
      italic = false;
      overline = false;
      underline = false;
      strikethrough = false;
    } else {
      italic = (byte & 0x1) > 0;
      strikethrough = (byte & 0x2) > 0;
      underline = (byte & 0x4) > 0;
      overline = (byte & 0x8) > 0;
      weight = math.max(math.min(byte ~/ 16, 9), 1) * 100;
    }
  }
}

class LiveFont {
  // FontInterm? font;
  // StyleType? style;

  int tabs = 0;
  TextAlign align = TextAlign.left;

  bool get changedAlign => align != TextAlign.left;

  // String? family;
  int? fontId;
  double? size;

  Color? bgCol, fontCol;
  Wousi? wousi;

  bool isBody() {
    return (fontId == 0) &&
        (size == null || size == 12) &&
        (bgCol == null) &&
        (fontCol == null) &&
        (wousi?.isBasic() ?? true);
  }

  bool isStandardHeader() {
    return (fontId == 1) &&
        (size == null || size == 24) &&
        (bgCol == null) &&
        (fontCol == null) &&
        (wousi?.isBasic() ?? true);
  }

  Wousi parseWousiByte(int byte) {
    //Weight Overline Underline Strikethru Italic
    return Wousi.fromByte(byte);
  }

  void setWousiByte(int byte) {
    wousi = parseWousiByte(byte);
  }

  void setAlignFromChar(String char, int debugPos) {
    if (char == 'l') {
      align = TextAlign.left;
    } else if (char == 'c') {
      align = TextAlign.center;
    } else if (char == 'r') {
      align = TextAlign.right;
    } else if (char == 'j') {
      align = TextAlign.justify;
    } else {
      align = TextAlign.left;
      throw ChapterFormatException(
          'Unrecognized alignment char "$char" (=${char.codeUnits}) @pos=$debugPos',
          debugId: '?');
    }
  }

  BufferPtr parseFont(BufferPtr ptr) {
    // dev.log('Font = ${ptr.start} ${ptr.getChar()}');
    if (ptr.getChar() == ';') {
      //No font - therefore: basic.
      // family = "Palatino";
      fontId = 0;
      size = 12;
      wousi = Wousi.basic();
      return ptr;
    } else {
      fontId = ptr.consumeTypedInt()!;
      size = ptr.consumeFloat32();
      int wousiByte = ptr.consumeUint8();
      wousi = parseWousiByte(wousiByte);
      return ptr;
    }
  }

  BufferPtr parseDecorations(BufferPtr ptr) {
    /*
      this is the part between ()
      (tab align & font? & color? & hilite? )
     */

    //Start paren was already consumed to know that it was a font.
    // ptr.consume(Codes.LPAREN.code);

    tabs = ptr.consumeUint8();
    String align = ptr.consumeChar();

    setAlignFromChar(align, ptr.start);
    if (!ptr.hasMore()) {}
    if (ptr.eatRParen()) {
      //'(', tabb, alignb, ')'|
      return ptr;
    } else if (ptr.eatAmpersand()) {
      //'(', tabb, alignb, '&'|, fb, ')'
      ptr = parseFont(ptr);

      if (ptr.eatRParen()) {
        //'(', tabb, alignb, '&', fb, ')'|
        return ptr;
      } else if (ptr.eatAmpersand()) {
        //'(', tabb, alignb, '&', fb, '&',| bgB, ')
        bgCol = ptr.consumeColor(throwOnFail: true);
        // dev.log("(Bin) read bgCol: $bgCol");
        if (ptr.eatRParen()) {
          //'(', tabb, alignb, '&', fb, '&', bgB, ')|
          return ptr;
        } else if (ptr.eatAmpersand()) {
          //'(', tabb, alignb, '&', fb, '&', bgB, '&',| fcB, ')
          fontCol = ptr.consumeColor(throwOnFail: true);
          // dev.log("(Bin) read fontCol $fontCol");
          if (ptr.eatRParen()) {
            return ptr;
          } else {
            throw ChapterFormatException(
                'Unexpected char at end of font (${ptr.getChar(0)} pos=${ptr.start} [L4])',
                debugId: 'font');
          }
        } else {
          throw ChapterFormatException(
              'Unexpected char in font (${ptr.getChar(0)} pos=${ptr.start} [L3])',
              debugId: 'font');
        }
      } else {
        throw ChapterFormatException(
            'Unexpected char in font (${ptr.getChar(0)} pos=${ptr.start} [L2])',
            debugId: 'font');
      }
    } else {
      throw ChapterFormatException(
          'Unexpected char in font (${ptr.getChar(0)} pos=${ptr.start} [L1])',
          debugId: 'font');
    }
  }

  void parseFragFont(BufferPtr data) {
    // b += '('
    //already parsed

    // b += pack_font {
    // b += pack_text(font.family)
    // family = data.consumeText(leadingQuoteAlreadyParsed: false);
    // b += pack_untyped_uint(ffid)
    fontId = data.consumeTypedInt();
    // b += pack_untyped_float(font.size)
    size = data.consumeFloat32();
    // b += pack_wousi(font)
    wousi = parseWousiByte(data.consumeUint8());

    //   if font.hasBgCol():
    //   b += '&'
    if (data.consumeIf(Codes.AMPERSAND)) {
      //   b += pack_hex(font.bgCol)
      bgCol = data.consumeColor(throwOnFail: false);
      //     if font.hasColor():
      if (data.consumeIf(Codes.AMPERSAND)) {
        //     b += '&'

        //     b += pack_hex(font.fontCol)
        fontCol = data.consumeColor();
        // dev.log("(Bin) Read Frag.FontCol: $fontCol");
      }
    }
  }

  FontInterm convertToFontInterm() {
    return FontInterm(
        fileId: fontId ?? 0,
        size: size ?? 12,
        italic: wousi?.italic ?? false,
        weight: wousi?.weight,
        color: fontCol);
  }
}

class LiveTextHolder {
  String text = '';

  LiveTextHolder();

  LiveFont font = LiveFont();

  // @override
  // Widget element(BuildContext context) {
  //   return const CircularProgressIndicator();
  // }

  BufferPtr parseFont(BufferPtr data) {
    return font.parseFont(data);
  }

  TextHolder instantiate() {
    // a function that matches param amounts to object types
    if (font.isBody()) {
      if (font.changedAlign || font.tabs > 0) {
        return AlignedBodyText(text: text, align: font.align, tabs: font.tabs);
      }
      return BodyTextElement(text);
    } else if (font.bgCol != null) {
      FontInterm f = font.convertToFontInterm();
      return HiliteFontText(
          text: text,
          f,
          color: font.bgCol ?? errorBg,
          tabs: font.tabs,
          align: font.align);
    } else {
      FontInterm f = font.convertToFontInterm();
      return CustomFontText(text: text, f, tabs: font.tabs, align: font.align);
    }
  }

  HeaderOfText instantiateHeader() {
    if (font.isStandardHeader()) {
      return HeaderOfText(text: text);
    } else {
      return CustomHeaderOfText(
          text: text, font: font.convertToFontInterm(), align: font.align);
    }
  }
}

class LiveFragment extends FragOfText {
  String text = '';
  LiveFont font = LiveFont();

  @override
  InlineSpan span(BuildContext context) {
    return const WidgetSpan(child: CircularProgressIndicator());
  }

  FragOfText convert() {
    if (font.isBody()) {
      return FragBody(text);
    } else {
      FontInterm f = font.convertToFontInterm();
      return FragCustom(text, f, color: font.bgCol);
    }
  }
}

//Assumed to be a paragraph.
//TODO: I don't think this needs to extend Holder
// It may not need to be an object.
class LiveSpanOfText extends Holder {
  List<FragOfText> lines;
  TextAlign align;
  int tabs;
  LiveSpanOfText()
      : lines = [],
        align = TextAlign.left,
        tabs = 0;
  // LiveSpanOfText(this.lines, {this.align = TextAlign.left, this.tabs = 0});

  Iterable<FragOfText> mapFunc() sync* {
    for (var frag in lines) {
      if (frag is LiveFragment) {
        yield frag.convert();
      } else {
        yield frag;
      }
    }
  }

  List<FragOfText> convertLines() {
    return mapFunc().toList(growable: false);
  }

  SpanOfText convert() {
    return SpanOfText(spans: convertLines(), align: align, tabs: tabs);
  }

  @override
  Widget element(BuildContext context) {
    return const CircularProgressIndicator();
  }

  @override
  Widget fallback(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
