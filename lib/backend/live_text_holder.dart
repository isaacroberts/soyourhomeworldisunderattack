import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/binary_utils/binary.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/backend/font_interm.dart';
import 'package:soyourhomeworld/backend/text_utils.dart';
import 'package:soyourhomeworld/frontend/theme/styles.dart';

import '../frontend/elements/holders/textholders.dart';
import 'binary_utils/buffer_ptr.dart';

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
  WousiByte? wousi;

  SubSuper subSuper = SubSuper.normal;

  bool isBody() {
    return (fontId == 0) &&
        (size == null || size == 12) &&
        (bgCol == null) &&
        (fontCol == null) &&
        (wousi?.isBasic() ?? true) &&
        (subSuper.isNormal);
  }

  bool isStandardHeader() {
    return (fontId == 1) &&
        (size == null || size == 24) &&
        (bgCol == null) &&
        (fontCol == null) &&
        (wousi?.isBasic() ?? true) &&
        (subSuper.isNormal);
  }

  WousiByte parseWousiByte(int byte) {
    //Weight Overline Underline Strikethru Italic
    return WousiByte(byte);
    // return Wousi.fromByte(byte);
  }

  void setWousiByte(int byte) {
    wousi = WousiByte(byte);
    // wousi = parseWousiByte(byte);
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

//TODO: Move parser to separate file from Wousi (which is needed for all text display)
  BufferPtr parseFont(BufferPtr ptr) {
    // dev.log('Font = ${ptr.start} ${ptr.getChar()}');
    if (ptr.getChar() == ';') {
      //No font - therefore: basic.
      // family = "Palatino";
      fontId = 0;
      size = 12;
      wousi = const WousiByte.basic();
      return ptr;
    } else {
      ptr.assertConsume('f', debugId: 'font');
      fontId = ptr.consumeUint32();
      ptr.assertConsume('s', debugId: 'font');
      size = ptr.consumeFloat32();
      ptr.assertConsume('w', debugId: 'font');
      int wousiByte = ptr.consumeUint8();
      wousi = parseWousiByte(wousiByte);
      String char = ptr.getChar(0);
      //Sub/super script
      if (char == '^') {
        subSuper = SubSuper.superscript;
        ptr.consume(1);
      } else if (char == 'v') {
        subSuper = SubSuper.subscript;
        ptr.consume(1);
      } else {
        subSuper = SubSuper.normal;
      }
      return ptr;
    }
  }

  void parseFragFont(BufferPtr data) {
    // b += '('
    //already parsed

    // b += pack_font {
    // b += pack_text(font.family)
    // family = data.consumeText(leadingQuoteAlreadyParsed: false);
    // b += pack_untyped_uint(ffid)
    data.assertConsume('f', debugId: 'font');
    fontId = data.consumeUint32();
    // b += pack_untyped_float(font.size)
    data.assertConsume('s', debugId: 'font');
    size = data.consumeFloat32();
    // b += pack_wousi(font)
    data.assertConsume('w', debugId: 'font');
    wousi = parseWousiByte(data.consumeUint8());

    //Sub/super
    if (data.getChar() == '^') {
      subSuper = SubSuper.superscript;
      data.consume(1);
    } else if (data.getChar() == 'v') {
      subSuper = SubSuper.subscript;
      data.consume(1);
    }

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

  FontInterm convertToFontInterm() {
    return FontInterm(
        fileId: fontId ?? 0,
        size: size ?? 12,
        wousi: wousi ?? const WousiByte.basic(),
        color: fontCol);
  }
}

class LiveTextHolder {
  String text = '';

  LiveTextHolder();

  LiveFont font = LiveFont();

  // @override
  // Widget element(BuildContext context) {
  //   return const TriWizardLoader();
  // }

  BufferPtr parseFont(BufferPtr data) {
    return font.parseFont(data);
  }

  TextHolder instantiate() {
    // a function that matches param amounts to object types
    // dev.log("Holder SubSuper = ${font.subSuper}");
    if (!font.subSuper.isNormal) {
      return SubSuperFontText(font.convertToFontInterm(),
          text: text,
          color: font.bgCol ?? Colors.transparent,
          subSuper: font.subSuper);
    }

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

class LiveFragment {
  String text = '';
  LiveFont font = LiveFont();

  LiveFragment();

  FragOfText convert() {
    if (!font.subSuper.isNormal) {
      return FragSubSuper(text, font.convertToFontInterm(),
          color: font.bgCol, subSuper: font.subSuper);
    } else if (font.isBody()) {
      return FragBody(text);
    } else {
      FontInterm f = font.convertToFontInterm();
      return FragCustom(text, f, bgColor: font.bgCol);
    }
  }
}

class FragWrapper extends LiveFragment {
  ///Wrapped to reduce polymorphism in LiveFragment
  final FragOfText frag;

  FragWrapper(this.frag);
  @override
  FragOfText convert() {
    return frag;
  }
}

//Assumed to be a paragraph.
class LiveSpanOfText {
  List<LiveFragment> lines;
  TextAlign align;
  int tabs;
  LiveSpanOfText()
      : lines = [],
        align = TextAlign.left,
        tabs = 0;
  // LiveSpanOfText(this.lines, {this.align = TextAlign.left, this.tabs = 0});

  Iterable<FragOfText> mapFunc() sync* {
    for (var frag in lines) {
      yield frag.convert();
    }
  }

  List<FragOfText> convertLines() {
    return mapFunc().toList(growable: false);
  }

  SpanOfText convert() {
    return SpanOfText(spans: convertLines(), align: align, tabs: tabs);
  }
}
