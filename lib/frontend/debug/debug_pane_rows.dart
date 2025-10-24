import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/font_interm.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ad_widget.dart';

import '../elements/holders/font_wanters.dart';
import '../elements/holders/holder_base.dart';
import '../elements/holders/span_holding_code.dart';
import '../elements/holders/textholders.dart';
import '../theme/base_text_theme.dart';
import 'debug_pane.dart';

///This file is only used by debug_pane.dart

///Nice sane colors for calm inspecting
const Color debugPaneColor = Color(0xff859f25);
const Color debugPaneDark = Color(0xff375125);
const Color debugPaneGrey = Color(0xff5b7149);
const Color debugPaneBg = Color(0xff2b2c2a);

const TextStyle debugFont = TextStyle(
    fontFamily: 'Andale Mono', fontSize: 12, fontWeight: FontWeight.w300);

///General inspector row
/// variableName: Value
class VariableInspectorRow extends StatelessWidget {
  final String varKey;
  final dynamic value;
  const VariableInspectorRow(
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

///Shows another holder
class SubHolderInspectorRow extends StatelessWidget {
  final Holder holder;
  const SubHolderInspectorRow({super.key, required this.holder});

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

///Button
///Example: Refresh
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

///Shows text, with SingleChildScroll
///And copyability
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

///Shows one main option to give idea, and also expands to show many options
///Example:
///         Font: Palatino
///Expanded:Font: Palatino
///         Size: 12
///         Color: Color(0xff)
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
        color: debugPaneDark,
        padding: EdgeInsets.zero,
        onPressed: _expand,
        child: widget.unexpanded,
      );
    } else {
      List<Widget> children = [];
      children.add(MaterialButton(
        key: const Key('ExpandToggle'),
        color: debugPaneColor,
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
                  color: debugPaneGrey,
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

///Shows a font specifically
class FontInspectorRow extends StatelessWidget {
  final FontInterm font;
  const FontInspectorRow({super.key, required this.font});

  @override
  Widget build(BuildContext context) {
    return ExpandoInspector(
        key: Key('Expando_Font${font.hashCode}'),
        startExpanded: true,
        unexpanded: VariableInspectorRow(varKey: 'Font', value: font.family),
        expanded: [
          VariableInspectorRow(varKey: 'Family', value: font.family),
          VariableInspectorRow(varKey: 'Id', value: font.fileId),
          VariableInspectorRow(varKey: 'URL', value: font.fileUrl),
          VariableInspectorRow(varKey: 'Load Status', value: font.loadStatus()),
          VariableInspectorRow(varKey: 'Size', value: font.size),
          VariableInspectorRow(varKey: 'Color', value: font.color),
          VariableInspectorRow(
              varKey: 'Wousi', value: font.wousi.byte.toRadixString(16)),
          VariableInspectorRow(varKey: 'Weight', value: font.weight),
          VariableInspectorRow(varKey: 'Overline', value: font.overline),
          VariableInspectorRow(varKey: 'Underline', value: font.underline),
          VariableInspectorRow(varKey: 'Strike', value: font.strikethrough),
          VariableInspectorRow(varKey: 'Italic', value: font.italic),
        ]);
  }
}

///Shows any Frag (which is not a Holder)
class FragInspector extends StatelessWidget {
  final FragOfText frag;
  const FragInspector(this.frag, {super.key});

  List<Widget> fuckoffIfLadder() {
    FragOfText frag = this.frag;
    if (frag is FragColoredBox) {
      return [
        VariableInspectorRow(varKey: 'width', value: frag.width),
        VariableInspectorRow(varKey: 'height', value: frag.height),
        VariableInspectorRow(varKey: 'color', value: frag.color),
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
        VariableInspectorRow(
            varKey: 'SubSuper',
            //Remove "SubSuper." from typename
            value: frag.subSuper.toString().split('.').last)
      ];
    } else if (frag is ColoredBoxFrag) {
      return [
        VariableInspectorRow(varKey: 'width', value: frag.width),
        VariableInspectorRow(varKey: 'height', value: frag.height),
        VariableInspectorRow(varKey: 'color', value: frag.color),
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
        unexpanded: VariableInspectorRow(
            varKey: 'Frag', value: frag.runtimeType.toString()),
        expanded: fuckoffIfLadder());
  }
}

///Uses the lists from the above ladders
///Lists all variables for all holders
class HolderDebugPaneContent extends StatelessWidget {
  final Holder holder;
  const HolderDebugPaneContent(this.holder, {super.key});

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
                  children: HolderDebugPaneContent.fuckoffIfLadder(holder),
                ))));
  }

