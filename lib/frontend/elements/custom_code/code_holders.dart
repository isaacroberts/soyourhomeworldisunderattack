// import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../holders/textholders.dart';

class IsFallbackProvider extends InheritedWidget {
  final bool showFonts;
  const IsFallbackProvider(
      {super.key, required this.showFonts, required super.child});

  static bool shouldShowFonts(BuildContext context) {
    return maybeOf(context)?.showFonts ?? true;
  }

  static IsFallbackProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<IsFallbackProvider>();
  }

  static IsFallbackProvider of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is IsFallbackProvider) {
      return showFonts == oldWidget.showFonts;
    } else {
      return true;
    }
  }
}

class SpanHoldingCode extends Holder {
  final List<Holder> spans;
  const SpanHoldingCode({required this.spans});

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
