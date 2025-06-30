// import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import 'holder_base.dart';

// ============ Misc ============================

class NewlineElement extends Holder {
  final double height;
  const NewlineElement({required this.height});

  @override
  Widget element(BuildContext context) {
    return SizedBox(height: height);
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

class ColoredBoxHolder extends Holder {
  final double width;
  final double height;
  final Color color;
  const ColoredBoxHolder(
      {required this.width, required this.height, required this.color});

  @override
  Widget element(BuildContext context) {
    //Mark for debugging
    if (color.a < 40) {
      return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1), color: color),
          width: width,
          height: height,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero);
    }
    return Container(
        width: width,
        height: height,
        color: color,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero);
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

class ColoredBoxFrag extends FragOfText {
  final double width;
  final double height;
  final Color color;
  const ColoredBoxFrag(
      {required this.width, required this.height, required this.color});

  Widget _element(BuildContext context) {
    //Mark for debugging
    if (color.a < 40) {
      return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1), color: color),
          width: width,
          height: height,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero);
    }
    return Container(
        width: width,
        height: height,
        color: color,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero);
  }

  @override
  InlineSpan span(BuildContext context) {
    // TODO: implement span
    return WidgetSpan(child: _element(context));
  }

  @override
  InlineSpan fallback(BuildContext context) {
    return WidgetSpan(child: _element(context));
  }

  @override
  bool isLoaded() {
    return true;
  }
}

class PageBreakOfText extends Holder {
  const PageBreakOfText();

  @override
  Widget element(BuildContext context) {
    return const SizedBox(
      height: 240,
    );
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}