  ///This function is fuckOff sized
  ///Lists all variables for all holders
  ///These are static so they can be used by outside classes
  static List<Widget> fuckoffIfLadder(Holder holder) {
    if (holder is NewlineElement) {
      return [VariableInspectorRow(varKey: 'height', value: holder.height)];
    } else if (holder is ColoredBoxHolder) {
      return [
        VariableInspectorRow(varKey: 'width', value: holder.width),
        VariableInspectorRow(varKey: 'height', value: holder.height),
        VariableInspectorRow(varKey: 'color', value: holder.color),
      ];
    } else if (holder is TextHolder) {
      return textIfLadder(holder);
    } else if (holder is SpanOfText) {
      List<Widget> w = [];
      for (FragOfText span in holder.spans) {
        w.add(FragInspector(span));
      }
      w.add(VariableInspectorRow(varKey: 'tabs', value: holder.tabs));
      w.add(VariableInspectorRow(varKey: 'align', value: holder.align));
      return w;
    } else if (holder is UnhandledSpanHoldingCode) {
      return [
        VariableInspectorRow(varKey: 'Class', value: holder.clsname),
        const VariableInspectorRow(varKey: 'Type', value: 'CodeBlock'),
        for (Holder span in holder.spans) SubHolderInspectorRow(holder: span)
      ];
    } else if (holder is HiddenTextElement) {
      return [
        const VariableInspectorRow(varKey: 'Text = ', value: "Hidden"),
      ];
    } else {
      return codeLadder(holder);
    }
  }

  ///Lists all variables for TextHolders
  ///These are static so they can be used by outside classes
  static List<Widget> textIfLadder(TextHolder holder) {
    Widget txtRw = TextInspectorRow(text: holder.text);

    if (holder is BodyTextElement) {
      return [txtRw];
    } else if (holder is AlignedBodyText) {
      return [
        txtRw,
        VariableInspectorRow(varKey: 'tabs', value: holder.tabs),
        VariableInspectorRow(varKey: 'align', value: holder.align),
      ];
    } else if (holder is HiliteFontText) {
      return [
        txtRw,
        VariableInspectorRow(varKey: 'tabs', value: holder.tabs),
        VariableInspectorRow(varKey: 'align', value: holder.align),
        VariableInspectorRow(varKey: 'color', value: holder.color),
        FontInspectorRow(font: holder.font),
      ];
    } else if (holder is CustomFontText) {
      return [
        txtRw,
        VariableInspectorRow(varKey: 'tabs', value: holder.tabs),
        VariableInspectorRow(varKey: 'align', value: holder.align),
        FontInspectorRow(font: holder.font),
      ];
    }
    return [txtRw];
  }

  ///Lists all variables for whichever CodeElements I needed to inspect 20 months ago
  static List<Widget> codeLadder(Holder holder) {
    if (holder is AdElementHolder) {
      return [
        VariableInspectorRow(varKey: 'color', value: holder.color),
        for (Holder span in holder.spans) SubHolderInspectorRow(holder: span)
      ];
    } else {
      return [
        const VariableInspectorRow(varKey: 'Not Implemented Yet', value: 'Sry'),
      ];
    }
  }
}
