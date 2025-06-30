// import 'dart:math' as math;
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/chapter_parser.dart';
import 'package:soyourhomeworld/frontend/colors.dart';

import '../../../backend/binary_utils/buffer_ptr.dart';
import '../../icons.dart';
import '../holders/holder_base.dart';
import '../holders/span_holding_code.dart';

// =========== Misc Widgets ===============

Color? namedColors(String? str) {
  if (str == null) {
    return null;
  }
  str = str.toLowerCase().trim();
  switch (str) {
    case 'rachel':
      return rachelDarkColor;
    // case 'jellyfish':
    //
  }
  dev.log("Missing color name: $str");
  return null;
}

class IconHolder extends Holder {
  late final IconData icon;
  IconHolder(int iconIndex, List<String> params) {
    icon = RpgAwesome.values[iconIndex];
  }

  @override
  Widget element(BuildContext context) {
    return Icon(icon, size: 30, color: const Color(0x80000000));
  }

  @override
  Widget fallback(BuildContext context) {
    //Add a box so user knows there's supposed to be something there
    return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x44000000), width: 2)),

        //And then try to display it anyway
        child: element(context));
  }
}

class BGCodeElement extends SpanHoldingCode {
  final Color? color;
  const BGCodeElement({required super.spans, required this.color});

  static BGCodeElement fromString(String? str, {required List<Holder> spans}) {
    // Color? c = namedColors(str);
    return BGCodeElement(spans: spans, color: null);
  }
}

class ArtHolder extends SpanHoldingCode {
  const ArtHolder({required super.spans});

  @override
  Widget element(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: size.width, minHeight: size.height, maxWidth: size.width),
        child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: renderSpans(context)),
            )));
  }
}

class Ticket extends SpanHoldingCode {
  const Ticket({required super.spans});
}

class PollScreen extends SpanHoldingCode {
  const PollScreen({required super.spans});
}

class Terminal extends SpanHoldingCode {
  const Terminal({required super.spans});

  @override
  Widget element(BuildContext context) {
    return Container(
        color: const Color(0xff000044),
        // decoration: BoxDecoration(border: Border.all(width: 2)),
        child: super.element(context));
  }
}

class EndAudio extends Holder {
  const EndAudio();
  @override
  Widget element(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget fallback(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/*
class WHLAd extends Holder {
  const WHLAd();



  @override
  Widget element(BuildContext context) {
    return Container(
        color: const Color(0xffff5429),
        child: const SizedBox.shrink(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('July 4th', style: wHLDateFont, textAlign: TextAlign.center),
            Text('White House Lawn',
                style: wHLBonfireFont, textAlign: TextAlign.center),
            Text('Guns, cosplay, coolers, fireworks, fun!',
                style: wHLCTAFont, textAlign: TextAlign.center),
          ],
        )));
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

*/
class Columns extends Holder {
  /// Hacky as shit.
  /// Currently only supporting 2 columns
  final List<List<Holder>> cols;
  // final int cols;
  const Columns({required this.cols});

  static Columns parse(BufferPtr bin) {
    // b += pack_untyped_uint(len(self.columns))
    int lenCols = bin.consumeUint32();
    int numSpans = bin.consumeUint8();

    // b += pack_literal('[')
    bin.assertConsume('[', debugId: 'columns');
    List<List<Holder>> cols = [];
    while (bin.hasMore() && bin.getChar(0) == 'c') {
      // # c  len(col):uint   [spans...]
      // b += pack_untyped_char('c')
      bin.assertConsume('c', debugId: 'columns');
      // b += pack_untyped_uint(len(col))
      int lenThisCol = bin.consumeUint32();
      // b += pack_literal('[')
      bin.assertConsume('[', debugId: 'columns');
      // for span in col:
      List<Holder> col = [];

      // b += typedLine(span)
      ChapterParser parser = ChapterParser(debugId: 'Columns_obj', ptr: bin);
      while (bin.hasMore() && bin.getChar(0) != ']') {
        Holder holder = parser.readOneHolder();

        col.add(holder);
      }
      bin = parser.ptr;
      // b += pack_literal(']')
      bin.warnConsume(']');
      cols.add(col);
      // b += typedLine(span)
    }
    // b += pack_literal('];')
    bin.warnConsume(']');
    bin.warnConsume(';');

    return Columns(cols: cols);
  }

  // Helper function
  Widget renderCol(BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
      required List<Holder> spans}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [for (Holder s in spans) s.element(context)]);
  }

  @override
  Widget element(BuildContext context) {
    // TODO: implement element

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        for (List<Holder> col in cols)
          Flexible(child: renderCol(context, spans: col))
      ],
    );
  }

  @override
  Widget fallback(BuildContext context) {
    return IsFallbackProvider(showFonts: false, child: element(context));
  }
}

class _SignWidget extends StatelessWidget {
  final Widget? child;
  const _SignWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xff595145), border: Border.all(width: 2)),
        child: child);
  }
}

class Sign extends SpanHoldingCode {
  const Sign({required super.spans});

  @override
  Widget element(BuildContext context) {
    return _SignWidget(
        key: Key('Sign$hashCode'), child: super.element(context));
  }
}

class Sign2Cols extends Columns {
  const Sign2Cols({required super.cols});

  static Sign2Cols parse(BufferPtr bin) {
    Columns col = Columns.parse(bin);
    assert(col.cols.length == 2);
    return Sign2Cols(cols: col.cols);
  }

  // Helper function
  @override
  Widget renderCol(BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
      required List<Holder> spans}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [for (Holder s in spans) s.element(context)]);
  }

  @override
  Widget element(BuildContext context) {
    // TODO: implement element

    return _SignWidget(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            child: renderCol(context,
                spans: cols[0], crossAxisAlignment: CrossAxisAlignment.end)),
        Flexible(
            child: renderCol(context,
                spans: cols[1], crossAxisAlignment: CrossAxisAlignment.start))
      ],
    ));
  }
}

class Audio extends Holder {
  final String file;

  const Audio({required this.file});

  @override
  Widget element(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget fallback(BuildContext context) {
    return const Placeholder();
  }
}
