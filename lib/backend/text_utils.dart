import 'dart:math' as math;

import 'package:flutter/material.dart';

//TODO: Move to smaller file
enum SubSuper {
  normal,
  subscript,
  superscript,
  ;

  bool get isNormal => this == normal;
  bool get special => this != normal;
}

class WousiByte {
  final int byte;
  const WousiByte(this.byte);

  static WousiByte fromValues(
      {required int weight,
      bool overline = false,
      bool underline = false,
      bool strikethrough = false,
      bool italic = false}) {
    assert(weight > 0 && weight <= 1000);
    assert(weight % 100 == 0);
    int byte = weight * 16;
    if (italic) {
      byte += 1;
    }
    if (strikethrough) {
      byte += 2;
    }
    if (underline) {
      byte += 4;
    }
    if (overline) {
      byte += 8;
    }
    return WousiByte(byte);
  }

/*
  500 = math.max(math.min(byte ~/ 16, 9), 1) * 100;
  5 = max(min(byte~/16, 9), 1)
*/
  ///Weight=500, not italic, no textDecorations
  const WousiByte.basic() : byte = 5 * 16;

  bool isBasic() {
    return byte == 5 * 16;
  }

  //TODO: test
  bool get hasDecorations => byte & 0xd > 0;

  bool get italic => (byte & 0x1) > 0;
  bool get strikethrough => (byte & 0x2) > 0;
  bool get underline => (byte & 0x4) > 0;
  bool get overline => (byte & 0x8) > 0;
  int get weight => math.max(math.min(byte ~/ 16, 9), 1) * 100;

  TextDecoration textDecoration() {
    //wwwwOUSI
    //11111111
    //OUS
    int bit = (byte & 0xf) ~/ 2;

    //What's funny is Flutter uses bits on the backend,
    //But it's private so I can't access it.
    //Also, the bits are out of order.
    switch (bit) {
      case 0x0:
        return TextDecoration.none;
      case 0x1:
        return TextDecoration.lineThrough;
      case 0x2:
        return TextDecoration.underline;
      case 0x3:
        return TextDecoration.combine(
            [TextDecoration.lineThrough, TextDecoration.underline]);
      case 0x4:
        return TextDecoration.overline;
      case 0x5:
        return TextDecoration.combine(
            [TextDecoration.overline, TextDecoration.lineThrough]);
      case 0x6:
        return TextDecoration.combine(
            [TextDecoration.overline, TextDecoration.underline]);
      case 0x7:
        return TextDecoration.combine([
          TextDecoration.overline,
          TextDecoration.lineThrough,
          TextDecoration.underline
        ]);
    }

    if (strikethrough) {
      if (underline) {
        return TextDecoration.combine(
            [TextDecoration.lineThrough, TextDecoration.underline]);
      }
      return TextDecoration.lineThrough;
    }
    if (underline) {
      return TextDecoration.underline;
    }
    if (overline) {
      return TextDecoration.overline;
    }
    return TextDecoration.none;
  }
}
