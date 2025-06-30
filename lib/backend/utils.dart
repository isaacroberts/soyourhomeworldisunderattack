import 'dart:math';

import 'package:flutter/material.dart';

Random rNG = Random(13846268498318);

Color randomColor() {
  return Color.fromARGB(
      255, rNG.nextInt(255), rNG.nextInt(255), rNG.nextInt(255));
}
