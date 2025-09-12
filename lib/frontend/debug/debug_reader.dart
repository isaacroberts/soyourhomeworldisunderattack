import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/readers/reader_builder.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../../backend/chapter.dart';
import '../elements/holders/holder_base.dart';
import '../elements/holders/span_holding_code.dart';
import '../elements/holders/textholders.dart';
//TODO: Defer
import 'debug_wrap.dart';

// ================ Debug scroller ===============================
class DebugReaderScreen extends StatelessWidget {
  const DebugReaderScreen({super.key});

  Widget mapFunc(BuildContext context, Holder t, bool showFonts) {
    //Don't wrap code elements in expensive viewers
    if (t is SpanHoldingCode) {
      return CodeDebugWrap(holder: t, showFonts: showFonts);
    }
    return DebugHolderWrap(holder: t, showFonts: showFonts);
  }

  Widget header(BuildContext context) {
    Chapter? chapter = Chapter.maybeOf(context);
    HeaderOfText? header = chapter?.data?.header;
    late final Widget element;
    if (header == null) {
      element = Text(
        '[${chapter?.varName}]',
        style: headerFont,
      );
    } else {
      element = header.element(context);
    }
    //Remove folder from filename
    String tooltip = chapter?.filename.split('/').last ?? '';
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
                  useSliverProtocol: false,
                  key: const Key('DbgRdrBldr_Chp'),
                  itemBuilder: mapFunc,
                  //TODO: You probably want some more lead items
                  leadItems: [debugNote(context), header],
                ))));
  }
}
