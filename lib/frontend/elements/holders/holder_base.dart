import 'package:flutter/material.dart';
// ============ Base ============================

abstract class Holder {
  const Holder();

  Widget elementOrFallback(BuildContext context, bool showFonts) {
    if (showFonts) {
      return element(context);
    } else {
      return fallback(context);
    }
  }

  Widget elementCheckingFallback(BuildContext context) {
    bool showFonts = IsFallbackProvider.shouldShowFonts(context);
    if (showFonts) {
      return element(context);
    } else {
      return fallback(context);
    }
  }

  String toText();
  Widget element(BuildContext context);
  Widget fallback(BuildContext context);

  //12 px of horiz padding will be added if true
//TODO: Replace this with a sliverElement() function
  ///And have the default include padding
  bool get wantsPadding => true;

  Future load({required String? debugId}) async {
    ///DebugId is passed to FontLoader
    ///This way, I the author, can find where I used the offending font
    return null;
  }

  bool isLoaded() {
    return true;
  }

  //Visual utilities

  static Widget fallbackWrap(Widget child) {
    return child;
  }
}

//Will add json data later
abstract class CodeHolder extends Holder {
  const CodeHolder();
//Default
  @override
  bool get wantsPadding => false;

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

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
