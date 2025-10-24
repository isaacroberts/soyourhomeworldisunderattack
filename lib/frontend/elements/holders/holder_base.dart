import 'package:flutter/material.dart';
//DebugWrap / CodeDebugWrap
import 'package:soyourhomeworld/frontend/components/deferrals/debug_wrap.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

// ============ Base ============================

abstract class Holder {
  const Holder();

  //Must override
  @override
  toString() {
    //Only show some characters because this is for debugging
    String text = toText();
    if (text.length > 50) {
      text = text.substring(0, 50);
    }
    return '$runtimeType: {$text}';
  }

  ///Must be unique. Only use underscores as type_id
  String get id => hashCode.toString();
  String toText();
  Widget element(BuildContext context);

  Widget sliver(BuildContext context) {
    return SliverToText(key: Key(id), child: element(context));
  }

  ///Allowed on release mode
  ///Because CAN YOU IMAGINE if something only works in Debug

  Widget debugSliver(BuildContext context);

  Future load({required String? debugId}) async {
    ///DebugId is passed to FontLoader
    ///This way, I the author, can find where I used the offending font
    return null;
  }

  bool isLoaded() {
    return true;
  }

  //Sorry. Functionality.
  void sweepForColor(Color color, Color? repl);

  //Visual utilities

  static Widget fallbackWrap(Widget child) {
    return child;
  }
}

//Will add json data later
abstract class CodeHolder extends Holder {
  const CodeHolder();

  @override
  Widget debugSliver(BuildContext context) {
    ///Allowed on release mode
    ///Because CAN YOU IMAGINE if something only works in Debug
    return DeferredCodeWrap(holder: this, showFonts: true);
  }

  //No free labor, king.
  @override
  void sweepForColor(Color color, Color? repl) {}
}

bool shouldShowFonts(BuildContext context) {
  return ViewSettings.instance.showFonts;
}

class SliverToText extends StatelessWidget {
  final Widget child;
  const SliverToText({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        key: Key('Pad_$key'),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        sliver: SliverToBoxAdapter(key: const Key('Stba'), child: child));
  }
}
