import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/frontend/components/button_state_property.dart';
import 'package:soyourhomeworld/frontend/theme/base_colors.dart';

import '../../backend/chapter.dart';
import '../elements/debug_elem_inspector.dart' deferred as inspector_lib;
import '../elements/holders/holder_base.dart';
import '../elements/holders/span_holding_code.dart';

class DebugHolderWrap extends StatefulWidget {
  ///As of Sept 5, 2025, this is slivers only
  final Holder holder;
  final bool showFonts;
  const DebugHolderWrap(
      {super.key, required this.holder, required this.showFonts});

  @override
  State<DebugHolderWrap> createState() => _DebugHolderWrapState();
}

class _DebugHolderWrapState extends State<DebugHolderWrap> {
  bool hovered = false;

  String tooltipMessage() {
    String msg = widget.holder.runtimeType.toString();
    return msg;
  }

  void _onHovered(bool h) {
    setState(() {
      hovered = h;
    });
  }

  void tap() async {
    await inspector_lib.loadLibrary();
    if (mounted) {
      inspector_lib.showHolderInspectorDialog(context, widget.holder);
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: FallbackSliver; showFonts
    Widget sliver = widget.holder.sliver(context);

    if (hovered) {
      sliver = DecoratedSliver(
          key: const Key('debugSliverBorder'),
          decoration: BoxDecoration(
              color: widget.showFonts ? null : errorBg.withAlpha(128),
              border: Border.all(
                  color: const Color(0x44ffffff),
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside)),
          sliver: sliver);
    }

    Widget debugIndicator = DebugIndicatorRow(
        key: const Key('spanDebugRow'),
        holder: widget.holder,
        onTap: tap,
        onHovered: _onHovered,
        isCode: false,
        tooltipMessage: tooltipMessage());
    sliver = SliverMainAxisGroup(
        key: const Key("dbgWrapCol"), slivers: [sliver, debugIndicator]);
    return sliver;
  }
}

class CodeDebugWrap extends StatelessWidget {
  ///As of Sept 5, 2025, this is slivers only
  final bool showFonts;
  final Holder holder;
  const CodeDebugWrap(
      {super.key, required this.holder, required this.showFonts});

  String tooltipMessage() {
    String msg = holder.runtimeType.toString();
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Fallbacks
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
    Widget debugIndicator = DebugIndicatorRow(
        key: const Key('codeDebugIndicatorRow'),
        holder: holder,
        onTap: null,
        onHovered: null,
        isCode: true,
        tooltipMessage: message);
    sliver = SliverMainAxisGroup(
        key: const Key('codeDebugCol'), slivers: [sliver, debugIndicator]);
    return sliver;
  }
}

class DebugIndicatorRow extends StatelessWidget {
  final VoidCallback? onTap;
  final void Function(bool)? onHovered;
  final String tooltipMessage;
  final bool isCode;
  final Holder holder;
  const DebugIndicatorRow(
      {super.key,
      required this.onTap,
      required this.onHovered,
      required this.tooltipMessage,
      required this.isCode,
      required this.holder});

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

    Widget debugIndicator = Row(
        key: const Key('dbiRow'),
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(),
          Tooltip(
              key: const Key('dbiType'),
              waitDuration: const Duration(milliseconds: 0),
              // triggerMode: TooltipTriggerMode.manual,
              message: tooltipMessage,
              child: IconButton(
                  onPressed: () {},
                  style: buttonStyle,
                  icon: const Icon(Icons.code_rounded))),
          if (onTap != null)
            Tooltip(
                key: const Key('dbiInspectTT'),
                message: 'Inspector pane',
                child: IconButton(
                    key: const Key('dbiInspectOpen'),
                    style: buttonStyle,
                    onPressed: onTap,
                    icon: const Icon(Icons.backup_table_rounded))),
          if (isCode)
            Tooltip(
                key: const Key('dbiBRTT'),
                message: 'Bug report (not built yet)',
                child: IconButton(
                    key: const Key('dbiBugReport'),
                    style: buttonStyle,
                    onPressed: null,
                    icon: const Icon(Icons.bug_report_rounded))),
          Tooltip(
              key: const Key('dbiEditorTT'),
              message: 'Report typo (not built yet)',
              child: IconButton(
                  key: const Key('dbiEditorFlag'),
                  style: buttonStyle,
                  onPressed: null,
                  icon: const Icon(
                    Icons.edit_notifications,
                  ))),
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
        ]);
    debugIndicator =
        SizedBox(key: const Key('dbiSize'), height: 24, child: debugIndicator);

    debugIndicator =
        SliverToBoxAdapter(key: const Key('dbiStba'), child: debugIndicator);
    return debugIndicator;
  }
}
