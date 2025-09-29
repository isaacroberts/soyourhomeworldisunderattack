// import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'holder_base.dart';

class SpanHoldingCode extends CodeHolder {
  final List<Holder> spans;
  const SpanHoldingCode({required this.spans});

  @override
  String toText() {
    return spans.map((s) => s.toText()).join();
  }

  @override
  Future load({required String? debugId}) async {
    for (Holder span in spans) {
      if (!span.isLoaded()) {
        await span.load(debugId: debugId);
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
    return Column(
        key: const Key('SHC_col'),
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [for (Holder s in spans) s.element(context)]);
  }

  // Helper function
  Widget sliverSpans(BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) {
    return SliverMainAxisGroup(
        key: const Key('SHC_col'),
        slivers: [for (Holder s in spans) s.sliver(context)]);
  }

  @override
  Widget element(BuildContext context) {
    return renderSpans(context);
  }

  @override
  Widget sliver(BuildContext context) {
    return sliverSpans(context);
  }
}

class UnhandledSpanHoldingCode extends SpanHoldingCode {
  final String clsname;
  UnhandledSpanHoldingCode({required this.clsname, required super.spans});
}
