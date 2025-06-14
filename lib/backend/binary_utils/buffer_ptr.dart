import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'dart:ui';

import '../error_handler.dart';
import 'binary.dart';

class BufferPtr {
  int start = 0;
  int length = 0;
  final ByteBuffer buffer;
  late ByteData region;
  BufferPtr(this.buffer, {this.start = 0, int? length}) {
    //print('New BufferPtr: Start $start len $length buffer ${buffer.lengthInBytes}');
    region = buffer.asByteData(start, length);
    this.length = length ?? buffer.lengthInBytes;
    //print('\t New region: ${region} ${region.offsetInBytes}');
  }

  void update() {
    region = buffer.asByteData(start, length);
  }

  String toStr() {
    return "[$start-${start + length} / ${buffer.lengthInBytes}]";
  }

  bool hasMore() {
    return length > 0;
  }

  int get lengthInBytes => length;

  BufferPtr subset(int offset, int len) {
    return BufferPtr(buffer, start: start + offset, length: len);
  }

  bool typedCodeComparison(int i, var code) {
    if (code is int) {
      return region.getUint8(i) == code;
    } else if (code is String) {
      return region.getUint8(i) == code.codeUnitAt(0);
    } else if (code is Codes) {
      return region.getUint8(i) == code.code;
    } else {
      throw IdiotException(
          "Strange type in BufferPtr.typedCodeComparison($code ${code.runtimeType}) (pos=$start)");
    }
  }

  bool consumeIf(var code) {
    if (typedCodeComparison(0, code)) {
      consume(1);
      return true;
    }
    return false;
  }

  void assertConsume(var code, {required String debugId}) {
    if (typedCodeComparison(0, code)) {
      consume(1);
    } else {
      throw ChapterFormatException(
          'Expected $code in ChapterFormat (got ${getChar()} pos=$start)',
          debugId: debugId);
    }
  }

  void warnConsume(var code, {bool consumeOnMiss = false}) {
    if (typedCodeComparison(0, code)) {
      consume(1);
    } else {
      dev.log("Warning: Missed character. Expected $code, got ${getChar()}");
      if (consumeOnMiss) {
        consume(1);
      }
    }
  }

  // bool eatLParen() {
  //   if (getUint8(0) == Codes.LPAREN.code) {
  //     consumeUint8();
  //     return true;
  //   }
  //   return false;
  // }

  bool eatRParen() {
    if (getUint8(0) == Codes.RPAREN.code) {
      consumeUint8();
      return true;
    }
    return false;
  }

  bool eatAmpersand() {
    if (getUint8(0) == Codes.AMPERSAND.code) {
      consumeUint8();
      return true;
    }
    return false;
  }

  int getUint8([int offset = 0]) {
    return region.getUint8(offset);
  }

  int getInt32([int offset = 0]) {
    return region.getInt32(offset);
  }

  int getInt64([int offset = 0]) {
    return region.getInt64(offset);
  }

  double getFloat32([int offset = 0]) {
    return region.getFloat32(offset);
  }

  String getChar([int offset = 0]) {
    int d = region.getUint8(offset);
    return String.fromCharCode(d);
  }

  int consumeUint8() {
    var d = region.getUint8(0);
    consume(1);
    return d;
  }

  int consumeInt32() {
    var d = region.getInt32(0);
    consume(4);
    return d;
  }

  int consumeUint32() {
    var d = region.getUint32(0);
    consume(4);
    return d;
  }

  int consumeInt64() {
    var d = region.getInt64(0);
    consume(8);
    return d;
  }

  bool consumeBool() {
    int b = region.getUint8(0);
    consume(1);
    return b > 0;
  }

  double consumeFloat32() {
    var d = region.getFloat32(0);
    consume(4);
    return d;
  }

  String consumeChar() {
    int d = region.getUint8(0);
    consume(1);
    return String.fromCharCode(d);
  }

/*
-- struct values --
? = bool
B = short unsigned int
i = int
I = unsigned int
q = long int
f = float
c = char
x = none

-- custom --
{ = string
K = key (4s)
H = hex = BBBB
 */
  int? consumeTypedInt() {
    String typechar = consumeChar();
    if (typechar == 'B') {
      return consumeUint8();
    } else if (typechar == 'i') {
      return consumeInt32();
    } else if (typechar == 'q') {
      return consumeInt64();
    } else if (typechar == 'I') {
      return consumeUint32();
    } else if (typechar == 'x') {
      return null;
    } else {
      throw ChapterFormatException(
          "Unsupported int typechar $typechar (pos=$start)",
          debugId: '?');
    }
  }

