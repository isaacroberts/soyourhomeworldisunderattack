// import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';

import '../../../backend/font_interm.dart';
import '../../../backend/text_utils.dart';
import '../../components/deferrals/debug_wrap.dart';

export 'misc_holders.dart';
export 'span_holders.dart';

// ======= Special Fonts ==============
abstract class FontWanterTextHolder extends TextHolder {
  FontInterm font;
  FontWanterTextHolder(this.font, {required super.text});

  @override
  Future load({required String? debugId}) {
    return font.load(debugId: debugId);
  }

  @override
  bool isLoaded() {
    // dev.log("Isloaded: ${font.family}");
    return font.isLoaded();
  }

  Widget loadingElement(BuildContext context) {
    return SizedBox(width: text.length * 5.0, height: font.size);
  }

  @override
  void sweepForColor(Color find, Color? repl) {
    if (font.color == null || font.color == find) {
      font = font.copyWithColor(repl);
    }
  }
}

// ========= Styles ======================
class CustomFontText extends FontWanterTextHolder {
  final TextAlign align;
  final int tabs;
  CustomFontText(super.font,
      {required super.text, this.align = TextAlign.start, this.tabs = 0});

  @override
  Future load({required String? debugId}) async {
    // await initHyphenation();
    return font.load(debugId: debugId);
  }

  @override
  bool isLoaded() {
    //TODO: Should check hyphenatorInitialized, which is currently private in textholders
    return font.isLoaded();
  }

  Widget textElement(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    if (font.size > 20) {
      if (screenWidth < 500) {
        //TODO: Large fonts should use word wrap

        return Text(
          text,
          style: font.instance(),
          // selectable: true,

          textAlign: align,
        );
      }
    }
    //Otherwise use regular text
    return Text(
      text,
      style: font.instance(),
      textAlign: align,
    );
  }

  @override
  Widget element(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: textElement(context));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverTabs(
        key: Key('Tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: textElement(context));
  }

  @override
  Widget debugSliver(BuildContext context) {
    return DeferredTextHolderDebugSliver(holder: this);
  }
}

class HiliteFontText extends FontWanterTextHolder {
  final TextAlign align;
  final Color color;
  final int tabs;
  HiliteFontText(super.font,
      {required super.text,
      required this.color,
      this.align = TextAlign.left,
      this.tabs = 0});

  @override
  Widget element(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.instanceWithColor(color), textAlign: align));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverTabs(
        key: Key('Tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.instanceWithColor(color), textAlign: align));
  }

  @override
  Widget debugSliver(BuildContext context) {
    //Calls sliver
    return DeferredTextHolderDebugSliver(holder: this);
  }
}

class SubSuperFontText extends FontWanterTextHolder {
  ///Covers all complex cases
  final TextAlign align;
  final Color color;
  final int tabs;
  final SubSuper subSuper;
  SubSuperFontText(super.font,
      {required super.text,
      required this.color,
      this.align = TextAlign.left,
      this.tabs = 0,
      required this.subSuper});

  Widget scriptAlign(BuildContext context) {
    if (subSuper == SubSuper.superscript) {
      TextStyle style = font.instanceWithColor(color);
      style = style.copyWith(
        fontSize: style.fontSize! / 2,
        height: 2,
      );
      return Align(
          alignment: Alignment.topLeft,
          child: Text(text, style: style, textAlign: align));
    } else if (subSuper == SubSuper.subscript) {
      TextStyle style = font.instanceWithColor(color);
      style = style.copyWith(fontSize: style.fontSize! / 2, height: 2);
      return Align(
          alignment: Alignment.bottomLeft,
          child: Text(text, style: style, textAlign: align));
    } else {
      return Text(text, style: font.instanceWithColor(color), textAlign: align);
    }
  }

  @override
  Widget element(BuildContext context) {
    return WrapInTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child: scriptAlign(context));
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverTabs(
        key: Key('tabs$hashCode'),
        tabs: tabs,
        align: align,
        child:
            Text(text, style: font.instanceWithColor(color), textAlign: align));
  }

  @override
  Widget debugSliver(BuildContext context) {
    //Calls sliver
    return DeferredTextHolderDebugSliver(holder: this);
  }
}
