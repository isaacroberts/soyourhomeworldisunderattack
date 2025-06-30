import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/font_interm.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ad_widget.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../base_text_theme.dart';
import 'holders/holder_base.dart';
import 'holders/span_holding_code.dart';
import 'holders/textholders.dart';

const TextStyle debugFont = TextStyle(
    fontFamily: 'Andale Mono', fontSize: 12, fontWeight: FontWeight.w300);

class KeyValueInspectorRow extends StatelessWidget {
  final String varKey;
  final dynamic value;
  const KeyValueInspectorRow(
      {super.key, required this.varKey, required this.value});

  Widget valueDisplay() {
    if (value is Color) {
      String colorValue = value.value.toRadixString(16);

      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: value,
              child: const SizedBox(width: 7, height: 7),
            ),
            const SizedBox(width: 3),
            Text(
              colorValue,
              style: debugFont,
            ),
          ]);
    }
    return SingleChildScrollView(
        child: Text(
      value.toString(),
      style: debugFont,
    ));
  }

  @override
  Widget build(BuildContext context) {
    String type = value.runtimeType.toString();
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x80ffffff), width: 1)),
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  '$varKey ($type):',
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: debugFont,
                )),
            Flexible(
              flex: 3,
              child: valueDisplay(),
            )
          ],
        ));
  }
}

class SubSpanInspectorRow extends StatelessWidget {
  final Holder holder;
  const SubSpanInspectorRow({super.key, required this.holder});

  void openSecondWindow(BuildContext context) {
    showHolderInspectorDialog(context, holder, nestLevel: 1);
  }

  @override
  Widget build(BuildContext context) {
    String type = holder.runtimeType.toString();
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x80ffffff), width: 1)),
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  '$type:',
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: debugFont,
                )),
            Flexible(
                flex: 3,
                child: FilledButton(
                    onPressed: () => openSecondWindow(context),
                    child: const Text('Inspect', style: debugFont)))
          ],
        ));
  }
}

class DebugButtonRow extends StatelessWidget {
  final String purpose;
  final VoidCallback onPressed;
  const DebugButtonRow(
      {super.key, required this.purpose, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x80ffffff), width: 1)),
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  purpose,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: debugFont,
                )),
            Flexible(
                flex: 3,
                child: FilledButton(
                    onPressed: onPressed,
                    child: Text(purpose, style: debugFont)))
          ],
        ));
  }
}

class TextInspectorRow extends StatelessWidget {
  final String text;
  const TextInspectorRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0x80ffffff), width: 1)),
      height: 24 * 3,
      child: SingleChildScrollView(
          child: Text(
        "'$text'",
        style: debugFont,
      )),
    );
  }
}

class ExpandoInspector extends StatefulWidget {
  final Widget unexpanded;
  final List<Widget> expanded;
  // final expanded;
  const ExpandoInspector(
      {super.key, required this.unexpanded, required this.expanded});

  @override
  State<ExpandoInspector> createState() => _ExpandoInspectorState();
}

class _ExpandoInspectorState extends State<ExpandoInspector> {
  bool expanded = false;
  void _expand() {
    if (!expanded) {
      setState(() {
        expanded = true;
      });
    }
  }

  void _shrink() {
    if (expanded) {
      setState(() {
        expanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!expanded) {
      return MaterialButton(
        color: errorColor,
        padding: EdgeInsets.zero,
        onPressed: _expand,
        child: widget.unexpanded,
      );
    } else {
      return MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: _shrink,
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: errorColor,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside)),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: widget.expanded)));
    }
  }
}

class FontInspectorRow extends StatelessWidget {
  final FontInterm font;
  const FontInspectorRow({super.key, required this.font});

  @override
  Widget build(BuildContext context) {
    return ExpandoInspector(
        unexpanded: KeyValueInspectorRow(varKey: 'Font', value: font.family),
        expanded: [
          KeyValueInspectorRow(varKey: 'Family', value: font.family),
          KeyValueInspectorRow(varKey: 'Id', value: font.fileId),
          KeyValueInspectorRow(varKey: 'URL', value: font.fileUrl),
          KeyValueInspectorRow(varKey: 'Load Status', value: font.loadStatus()),
          KeyValueInspectorRow(varKey: 'Size', value: font.size),
          KeyValueInspectorRow(varKey: 'Color', value: font.color),
          KeyValueInspectorRow(varKey: 'Weight', value: font.weight),
          KeyValueInspectorRow(varKey: 'Italic', value: font.italic),
        ]);
  }
}

