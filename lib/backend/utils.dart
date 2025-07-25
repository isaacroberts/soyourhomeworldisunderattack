import 'dart:math';

import 'package:flutter/material.dart';

Random rNG = Random(13846268498318);

enum DeviceSize {
  phone,
  phoneLandscape,
  desktop,
  watch;

  @override
  String toString() {
    return name;
  }
}

DeviceSize currentSize = DeviceSize.phone;
//TODO: Grab code
void checkDeviceSize(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  if (size.width < 800 || size.height < 1200) {}
}

Color randomColor() {
  return Color.fromARGB(
      255, rNG.nextInt(255), rNG.nextInt(255), rNG.nextInt(255));
}
