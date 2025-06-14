import 'dart:math';

import 'package:flutter/material.dart';

Random RNG = Random(13846268498318);

Color randomColor() {
  return Color.fromARGB(
      255, RNG.nextInt(255), RNG.nextInt(255), RNG.nextInt(255));
}
