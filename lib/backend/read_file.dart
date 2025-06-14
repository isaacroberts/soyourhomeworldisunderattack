// import 'dart:io';

import 'package:flutter/foundation.dart';

class FileIfNonWeb {
  static ByteData getTestRigFile(String filename) {
    if (kIsWeb) {
      return ByteData(0);
    } else {
      // String root =
      //     "/home/titzak/Documents/McKinsey Plan/webapp/python_writer/generated/bin/";
      // File file = File(root + filename);
      // Uint8List bytes = file.readAsBytesSync();
      // return bytes.buffer.asByteData();
    }
    return ByteData(0);
  }
}
