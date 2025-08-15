// import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'holder_base.dart';

class SpanHoldingCode extends Holder {
  final List<Holder> spans;
  const SpanHoldingCode({required this.spans});

  @override
  String toText() {
    return spans.map((s) => s.toText()).join();
  }

  @override
  Future load() async {
    for (Holder span in spans) {
      if (!span.isLoaded()) {
        await span.load();
      }
    }
    return null;
  }

  @override
  bool isLoaded() {
    for (Holder span in spans) {
      if (!span.isLoaded()) {
        return false;
      }
    }
    return true;
  }

  // Helper function
  Widget renderSpans(BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) {
    bool showFonts = IsFallbackProvider.shouldShowFonts(context);
    // dev.log("SpanHoldingCode showFonts=$showFonts");
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          for (Holder s in spans)
            showFonts ? s.element(context) : s.fallback(context)
        ]);
  }

  @override
  Widget element(BuildContext context) {
    return renderSpans(context);
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

class UnhandledSpanHoldingCode extends SpanHoldingCode {
  final String clsname;
  UnhandledSpanHoldingCode({required this.clsname, required super.spans});
}