/*
class StyleInspectorRow extends StatelessWidget {
  final StyleType style;
  const StyleInspectorRow({super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    TextStyle? font = styleTypeToStyle(style, context);
    if (font == null) {
      return KeyValueInspectorRow(varkey: 'StyleType', value: style.name);
    }

    return ExpandoInspector(
        unexpanded:
            KeyValueInspectorRow(varkey: 'StyleType', value: style.name),
        expanded: [
          KeyValueInspectorRow(varkey: 'StyleType', value: style.name),
          KeyValueInspectorRow(varkey: 'Family', value: font.fontFamily),
          KeyValueInspectorRow(varkey: 'Size', value: font.fontSize),
          KeyValueInspectorRow(varkey: 'Color', value: font.color),
          KeyValueInspectorRow(varkey: 'Weight', value: font.fontWeight),
          KeyValueInspectorRow(varkey: 'Italic', value: font.fontStyle),
        ]);
  }
}
*/
class FragInspector extends StatelessWidget {
  final FragOfText frag;
  const FragInspector(this.frag, {super.key});

  List<Widget> fuckoffIfLadder() {
    FragOfText frag = this.frag;
    if (frag is FragColoredBox) {
      return [
        KeyValueInspectorRow(varKey: 'width', value: frag.width),
        KeyValueInspectorRow(varKey: 'height', value: frag.height),
        KeyValueInspectorRow(varKey: 'color', value: frag.color),
      ];
    } else if (frag is FragBody) {
      return [
        TextInspectorRow(text: frag.text),
      ];
    } else if (frag is FragCustom) {
      return [
        TextInspectorRow(text: frag.text),
        FontInspectorRow(font: frag.font),
      ];
    } else if (frag is ColoredBoxFrag) {
      return [
        KeyValueInspectorRow(varKey: 'width', value: frag.width),
        KeyValueInspectorRow(varKey: 'height', value: frag.height),
        KeyValueInspectorRow(varKey: 'color', value: frag.color),
      ];
    } else {
      throw Exception(
          "Unhandled Frag type in FragInspector ${frag.runtimeType}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandoInspector(
        unexpanded: KeyValueInspectorRow(
            varKey: 'Frag', value: frag.runtimeType.toString()),
        expanded: fuckoffIfLadder());
  }
}

class HolderDataIfLadders {
  static List<Widget> textIfLadder(TextHolder holder) {
    Widget txtRw = TextInspectorRow(text: holder.text);

    if (holder is BodyTextElement) {
      return [txtRw];
    } else if (holder is AlignedBodyText) {
      return [
        txtRw,
        KeyValueInspectorRow(varKey: 'tabs', value: holder.tabs),
        KeyValueInspectorRow(varKey: 'align', value: holder.align),
      ];
    } else if (holder is HiliteFontText) {
      return [
        txtRw,
        KeyValueInspectorRow(varKey: 'tabs', value: holder.tabs),
        KeyValueInspectorRow(varKey: 'align', value: holder.align),
        KeyValueInspectorRow(varKey: 'color', value: holder.color),
        FontInspectorRow(font: holder.font),
      ];
    } else if (holder is CustomFontText) {
      return [
        txtRw,
        KeyValueInspectorRow(varKey: 'tabs', value: holder.tabs),
        KeyValueInspectorRow(varKey: 'align', value: holder.align),
        FontInspectorRow(font: holder.font),
      ];
    }
    // else if (holder is StyledText) {
    //   return [
    //     txtRw,
    //     KeyValueInspectorRow(varkey: 'tabs', value: holder.tabs),
    //     KeyValueInspectorRow(varkey: 'align', value: holder.align),
    //     StyleInspectorRow(style: holder.style),
    //   ];
    // } else if (holder is HiliteStyleText) {
    //   return [
    //     txtRw,
    //     KeyValueInspectorRow(varkey: 'tabs', value: holder.tabs),
    //     KeyValueInspectorRow(varkey: 'align', value: holder.align),
    //     StyleInspectorRow(style: holder.style),
    //   ];
    // }
    return [txtRw];
  }

