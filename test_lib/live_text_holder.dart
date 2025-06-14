import 'dart:developer' as dev;

import 'binary_unpacker.dart';
import 'text_data_structures.dart';

import 'styles.dart';

class LiveTextHolder extends TextHolder {
  String text = '';
  // Font? font;
  StyleType? fontId;

  String totext() {
  return text;
  }

  void parseFont(BufferPtr data) {
    /*
      this is the part between ()
      (tab align & font? & color? & hilite? )
     */
     print('Parsing font:');
     print(data.toIntList());
    var v1 = unpackValue(data);
    print("V1: $v1 ${v1.runtimeType}");
  }

  TextHolder convert() {
    return BodyTextElement(text);
  }

}
