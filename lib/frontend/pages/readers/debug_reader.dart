import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/readers/reader_builder.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/styles.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../../../backend/chapter.dart';
import '../../elements/debug_elem_inspector.dart' deferred as inspector_lib;
import '../../elements/holders/holder_base.dart';
import '../../elements/holders/span_holding_code.dart';
import '../../elements/holders/textholders.dart';

typedef ChangeChapterCallback = void Function(int);

// ================ Debug scroller ===============================
class DebugReaderScreen extends StatelessWidget {
  final Chapter chapter;
  const DebugReaderScreen({super.key, required this.chapter});

  Widget mapFunc(BuildContext context, Holder t, bool showFonts) {
    //Don't wrap code elements in expensive viewers
    if (t is SpanHoldingCode) {
      return CodeDebugWrap(elem: t, showFonts: showFonts);
    }
    return DebugHolderWrap(elem: t, showFonts: showFonts);
  }

  Widget header(BuildContext context) {
    HeaderOfText? header = chapter.header;
    late final Widget element;
    if (header == null) {
      element = Text(
        '[${chapter.varName}]',
        style: headerFont,
      );
    } else {
      element = header.element(context);
    }
    //Remove folder from filename
    String tooltip = chapter.filename.split('/').last;
    return Tooltip(
        message: tooltip,
        waitDuration: const Duration(seconds: 1),
        child: element);
  }

  Widget debugNote(BuildContext context) {
    return ColoredBox(
        color: const Color(0x42000000),
        child: SizedBox(
            height: 35,
            child: Center(
                child: Text(
              "[ Debug Inspector ]",
              style: bodyFont.copyWith(fontSize: 8, color: labelTextColor),
            ))));
  }

  Widget leadHud(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
              value: ViewSettings.instance.showFonts,
              onChanged: (b) => ViewSettings.instance.showFonts = b)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget header = this.header(context);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ReaderBuilder(
                  scrollController: null,
                  key: Key('DbgRdrBldr_Chp${chapter.id}'),
                  chapter: chapter,
                  itemBuilder: mapFunc,
                  //TODO: You probably want some more lead items
                  leadItems: [debugNote(context), header],
                ))));
  }
}

class DebugHolderWrap extends StatefulWidget {
  final Holder elem;
  final bool showFonts;
  const DebugHolderWrap(
      {super.key, required this.elem, required this.showFonts});

  @override
  State<DebugHolderWrap> createState() => _DebugHolderWrapState();
}

class _DebugHolderWrapState extends State<DebugHolderWrap> {
  bool hovered = false;

  String tooltipMessage() {
    String msg = widget.elem.runtimeType.toString();
    return msg;
  }

  void _onHovered(bool h) {
    setState(() {
      hovered = h;
    });
  }

  void tap() async {
    await inspector_lib.loadLibrary();
    inspector_lib.showHolderInspectorDialog(context, widget.elem);
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

    return Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: tooltipMessage(),
        child: InkWell(
            // enableFeedback: true,
            // onTriggered: _onHovered,
            // richMessage: TextSpan(text: Holder.stripOutText([widget.elem])),
            // message: tooltipMessage(),
            onHover: _onHovered,
            onTap: tap,
            child: Container(
              alignment: Alignment.topLeft,
              decoration: (hovered)
                  ? BoxDecoration(
                      color: widget.showFonts ? null : errorBg.withAlpha(128),
                      border: Border.all(
                          color: const Color(0x44ffffff),
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside))
                  : null,
              child: widget.showFonts
                  ? widget.elem.element(context)
                  : widget.elem.fallback(context),
            )));
  }
}

class CodeDebugWrap extends StatelessWidget {
  final bool showFonts;
  final Holder elem;
  const CodeDebugWrap({super.key, required this.elem, required this.showFonts});

  String tooltipMessage() {
    String msg = elem.runtimeType.toString();
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    if (elem is UnhandledSpanHoldingCode) {
      return Container(
          decoration: BoxDecoration(
              // color: errorBg.withAlpha(128),
              border: Border.all(color: errorColor, width: 5)),
          padding: const EdgeInsets.all(15),
          child: Tooltip(

              // waitDuration: const Duration(milliseconds: 10),
              message:
                  'Unhandled: ${(elem as UnhandledSpanHoldingCode).clsname}',
              child:
                  showFonts ? elem.element(context) : elem.fallback(context)));
    }
    return Tooltip(
        // waitDuration: const Duration(milliseconds: 10),
        message: tooltipMessage(),
        child: showFonts ? elem.element(context) : elem.fallback(context));
  }
}
