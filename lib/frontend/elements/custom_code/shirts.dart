import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../icons.dart';
import '../custom_code/code_holders.dart';
import '../holders/textholders.dart';

class Shirt extends SpanHoldingCode {
  late final Color color;
  final bool printExact;
  Shirt({required super.spans, this.printExact = false}) {
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
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        Container(
            color: color,
            height: 600,
            width: 400,
            alignment: Alignment.center,
            child: const SizedBox.shrink()),
        const Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              RpgAwesome.shield,
              color: Color(0xffffffff),
              size: 24,
            )),
        Center(
            child: super.renderSpans(context,
                crossAxisAlignment: CrossAxisAlignment.center))
      ],
    );
  }
}

class ChapterShirt extends Shirt {
  final String? link;
  ChapterShirt({required this.link, required super.spans, super.printExact});

  @override
  Widget element(BuildContext context) {
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
