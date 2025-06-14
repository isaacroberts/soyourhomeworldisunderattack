import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/code_holders.dart';

import '../../styles.dart';
import '../holders/textholders.dart';

class GotoButtonHolder extends SpanHoldingCode {
  final String? link;
  final bool isChapter;

  const GotoButtonHolder(
      {required this.link, required super.spans, this.isChapter = true});

  void onPressed(BuildContext context) {
    if (link != null) {
      if (isChapter) {
        context.go('/search/$link');
      } else {
        context.go('/$link');
      }
    } else {
      dev.log("Null link");
    }
  }

  Widget _buttonText(BuildContext context) {
    dev.log("GotoButton: link=$link, isChapter=$isChapter");
    if (spans.isEmpty) {
      return Text(link ?? 'Go', style: bodyFont);
    } else {
      return Text(Holder.stripOutText(spans).trim(), style: bodyFont);
    }
  }

  @override
  Widget element(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Tooltip(
            waitDuration: const Duration(seconds: 2),
            message: link ?? '-',
            child: FilledButton.tonal(
                onPressed: () => link == null ? null : onPressed(context),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    child: _buttonText(context)))));
  }
}
