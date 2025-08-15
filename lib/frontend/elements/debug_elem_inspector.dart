import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/font_interm.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ad_widget.dart';
import 'package:soyourhomeworld/frontend/theme/extra_colors.dart';

import '../theme/base_text_theme.dart';
import 'holders/holder_base.dart';
import 'holders/span_holding_code.dart';
import 'holders/textholders.dart';

const Color debugColor = Color(0xff259f56);
const Color debugDark = Color(0xff255137);
const Color debugGrey = Color(0xff49715b);

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
                child: Text(
              varKey,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: debugFont,
            )),
            Flexible(
                child: Text('($type):',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: debugFont.copyWith(color: const Color(0x8fffffff)),
                    textAlign: TextAlign.left)),
            Flexible(flex: 2, child: valueDisplay()),
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
    if (text.length > 50) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x80ffffff), width: 1)),
        height: 24 * 3,
        child: SizedBox.expand(
            child: SingleChildScrollView(
                child: Text(
          '"$text"',
          //
          style: bodyFont.copyWith(fontSize: 12),
        ))),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x80ffffff), width: 1)),
        height: 24,
        child: SizedBox.expand(
            child: Text(
          '"$text"',
          style: bodyFont.copyWith(fontSize: 12),
        )),
      );
    }
  }
}

class ExpandoInspector extends StatefulWidget {
  final Widget unexpanded;
  final List<Widget> expanded;
  final bool startExpanded;
  const ExpandoInspector(
      {required super.key,
      required this.unexpanded,
      required this.expanded,
      required this.startExpanded});

  @override
  State<ExpandoInspector> createState() => _ExpandoInspectorState();
}

class _ExpandoInspectorState extends State<ExpandoInspector> {
  bool expanded = false;

  @override
  void initState() {
    expanded = widget.startExpanded;
    super.initState();
  }

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
        key: const Key('ExpandToggle'),
        color: debugDark,
        padding: EdgeInsets.zero,
        onPressed: _expand,
        child: widget.unexpanded,
      );
    } else {
      List<Widget> children = [];
      children.add(MaterialButton(
        key: const Key('ExpandToggle'),
        color: debugColor,
        padding: EdgeInsets.zero,
        onPressed: _shrink,
        child: widget.unexpanded,
      ));
      for (Widget expand in widget.expanded) {
        children.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6), child: expand));
      }

      return Container(
          decoration: BoxDecoration(
              color: const Color(0x20000000),
              border: Border.all(
                  color: debugGrey,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children));
    }
  }
}

class FontInspectorRow extends StatelessWidget {
  final FontInterm font;
  const FontInspectorRow({super.key, required this.font});

  @override
  Widget build(BuildContext context) {
    return ExpandoInspector(
        key: Key('Expando_Font${font.hashCode}'),
        startExpanded: true,
        unexpanded: KeyValueInspectorRow(varKey: 'Font', value: font.family),
        expanded: [
          KeyValueInspectorRow(varKey: 'Family', value: font.family),
          KeyValueInspectorRow(varKey: 'Id', value: font.fileId),
          KeyValueInspectorRow(varKey: 'URL', value: font.fileUrl),
          KeyValueInspectorRow(varKey: 'Load Status', value: font.loadStatus()),
          KeyValueInspectorRow(varKey: 'Size', value: font.size),
          KeyValueInspectorRow(varKey: 'Color', value: font.color),
          KeyValueInspectorRow(
              varKey: 'Wousi', value: font.wousi.byte.toRadixString(16)),
          KeyValueInspectorRow(varKey: 'Weight', value: font.weight),
          KeyValueInspectorRow(varKey: 'Overline', value: font.overline),
          KeyValueInspectorRow(varKey: 'Underline', value: font.underline),
          KeyValueInspectorRow(varKey: 'Strike', value: font.strikethrough),
          KeyValueInspectorRow(varKey: 'Italic', value: font.italic),
        ]);
  }
}

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
    } else if (frag is FragSubSuper) {
      return [
        TextInspectorRow(text: frag.text),
        FontInspectorRow(font: frag.font),
        KeyValueInspectorRow(
            varKey: 'SubSuper',
            //Remove "SubSuper." from typename
            value: frag.subSuper.toString().split('.').last)
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
        key: Key('Expando_Frag${frag.hashCode}'),
        startExpanded: false,
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
            margin: const EdgeInsets.symmetric(horizontal: 5),
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
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          type,
                          maxLines: 1,
                          style: headerFont,
                        )),
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
            widthFactor: .75,
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
