import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/elements/holders/span_holding_code.dart'
    show SpanHoldingCode;
import 'package:soyourhomeworld/frontend/icons.dart';

import '../../base_text_theme.dart';
import '../holders/holder_utils.dart';

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
      return Text(HolderUtils.stripOutText(spans).trim(),
          style: bodyFont.copyWith(color: HarveyColor.shade10));
    }
  }

  @override
  Widget element(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
            child: SizedBox(
                width: 600, height: 50, child: buttonItself(context))));
  }

  Widget buttonItself(BuildContext context) {
    return MaterialButton(
      color: HarveyColor.shade6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // iconAlignment: IconAlignment.start,
      onPressed: link == null ? null : () => onPressed(context),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            RpgAwesome.blaster,
            color: HarveyColor.shade1,
          ),
          const SizedBox(
            width: 12,
          ),
          _buttonText(context),
          // const SizedBox.shrink()
        ],
      ),
    );
    return Tooltip(
        waitDuration: const Duration(seconds: 2),
        message: link ?? '-',
        child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: HarveyColor.shade6,
            onPressed: () => link == null ? null : onPressed(context),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Go',
                            style: appFont.copyWith(
                                color: const Color(0x88ffffff)),
                            textAlign: TextAlign.center,
                          )),
                      Center(child: _buttonText(context))
                    ]))));
  }
}
