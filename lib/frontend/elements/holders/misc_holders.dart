// import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/debug/debug_pane_entry.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import '../../../backend/chapter.dart';
import '../../parts/part.dart';
import 'holder_base.dart';

// ============ Misc ============================

class NewlineElement extends Holder {
  final double height;
  const NewlineElement({required this.height});

  @override
  String toText() {
    return '\n';
  }

  double get modHeight => height * 2;

  @override
  Widget element(BuildContext context) {
    // return SelectableNewline(height: height);
    return SizedBox(height: modHeight);
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverPadding(padding: EdgeInsets.only(bottom: modHeight));
  }

  @override
  Widget debugSliver(BuildContext context) {
    Part part = ChapterProvider.of(context).part;

    return SliverToBoxAdapter(
        key: Key('debugNewline_$id'),
        child: SizedBox(
            height: modHeight,
            child: Align(
                alignment: Alignment.topLeft,
                child: Tooltip(
                  message: 'NL: $height (mod to $modHeight)',
                  child: Container(
                    key: const Key('debugNewline'),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          vertical:
                              BorderSide(color: part.primary.s7, width: 1)),
                    ),
                    width: 24,
                    height: modHeight,
                    alignment: Alignment.centerLeft,
                    child: const SizedBox.expand(),
                  ),
                ))));
  }
}

class ColoredBoxHolder extends Holder {
  final double width;
  final double height;
  final Color color;
  const ColoredBoxHolder(
      {required this.width, required this.height, required this.color});

  @override
  String toText() {
    return ' ';
  }

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
  Widget sliver(BuildContext context) {
    //Max width
    return SliverConstrainedCrossAxis(
        maxExtent: width,
        sliver: DecoratedSliver(
          decoration: BoxDecoration(color: color),
          sliver: SliverPadding(padding: EdgeInsets.only(top: height)),
        ));
  }

  @override
  Widget debugSliver(BuildContext context) {
    return SliverConstrainedCrossAxis(
        maxExtent: width,
        sliver: DecoratedSliver(
          decoration: BoxDecoration(color: color),
          sliver: SliverToBoxAdapter(
              child: SizedBox(
            height: height,
            child: IconButton(
                onPressed: () => showDebugPane(context, this),
                icon: const Icon(
                  Icons.code,
                )),
          )),
        ));
  }
}

class ColoredBoxFrag extends FragOfText {
  final double width;
  final double height;
  final Color color;
  const ColoredBoxFrag(
      {required this.width, required this.height, required this.color});

  @override
  String toText() {
    return ' ';
  }

  Widget _element(BuildContext context) {
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
  bool isLoaded() {
    return true;
  }
}

class HiddenTextElement extends Holder {
  const HiddenTextElement();

  @override
  String toText() {
    return '';
  }

  @override
  Widget element(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget sliver(BuildContext context) {
    return const SliverPadding(padding: EdgeInsets.zero);
  }

  @override
  Widget debugSliver(BuildContext context) {
    return const SliverToBoxAdapter(
        child: Tooltip(
            message: 'HiddenTextElement',
            child: Icon(
              Icons.hide_source,
              size: 12,
            )));
  }
}

class PageBreakOfText extends Holder {
  const PageBreakOfText();

  @override
  String toText() {
    return '';
  }

  @override
  Widget element(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  sliver(BuildContext context) {
    return const SliverPadding(padding: EdgeInsets.zero);
  }

  @override
  Widget debugSliver(BuildContext context) {
    return const DecoratedSliver(
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: Color(0xffffffff)))),
        sliver: SliverPadding(padding: EdgeInsets.only(top: 24)));
  }
}
