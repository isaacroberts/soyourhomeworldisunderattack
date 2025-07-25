import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/readers/reader_builder.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../../../../backend/chapter.dart';
import '../../elements/debug_elem_inspector.dart';
import '../../elements/holders/holder_base.dart';
import '../../elements/holders/span_holding_code.dart';

typedef ChangeChapterCallback = void Function(int);

// ================ Debug scroller ===============================
class DebugReaderScreen extends StatelessWidget {
  final Chapter chapter;
  const DebugReaderScreen({super.key, required this.chapter});

  Widget mapFunc(BuildContext context, Holder t, bool isFallback) {
    //Don't wrap code elements in expensive viewers
    if (t is SpanHoldingCode) {
      return CodeDebugWrap(elem: t, isFallback: isFallback);
    }
    return DebugHolderWrap(elem: t, isFallback: isFallback);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ReaderBuilder(
            scrollController: null,
            key: Key('DbgRdrBldr_Chp${chapter.id}'),
            chapter: chapter,
            itemBuilder: mapFunc));
  }
}

class DebugHolderWrap extends StatefulWidget {
  final Holder elem;
  final bool isFallback;
  const DebugHolderWrap(
      {super.key, required this.elem, required this.isFallback});

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

  void tap() {
    showHolderInspectorDialog(context, widget.elem);
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

    return Tooltip(
        message: tooltipMessage(),
        child: InkWell(
            // enableFeedback: true,
            // onTriggered: _onHovered,
            // richMessage: TextSpan(text: Holder.stripOutText([widget.elem])),
            // message: tooltipMessage(),
            onHover: _onHovered,
            onTap: tap,
            child: Container(
              decoration: (hovered)
                  ? BoxDecoration(
                      color: widget.isFallback ? errorBg.withAlpha(128) : null,
                      border: Border.all(
                          color: const Color(0x44ffffff),
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside))
                  : null,
              child: widget.isFallback
                  ? widget.elem.fallback(context)
                  : widget.elem.element(context),
            )));
  }
}

class CodeDebugWrap extends StatelessWidget {
  final bool isFallback;
  final Holder elem;
  const CodeDebugWrap(
      {super.key, required this.elem, required this.isFallback});

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
                  isFallback ? elem.fallback(context) : elem.element(context)));
    }
    return Tooltip(
        // waitDuration: const Duration(milliseconds: 10),
        message: tooltipMessage(),
        child: isFallback ? elem.fallback(context) : elem.element(context));
  }
}