  double? consumeTypedFloat() {
    String typechar = consumeChar();
    if (typechar == 'f') {
      return consumeFloat32();
    } else if (typechar == 'x') {
      return null;
    } else {
      throw ChapterFormatException(
          "Unsupported float typechar $typechar (pos=$start)",
          debugId: '?');
    }
  }

  String? consumeTypedChar() {
    String typechar = consumeChar();
    if (typechar == 'c') {
      return consumeChar();
    } else if (typechar == 'x') {
      return null;
    } else {
      throw ChapterFormatException("Unsupported character typechar $typechar",
          debugId: '?');
    }
  }

  bool? consumeTypedBool() {
    String typechar = consumeChar();
    if (typechar == '?') {
      return consumeBool();
    } else if (typechar == 'x') {
      return null;
    } else {
      throw ChapterFormatException(
          "Unsupported bool typechar $typechar (pos=$start)",
          debugId: '?');
    }
  }

  String? consumeKey() {
    if (consumeIf(Codes.APOSTROPHE)) {
      return readUntil(Codes.APOSTROPHE, includeChar: false);
    }
    return null;
  }

  Color? consumeColor({bool throwOnFail = false}) {
    String typechar = consumeChar();
    if (typechar == 'H') {
      // 'H' ARGB:BBBB
      int a = getUint8(0);
      int r = getUint8(1);
      int g = getUint8(2);
      int b = getUint8(3);
      consume(4);
      return Color.fromARGB(a, r, g, b);
    } else if (typechar == 'x' || typechar == 'X') {
      return null;
    } else {
      if (throwOnFail) {
        throw ChapterFormatException(
            "Unexpected typechar in color ($typechar $start)",
            debugId: '?');
      }
      return null;
    }
  }

  Uint8List toIntList() {
    return buffer.asUint8List(start, length);
  }

  void consume(int amt) {
    start += amt;
    length -= amt;
    update();
  }

  BufferPtr grabTokens(int amt) {
    var s = subset(start, amt);
    start += amt;
    length -= amt;
    update();
    return s;
  }

  BufferPtr consumeUntil(var charCode, {bool includeChar = false}) {
    int i = 0;
    while (i < length) {
      if (typedCodeComparison(i, charCode)) {
        var s = subset(0, i + (includeChar ? 1 : 0));
        start += i + 1;
        length -= i + 1;
        update();
        return s;
      }
      i++;
    }

    start = length;
    length = 0;
    update();
    throw ChapterFormatException("Run out of buffer on grabUntil",
        debugId: '?');
    return subset(0, region.lengthInBytes);
  }

  // BufferPtr consumeUntilParenMatched() {
  //   return _consumeUntilMatched(Codes.LPAREN.code, Codes.RPAREN.code);
  // }

  // BufferPtr consumeUntilGatorMatched() {
  //   return _consumeUntilMatched(Codes.LGATOR.code, Codes.RGATOR.code);
  // }

  String? consumeText({bool leadingQuoteAlreadyParsed = false}) {
    if (leadingQuoteAlreadyParsed || consumeIf(Codes.LBRACE)) {
      // dev.log("Read RBrace");

      String text = readUntil(Codes.RBRACE);
      // dev.log("Text: $text");
      //   "@OQ!")
      // text = text.replace('}', "@CQ!")
      text = text.replaceAll('@OQ!', '{');
      text = text.replaceAll('@CQ!', '}');
      return text;
    }
    // dev.log("No RBrace. Next= ${getChar()}");
    return null;
  }

  String? consumeUrl({bool leadingQuoteAlreadyParsed = false}) {
    if (leadingQuoteAlreadyParsed || consumeIf(Codes.LSQR)) {
      String text = readUntil(Codes.RSQR);
      // text = text.replaceAll('@OQ!', '{');
      // text = text.replaceAll('@CQ!', '}');
      return text;
    }
    return null;
  }

  String readUntil(var charCode, {bool includeChar = false}) {
    BufferPtr textBin = consumeUntil(charCode, includeChar: includeChar);
    return utf8.decode(textBin.toIntList());
  }

  bool consumeIfAsciiString(String str) {
    for (int n = 0; n < str.length; n++) {
      if (getChar(n) != str[n]) {
        return false;
      }
    }
    consume(str.length);
    return true;
  }

  void setToEnd() {
    start = length;
  }

  String asString([int length = 1]) {
    String s = '';
    for (int i = 0; i < length && i < this.length; i++) {
      s += getChar(i);
    }
    return s;
  }
}
