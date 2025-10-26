import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/frontend/components/button_state_property.dart';
import 'package:soyourhomeworld/frontend/debug/debug_pane_entry.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';
import 'package:soyourhomeworld/frontend/theme/base_colors.dart';

import '../../backend/chapter.dart';
import '../elements/holders/holder_base.dart';
import '../elements/holders/span_holding_code.dart';
import '../theme/timings.dart';

///As of Sept 5, 2025, this is slivers only
class TextHolderDebugSliver extends StatelessWidget {
  final TextHolder holder;
  //Showfonts is always true
  const TextHolderDebugSliver({super.key, required this.holder});

  String tooltipMessage() {
    String msg = holder.runtimeType.toString();
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    Widget sliver = holder.sliver(context);

    Widget debugIndicator = StdDebugButtonRow(
        key: const Key('spanDebugRow'),
        holder: holder,
        //No pane for debugWrap
        onTap: () {
          showDebugPane(context, holder);
        },
        horizontal: true,
        isCode: false,
        tooltipMessage: tooltipMessage());
    debugIndicator = SliverToBoxAdapter(child: debugIndicator);
    sliver = SliverMainAxisGroup(
        key: const Key("dbgWrapCol"), slivers: [sliver, debugIndicator]);

    // sliver = SliverCrossAxisGroup(key: const Key('spanDebugCol'), slivers: [
    //   sliver,
    //   SliverToBoxAdapter(child: SizedBox(width: 36, child: debugIndicator))
    // ]);
    return sliver;
  }
}

///As of Sept 5, 2025, this is slivers only
class HolderDebugSliver extends StatelessWidget {
  final Holder holder;
  //Showfonts is always true
  const HolderDebugSliver({super.key, required this.holder});

  String tooltipMessage() {
    String msg = holder.runtimeType.toString();
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    Widget sliver = holder.sliver(context);

    Widget debugIndicator = StdDebugButtonRow(
        key: const Key('spanDebugRow'),
        holder: holder,
        //No pane for debugWrap
        onTap: () {
          showDebugPane(context, holder);
        },
        horizontal: true,
        isCode: false,
        tooltipMessage: tooltipMessage());

    debugIndicator = SliverToBoxAdapter(child: debugIndicator);
    sliver = SliverMainAxisGroup(
        key: const Key("dbgWrapCol"), slivers: [sliver, debugIndicator]);

    return sliver;
  }
}

class CodeDebugSliver extends StatelessWidget {
  ///As of Sept 5, 2025, this is slivers only
  final bool showFonts;
  final Holder holder;
  const CodeDebugSliver(
      {super.key, required this.holder, required this.showFonts});

  String tooltipMessage() {
    String msg = holder.runtimeType.toString();
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    Widget sliver = holder.sliver(context);
    String message = tooltipMessage();

    if (holder is UnhandledSpanHoldingCode) {
      message = 'Unhandled: ${(holder as UnhandledSpanHoldingCode).clsname}';
      sliver = DecoratedSliver(
          key: const Key('unhandledCodeWrap'),
          decoration: BoxDecoration(
              // color: errorBg.withAlpha(128),
              border: Border.all(color: errorColor, width: 5)),
          sliver: SliverPadding(
              key: const Key('unhandledCodePad'),
              padding: const EdgeInsets.all(12),
              sliver: sliver));
    }
    Widget debugIndicator = StdDebugButtonRow(
        key: const Key('codeDebugIndicatorRow'),
        holder: holder,
        onTap: null,
        isCode: true,
        tooltipMessage: message);

    debugIndicator = SliverToBoxAdapter(child: debugIndicator);
    //Give CodeElement extra space
    sliver = SliverMainAxisGroup(
        key: const Key('codeDebugCol'), slivers: [sliver, debugIndicator]);
    return sliver;
  }
}

///Opens inspector pane, shows copy button
class StdDebugButtonRow extends StatelessWidget {
  final VoidCallback? onTap;
  final String tooltipMessage;
  final bool isCode;
  final bool horizontal;
  final Holder holder;

