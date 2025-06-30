import 'dart:developer' as dev;

import 'binary_unpacker.dart';
import 'text_data_structures.dart';

class LiveTextHolder extends TextHolder {
  String text = '';
  // Font? font;

  @override
  String totext() {
    return text;
  }

  void parseFont(BufferPtr data) {
    /*
      this is the part between ()
      (tab align & font? & color? & hilite? )
     */
    dev.log('Parsing font:');
    dev.log(data.toIntList().toString());
    var v1 = unpackValue(data);
    dev.log("V1: $v1 ${v1.runtimeType}");
  }

  TextHolder convert() {
    return BodyTextElement(text);
  }
}
