import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/sign.dart';

import '../../../backend/binary_utils/buffer_ptr.dart';
import '../../../backend/chapter_parser.dart';
import '../holders/holder_base.dart';

///We're not using this anywhere, I rewrote the only element to not use this
class Columns extends CodeHolder {
  /// Hacky as shit.
  /// Currently only supporting 2 columns
  final List<List<Holder>> cols;
  // final int cols;
  const Columns({required this.cols});

  @override
  String toText() {
    return cols.map((c) => c.map((h) => h.toText())).join('\n');
  }

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
  Widget sliver(BuildContext context) {
    // TODO: implement element

    return SliverToText(
        key: Key(id),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            for (List<Holder> col in cols)
              Flexible(child: renderCol(context, spans: col))
          ],
        ));
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

    return SignWidget(
        dark: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                child: renderCol(context,
                    spans: cols[0],
                    crossAxisAlignment: CrossAxisAlignment.end)),
            Flexible(
                child: renderCol(context,
                    spans: cols[1],
                    crossAxisAlignment: CrossAxisAlignment.start))
          ],
        ));
  }
}