  static List<Widget> codeLadder(Holder holder) {
    if (holder is AdElementHolder) {
      return [
        KeyValueInspectorRow(varKey: 'color', value: holder.color),
        for (Holder span in holder.spans) SubSpanInspectorRow(holder: span)
      ];
    } else {
      return [
        const KeyValueInspectorRow(varKey: 'Not Implemented Yet', value: 'Sry'),
      ];
    }
  }

  static List<Widget> fuckoffIfLadder(Holder holder) {
    if (holder is NewlineElement) {
      return [KeyValueInspectorRow(varKey: 'height', value: holder.height)];
    } else if (holder is ColoredBoxHolder) {
      return [
        KeyValueInspectorRow(varKey: 'width', value: holder.width),
        KeyValueInspectorRow(varKey: 'height', value: holder.height),
        KeyValueInspectorRow(varKey: 'color', value: holder.color),
      ];
    } else if (holder is TextHolder) {
      return textIfLadder(holder);
    } else if (holder is SpanOfText) {
      List<Widget> w = [];
      for (FragOfText span in holder.spans) {
        w.add(FragInspector(span));
      }
      w.add(KeyValueInspectorRow(varKey: 'tabs', value: holder.tabs));
      w.add(KeyValueInspectorRow(varKey: 'align', value: holder.align));
      return w;
    } else if (holder is UnhandledSpanHoldingCode) {
      return [
        KeyValueInspectorRow(varKey: 'Class', value: holder.clsname),
        const KeyValueInspectorRow(varKey: 'Type', value: 'CodeBlock'),
        for (Holder span in holder.spans) SubSpanInspectorRow(holder: span)
      ];
    } else if (holder is HiddenTextElement) {
      return [
        const KeyValueInspectorRow(varKey: 'Text = ', value: "Hidden"),
      ];
    } else {
      return codeLadder(holder);
    }
  }
}

class HolderInspectorNested extends StatelessWidget {
  final Holder holder;
  const HolderInspectorNested(this.holder, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        key: const Key("debugInspectorScrollView"),
        child: SizedBox(
            key: const Key('debugInspectorChildBox'),
            width: 580,
            // color: const Color(0xff111111),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 15, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: HolderDataIfLadders.fuckoffIfLadder(holder),
                ))));
  }
}

class HolderInspector extends StatefulWidget {
  final Holder holder;
  const HolderInspector({super.key, required this.holder});

  @override
  State<HolderInspector> createState() => _HolderInspectorState();
}

class _HolderInspectorState extends State<HolderInspector> {
  @override
  Widget build(BuildContext context) {
    String type = widget.holder.runtimeType.toString();

    return Dialog(
        shape: const RoundedRectangleBorder(),
        backgroundColor: HarveyColor.shade3,
        child: Container(
            width: 580,
            decoration: BoxDecoration(
              color: const Color(0xff111111),
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            // padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 0),
            child: SizedBox(
                width: 600,
                // height: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(type, style: headerFont),
                    // HeaderRow(header: HeaderOfText(type), readingLength: 1),
                    Expanded(child: HolderInspectorNested(widget.holder))
                  ],
                ))));
  }
}

class HolderDebugDialog extends PopupRoute {
  final Holder holder;
  final int nestLevel;

  HolderDebugDialog({required this.holder, required this.nestLevel}) : super();

  @override
  Color get barrierColor => const Color(0x00000000);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Barrier';

  @override
  bool get opaque => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // var offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
    //     .animate(animation);
    return Align(
        alignment: Alignment(1 - nestLevel * .1, 0 + nestLevel * .1),
        child: FractionallySizedBox(
            widthFactor: .5,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: HolderInspector(holder: holder))));
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}

showHolderInspectorDialog(BuildContext context, Holder holder,
    {int nestLevel = 0}) {
  Navigator.push(
      context, HolderDebugDialog(holder: holder, nestLevel: nestLevel));
}
