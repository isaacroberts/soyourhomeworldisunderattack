import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/readers/reader_builder.dart';

import '../../../../backend/chapter.dart';
import '../../elements/holders/holder_base.dart';
import '../../elements/holders/textholders.dart';

// ================ Reader (below scroller) ===============================

class ReaderScreen extends StatelessWidget {
  final Chapter chapter;
  final ScrollController scrollController;
  const ReaderScreen(
      {super.key, required this.chapter, required this.scrollController});

  Widget itemBuilder(BuildContext context, Holder holder, bool showFonts) {
    return holder.elementOrFallback(context, showFonts);
  }

  Widget? header(BuildContext context) {
    if (kDebugMode) {
      HeaderOfText? header = chapter.header;
      if (header == null) {
        return null;
      }
      return Tooltip(
        message: '${chapter.varName} - ${chapter.id}',
        waitDuration: const Duration(seconds: 2),
        child: header.element(context),
      );
    }
    return chapter.header?.element(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget? header = this.header(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ReaderBuilder(
          key: Key('RdrBldr_Chp${chapter.id}'),
          chapter: chapter,
          itemBuilder: itemBuilder,
          leadItems: [if (header != null) header],
          scrollController: scrollController,
        ));
  }
}
