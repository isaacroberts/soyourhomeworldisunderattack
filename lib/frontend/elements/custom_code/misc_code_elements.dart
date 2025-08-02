// import 'dart:math' as math;
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/extra_colors.dart';

import '../../icons.dart';
import '../holders/holder_base.dart';
import '../holders/span_holding_code.dart';

// =========== Misc Widgets ===============

Color? namedColors(String? str) {
  if (str == null) {
    return null;
  }
  str = str.toLowerCase().trim();
  switch (str) {
    case 'rachel':
      return rachelDarkColor;
    // case 'jellyfish':
    //
  }
  dev.log("Missing color name: $str");
  return null;
}

class IconHolder extends Holder {
  late final IconData icon;
  IconHolder(int iconIndex, List<String> params) {
    icon = RpgAwesome.values[iconIndex];
  }

  @override
  Widget element(BuildContext context) {
    return Icon(icon, size: 30, color: const Color(0x80000000));
  }

  @override
  Widget fallback(BuildContext context) {
    //Add a box so user knows there's supposed to be something there
    return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x44000000), width: 2)),

        //And then try to display it anyway
        child: element(context));
  }
}

class BGCodeElement extends SpanHoldingCode {
  final Color? color;
  const BGCodeElement({required super.spans, required this.color});

  static BGCodeElement fromString(String? str, {required List<Holder> spans}) {
    // Color? c = namedColors(str);
    return BGCodeElement(spans: spans, color: null);
  }
}

class Ticket extends SpanHoldingCode {
  const Ticket({required super.spans});
}

class PollScreen extends SpanHoldingCode {
  const PollScreen({required super.spans});
}

class Terminal extends SpanHoldingCode {
  const Terminal({required super.spans});

  @override
  Widget element(BuildContext context) {
    return Container(
        color: const Color(0xff000044),
        // decoration: BoxDecoration(border: Border.all(width: 2)),
        child: super.element(context));
  }
}

class EndAudio extends Holder {
  const EndAudio();
  @override
  Widget element(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget fallback(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/*
class WHLAd extends Holder {
  const WHLAd();



  @override
  Widget element(BuildContext context) {
    return Container(
        color: const Color(0xffff5429),
        child: const SizedBox.shrink(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('July 4th', style: wHLDateFont, textAlign: TextAlign.center),
            Text('White House Lawn',
                style: wHLBonfireFont, textAlign: TextAlign.center),
            Text('Guns, cosplay, coolers, fireworks, fun!',
                style: wHLCTAFont, textAlign: TextAlign.center),
          ],
        )));
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

*/

class Audio extends Holder {
  final String file;

  const Audio({required this.file});

  @override
  Widget element(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget fallback(BuildContext context) {
    return const Placeholder();
  }
}
