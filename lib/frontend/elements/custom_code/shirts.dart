import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../icons.dart';
import '../holders/span_holding_code.dart';
import '../holders/textholders.dart';

class Shirt extends SpanHoldingCode {
  late final Color color;
  final bool printExact;
  final double width;
  final double height;
  Shirt(
      {required super.spans,
      double? width,
      double? height,
      this.printExact = false})
      : width = width ?? 500,
        height = height ?? 600 {
    color = firstHilite() ?? Colors.white;
  }

  Color? firstHilite() {
    if (spans.isNotEmpty) {
      for (var span in spans) {
        if (span is HiliteFontText) {
          return span.color;
        }
      }
    }
    return null;
  }

  @override
  Widget element(BuildContext context) {
    return Center(
        child: Transform.scale(
            scale: .75,
            child: ColoredBox(
                color: color,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: width,
                        maxWidth: width * 2,
                        minHeight: height),
                    child: super.renderSpans(context,
                        crossAxisAlignment: CrossAxisAlignment.center)))));
  }
}

class BumperSticker extends SpanHoldingCode {
  late final Color color;
  final bool printExact;
  final double width;
  final double height;
  BumperSticker(
      {required super.spans,
      this.printExact = false,
      double? width,
      double? height})
      : width = width ?? 800,
        height = height ?? 300 {
    color = firstHilite() ?? Colors.white;
  }

  Color? firstHilite() {
    if (spans.isNotEmpty) {
      for (var span in spans) {
        if (span is HiliteFontText) {
          return span.color;
        }
      }
    }
    return null;
  }

  @override
  Widget element(BuildContext context) {
    return Center(
        child: Container(
            color: color,
            height: 300,
            width: 800,
            alignment: Alignment.center,
            child: super.renderSpans(context,
                crossAxisAlignment: CrossAxisAlignment.center)));
  }
}

class ChapterShirt extends Shirt {
  final String? link;
  ChapterShirt({required this.link, required super.spans, super.printExact});

  @override
  Widget element(BuildContext context) {
    return super.element(context);
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        Container(
            color: color,
            height: 600,
            width: 400,
            child: const SizedBox.expand()),
        const Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              RpgAwesome.shield,
              color: Color(0xffffffff),
              size: 24,
            )),
        Center(
            child: MaterialButton(
                color: color,
                onPressed: () => context.go('/search/$link'),
                child: super.renderSpans(context,
                    crossAxisAlignment: CrossAxisAlignment.center)))
      ],
    );
  }
}
