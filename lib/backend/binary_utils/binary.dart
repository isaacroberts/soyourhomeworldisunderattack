// ignore_for_file: constant_identifier_names

import 'dart:ui';

import '../error_handler.dart';
import 'buffer_ptr.dart';

enum QuoteLevels { text, params, list }

enum Codes {
  NEWLINE(10),
  LPAREN(40),
  RPAREN(41),
  DQUOTE(34),
// #(35),
  DOLLARSIGN(36),
// %(37),
  AMPERSAND(38),
  APOSTROPHE(39),
  STAR(42),
  PLUS(43),
  COMMA(44),
  DASH(45),
  DOT(46),
  FWDSLASH(47),
  DIGIT0(48),
  COLON(58),
  SEMICOLON(59),
  LGATOR(60),
  EQ(61),
  RGATOR(62),
  QUESTIONMARK(63),
  ATSIGN(64),

  //Letters
  CAPITALA(65),

  NChar(78),

  //Syms
  LSQR(91),
  BACKSLASH(92),
  RSQR(93),
  CARAT(94),
// _(95),
// `(96),
  LOWERA(97),
  LBRACE(123),
  BAR(124),
  RBRACE(125),
  TILDE(126),
  ;

  final int code;
  const Codes(this.code);
  // bool operator=(dynamic value) {
  //   return code==value;
  // }
}

// String CHR(int x) {
//   return String.fromCharCode(x);
// }

TextAlign stringToAlign(String? c) {
  if (c == null) {
    return TextAlign.left;
  } else if (c == 'l') {
    return TextAlign.left;
  } else if (c == 'r') {
    return TextAlign.right;
  } else if (c == 'c') {
    return TextAlign.center;
  } else if (c == 'j') {
    return TextAlign.justify;
  } else {
    throw ChapterFormatException("Incorrect align character $c",
        debugId: '[?]');
  }
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

(dynamic, int) unpackValue(BufferPtr data) {
  // Data is arbitrarily long
  assert(data.hasMore());
  String typechar = String.fromCharCode(data.getUint8(0));

  switch (typechar) {
    case '?':
      return (data.getUint8(1) != 0, 2);
    case 'B':
      return (data.getUint8(1), 2);
    case 'i':
      return (data.getInt32(1), 5);
    case 'q':
      return (data.getInt64(1), 9);
    case 'f':
      return (data.getFloat32(1), 5);
    case 'c':
      int v = data.getUint8(1);
      return (String.fromCharCode(v), 2);
    case '{':
      int i = 1;
      while (i < data.lengthInBytes) {
        if (data.getUint8(i) == Codes.RBRACE.code) {
          return ("FUCK", i + 1);
        }
        i++;
      }
    // TODO: Improve this
    // String s = ;

    case 'H':
      int a = data.getUint8(1);
      int r = data.getUint8(2);
      int g = data.getUint8(3);
      int b = data.getUint8(4);
      int hex = (a >> 24) + (r >> 16) + (g >> 8) + b;
      return (hex, 5);
    case 'x':
      // TODO: Check that this consumes one extra bit
      return (null, 2);
  }
  return (null, 1);
}