  const StdDebugButtonRow(
      {super.key,
      required this.onTap,
      required this.tooltipMessage,
      required this.isCode,
      required this.holder,
      this.horizontal = true});

  void copyText(BuildContext context) {
    String text = holder.toText();
    Clipboard.setData(ClipboardData(text: text));
    text = text.replaceAll('\n', ' ');
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
        showCloseIcon: true,
        content: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.copy_rounded),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                  child: Text(
                'Copied "$text"',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              )),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = ChapterProvider.partOf(context).primary.sc;

    final ButtonStyle buttonStyle = ButtonStyle(
        iconColor: ButtonTextColorProperty(iconColor),
        iconSize: const WidgetStatePropertyAll(12),
        minimumSize: const WidgetStatePropertyAll(Size(24, 24)),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(3)));

    List<Widget> children = [
      // const Divider(),

      Tooltip(
          key: const Key('dbiType'),
          waitDuration: const Duration(milliseconds: 0),
          // triggerMode: TooltipTriggerMode.manual,
          message: tooltipMessage,
          child: IconButton(
              key: const Key('dbiInspectOpen'),
              style: buttonStyle,
              onPressed: () => showDebugPane(context, holder),
              icon: const Icon(Icons.code))),
      //Bug report
      // if (isCode)
      //   Tooltip(
      //       key: const Key('dbiBRTT'),
      //       message: 'Bug report (not built yet)',
      //       child: IconButton(
      //           key: const Key('dbiBugReport'),
      //           style: buttonStyle,
      //           onPressed: () {},
      //           icon: const Icon(Icons.bug_report_rounded))),
      //Typo report
      // Tooltip(
      //     key: const Key('dbiEditorTT'),
      //     message: 'Report typo (not built yet)',
      //     child: IconButton(
      //         key: const Key('dbiEditorFlag'),
      //         style: buttonStyle,
      //         onPressed: null,
      //         icon: const Icon(
      //           Icons.edit_notifications,
      //         ))),
      //Copy text
      Tooltip(
          key: const Key('dbiCopyTT'),
          message: 'Copy text',
          child: IconButton(
              key: const Key('dbiCopy'),
              onPressed: () => copyText(context),
              style: buttonStyle,
              icon: const Icon(
                Icons.copy,
              ))),
      const SizedBox(width: 12),
    ];
    late Widget debugIndicator;
    if (horizontal) {
      debugIndicator = Row(
        key: const Key('dbiRow'),
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    } else {
      debugIndicator = Column(
        key: const Key('dbiCol'),
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      );
      // debugIndicator =
    }
    debugIndicator =
        SizedBox(key: const Key('dbiSize'), height: 24, child: debugIndicator);

    // debugIndicator =
    //     SliverToBoxAdapter(key: const Key('dbiStba'), child: debugIndicator);
    return debugIndicator;
  }
}

///Shows just the copy button
class BodyDebugSliver extends StatelessWidget {
  final BodyTextElement holder;
  const BodyDebugSliver({super.key, required this.holder});

  Widget button(BuildContext context) {
    Color iconColor = ChapterProvider.partOf(context).primary.sc;

    final ButtonStyle buttonStyle = ButtonStyle(
        iconColor: ButtonTextColorProperty(iconColor),
        iconSize: const WidgetStatePropertyAll(12),
        minimumSize: const WidgetStatePropertyAll(Size(24, 24)),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(3)));

    return Tooltip(
        key: const Key('dbiCopyTT'),
        message: holder.text,
        child: IconButton(
            key: const Key('dbiCopy'),
            onPressed: () => copyText(context, holder.text),
            style: buttonStyle,
            icon: const Icon(
              Icons.copy,
              size: 12,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        sliver: SliverToBoxAdapter(
            child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              //Body text to cover most
              Expanded(child: holder.element(context)),
              button(context),
            ])));
  }
}
