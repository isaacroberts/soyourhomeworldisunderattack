import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import 'holder_base.dart';
import 'span_holding_code.dart';

class TextPad extends StatelessWidget {
  final Widget child;
  const TextPad({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: const Key('txtPad'),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: child);
  }
}

class SliverTextPad extends StatelessWidget {
  final Widget sliver;
  const SliverTextPad({super.key, required this.sliver});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        key: const Key('slvTxtPad'),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        sliver: sliver);
  }
}

class HolderUtils {
  static String stripOutTextFromFrags(List<FragOfText> frags) {
    String text = '';
    for (FragOfText f in frags) {
      if (f is FragBody) {
        text += f.text;
      }
    }
    return text;
  }

  static String stripOutText(List<Holder> holders) {
    String text = '';
    for (Holder h in holders) {
      if (h is TextHolder) {
        text += h.text;
        text += '\n';
      } else if (h is SpanOfText) {
        text += stripOutTextFromFrags(h.spans);
        text += '\n';
      } else if (h is SpanHoldingCode) {
        text += stripOutText(h.spans);
        text += '\n';
      }
    }
    return text;
  }
}
