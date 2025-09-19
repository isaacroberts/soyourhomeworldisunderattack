import 'package:flutter/material.dart';
//DebugWrap / CodeDebugWrap
import 'package:soyourhomeworld/frontend/components/deferrals/debug_wrap.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import 'holder_utils.dart';

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
    bool showFonts = shouldShowFonts(context);
    if (showFonts) {
      return element(context);
    } else {
      return fallback(context);
    }
  }

  //Must override
  @override
  toString() {
    //Only show some characters because this is for debugging
    return '$runtimeType: {${toText().substring(0, 50)}}';
  }

  //Must be unique
  String get key => hashCode.toString();
  String toText();
  Widget element(BuildContext context);
  Widget fallback(BuildContext context);

  Widget sliver(BuildContext context) {
    bool showFonts = shouldShowFonts(context);
    Widget child = showFonts ? element(context) : fallback(context);
    Widget sliver =
        SliverToBoxAdapter(key: Key('holderStba_$key'), child: child);
    sliver = SliverTextPad(key: Key('holderPad_$key'), sliver: sliver);
    return sliver;
  }

  Widget debugSliver(BuildContext context) {
    ///Allowed on release mode
    ///Because CAN YOU IMAGINE if something only works in Debug
    return DeferredDebugWrap(holder: this, showFonts: true);
  }

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

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }

  @override
  Widget debugSliver(BuildContext context) {
    ///Allowed on release mode
    ///Because CAN YOU IMAGINE if something only works in Debug
    return DeferredCodeWrap(holder: this, showFonts: true);
  }
}

bool shouldShowFonts(BuildContext context) {
  return ViewSettings.instance.showFonts;
}
