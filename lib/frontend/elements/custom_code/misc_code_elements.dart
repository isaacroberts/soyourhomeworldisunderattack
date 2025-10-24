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
  IconHolder(int iconIndex) {
    icon = RpgAwesome.values[iconIndex];
  }

  @override
  String toText() {
    return '[Icon]';
  }

  @override
  Widget element(BuildContext context) {
    //TODO: Size & space
    return Icon(icon, size: 36, color: const Color(0x80000000));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverToBoxAdapter(child: element(context));
  }

  @override
  void sweepForColor(Color color, Color? repl) {}

  @override
  Widget debugSliver(BuildContext context) {
    //No other information available
    return sliver(context);
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
