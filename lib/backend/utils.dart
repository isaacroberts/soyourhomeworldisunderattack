import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

Random rNG = Random(13846268498318);

int clampInt(int min, int i, int max) {
  if (i < min) {
    return min;
  }
  if (i > max) {
    return max;
  }
  return i;
}

double clampDouble(double min, double i, double max) {
  if (i < min) {
    return min;
  }
  if (i > max) {
    return max;
  }
  return i;
}

enum LoaderColorMode { normal, grey }

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

class SizeMeasuringBox extends StatelessWidget {
  const SizeMeasuringBox({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }

  Widget builder(BuildContext context, BoxConstraints constraints) {
    return Container(
        height:
            math.max(constraints.maxHeight, MediaQuery.of(context).size.height),
        color: const Color(0xaacccc66),
        alignment: Alignment.topRight,
        child: Text('${constraints.maxHeight}'));
  }
}
