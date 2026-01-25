import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';
import '../../parts/part.dart';
import '../../theme/base_text_theme.dart';
import '../holders/span_holding_code.dart';
import '../holders/textholders.dart';

/// Receipts. Bureaucratic forms at events
class ReceiptHolder extends SpanHoldingCode {
  const ReceiptHolder({required super.spans});
  ReceiptHolder.fromString({required String text})
      : super(spans: [BodyTextElement(text)]);

  @override
  String toText() {
    return spans.map((s) => s.toText()).join().replaceAll('_*', '\n');
  }

  String displayText() {
    return spans.map((s) => s.toText()).join('\n');
  }

  Widget receiptPage(BuildContext context, Part part) {
    // TextStyle style = part.bodyFont.copyWith(color: part.primary.s1);
    String text = displayText();
    TextStyle style = part.bodyFont.copyWith(
        //TODO: Load rock salt
        //Maybe don't bother - it just doesn't load if it's the first readthrough
        fontFamily: 'Rock Salt',
        fontWeight: FontWeight.w200,
        color: part.primary.s1);
    // text = text.replaceAll('_', '.');
    return Text(
      text,
      style: style,
      softWrap: true,
    );
    // return Column(
    //     children: _rows
    //         .map((r) => receiptRow(r, style, part.primary.s1))
    //         .toList(growable: false));
    // // return ListView.builder(
    // //     key: const Key('rcpList'),
    // //     itemBuilder: receiptRow);
  }

  @override
  Widget element(BuildContext context) {
    Part part = ChapterProvider.of(context).part;

    Widget child = receiptPage(context, part);

    child = Column(
      key: const Key('rcol'),
      children: [
        const SizedBox(
          height: 24,
        ),
        Transform.flip(
            key: const Key('rcpTFlip'),
            flipX: true,
            child: Text(
              'CVS',
              textAlign: TextAlign.left,
              style: appFont(
                  color: part.primary.sd,
                  fontSize: 24,
                  fontWeight: FontWeight.w900),
            )),
        Transform.flip(
            key: const Key('rcpSubtFlip'),
            flipX: true,
            child: Text(
              'Shop online at CVS.com',
              textAlign: TextAlign.left,
              style: appFont(
                color: part.primary.sd,
                fontSize: 12,
                // fontWeight: FontWeight.w900
              ),
            )),
        Text(
          key: const Key('rcpBrk'),
          '------------------------------------------',
          textAlign: TextAlign.left,
          style: appFont(
            color: part.primary.sd,
            fontSize: 12,
            // fontWeight: FontWeight.w900
          ),
        ),
        // Icon(
        //   Icons.medication,
        //   color: part.primary.s3,
        // ),
        const SizedBox(
          height: 24,
        ),
        child,
        Transform.flip(
            key: const Key('cvsFlip'),
            flipX: true,
            child: const CVSFooter(
              key: Key('csvFoot'),
            ))
      ],
    );

    return Align(
        key: const Key('rcpA'),
        alignment: Alignment.topLeft,
        child: Container(
            key: const Key('rcpCt'),
            width: 400,
            height: 300,
            decoration: BoxDecoration(
                color: part.primary.se,
                border: Border.all(color: part.primary.sa)),
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: SingleChildScrollView(
                key: const Key('rcpScroll'),
                controller: Scrollable.of(context).widget.controller,
                child: child)));
  }

  @override
  Widget sliver(BuildContext context) {
    // Part part = ChapterProvider.of(context).part;

    Widget child = element(context);

    child = SliverPadding(
        key: const Key('PadCtr'),
        padding: const EdgeInsets.only(left: 12, right: 12),
        sliver: SliverToBoxAdapter(key: const Key('RaisedCtt'), child: child));

    return child;
  }

  // @override
  // String toText() {
  //   return _rows.join('\n');
  // }
}

/*

 //This version is cleaned, but I didn't like it clean
class _Row {
  factory _Row.fromLine(String line) {
    int underscore = line.indexOf('_');
    if (underscore == -1) {
      return _Row(line, 0);
    } else {
      //This will eat lines
      return _Row(line.substring(0, underscore), line.length - underscore);
    }
  }
  _Row(this.name, this.blankLength);
  final String name;
  final int blankLength;
  int get lines => (blankLength ~/ 15).ceil();
  String get underscores => '_' * blankLength;
  @override
  String toString() {
    return '$name $underscores';
  }
}

/// Receipts. Bureaucratic forms at events
class ReceiptHolder extends CodeHolder {
  const ReceiptHolder._privateInstantiator({required List<_Row> rows})
      : _rows = rows;

  final List<_Row> _rows;
  factory ReceiptHolder.fromString(String string) {
    List<_Row> rows =
        string.split('\n').map((l) => _Row.fromLine(l)).toList(growable: false);
/*
    while (string.isNotEmpty) {
      // Find first underscore
      int underscores = string.indexOf('_');

      if (underscores == -1) {
        rows.add(_Row(string, 0));
        string = '';
      } else {
        //Inch underscores forward
        int lastUnderscore = underscores + 1;
        //While current Char is underscore
        while (lastUnderscore < string.length &&
            string.codeUnitAt(lastUnderscore) == 95) {
          //Advance
          lastUnderscore++;
        }
        //name = string[:underscore]
        //underscores = string[underscore:lastUnderscore]
        rows.add(_Row(
            string.substring(0, underscores), lastUnderscore - underscores));
        string = string.substring(lastUnderscore);
      }
    }
*/
    return ReceiptHolder._privateInstantiator(rows: rows);
  }

  static const String bottomText = """
  -------------------------------------
  Shop online at CVS.com.
  -------------------------------------
  """;

  Widget receiptRow(_Row row, TextStyle style, Color underscoreColor) {
    return Text(row.toString(), textAlign: TextAlign.start, style: style);
    double height = 24.0 * row.lines;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: CustomPaint(
            painter: _ReceiptPainter(color: underscoreColor, interval: 24),
            child: Container(
                alignment: Alignment.topLeft,
                height: height,
                child: Text(
                  row.name,
                  textAlign: TextAlign.start,
                  style: style,
                ))));
  }

  Widget receiptPage(BuildContext context, Part part) {
    // TextStyle style = part.bodyFont.copyWith(color: part.primary.s1);
    TextStyle style = part.bodyFont.copyWith(
        fontFamily: 'Rock Salt',
        fontWeight: FontWeight.w200,
        color: part.primary.s1);

    return Column(
        children: _rows
            .map((r) => receiptRow(r, style, part.primary.s1))
            .toList(growable: false));
    // return ListView.builder(
    //     key: const Key('rcpList'),
    //     itemBuilder: receiptRow);
  }

  @override
  Widget element(BuildContext context) {
    Part part = ChapterProvider.of(context).part;

    Widget child = receiptPage(context, part);

    child = Column(
      key: const Key('rcol'),
      children: [
        const SizedBox(
          height: 24,
        ),
        Transform.flip(
            key: const Key('rcpTFlip'),
            flipX: true,
            child: Text(
              'CVS',
              textAlign: TextAlign.left,
              style: appFont(
                  color: part.primary.sd,
                  fontSize: 24,
                  fontWeight: FontWeight.w900),
            )),
        Transform.flip(
            key: const Key('rcpSubtFlip'),
            flipX: true,
            child: Text(
              'Shop online at CVS.com',
              textAlign: TextAlign.left,
              style: appFont(
                color: part.primary.sd,
                fontSize: 12,
                // fontWeight: FontWeight.w900
              ),
            )),
        Text(
          key: const Key('rcpBrk'),
          '------------------------------------------',
          textAlign: TextAlign.left,
          style: appFont(
            color: part.primary.sd,
            fontSize: 12,
            // fontWeight: FontWeight.w900
          ),
        ),
        // Icon(
        //   Icons.medication,
        //   color: part.primary.s3,
        // ),
        const SizedBox(
          height: 24,
        ),
        child,
        Transform.flip(
            key: const Key('cvsFlip'),
            flipX: true,
            child: const CVSFooter(
              key: Key('csvFoot'),
            ))
      ],
    );

    return Align(
        key: const Key('rcpA'),
        alignment: Alignment.topLeft,
        child: Container(
            key: const Key('rcpCt'),
            width: 400,
            height: 300,
            decoration: BoxDecoration(
                color: part.primary.se,
                border: Border.all(color: part.primary.sa)),
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: SingleChildScrollView(
                key: const Key('rcpScroll'),
                controller: Scrollable.of(context).widget.controller,
                child: child)));
  }

  @override
  Widget sliver(BuildContext context) {
    // Part part = ChapterProvider.of(context).part;

    Widget child = element(context);

    child = SliverPadding(
        key: const Key('PadCtr'),
        padding: const EdgeInsets.only(left: 12, right: 12),
        sliver: SliverToBoxAdapter(key: const Key('RaisedCtt'), child: child));

    return child;
  }

  @override
  String toText() {
    return _rows.join('\n');
  }
}
*/
class CVSFooter extends StatelessWidget {
  const CVSFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Part part = Part.of(context);

    Color color = part.primary.sd;
    TextStyle style = appFont(color: color);
    TextStyle bold = style.copyWith(fontWeight: FontWeight.w800);

    return Column(
        key: const Key('rcol'),
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          _CVSRecyclingRow(key: const Key('recyc'), color: color),
          const SizedBox(
            height: 6,
          ),
          Text(
            '=================================================',
            style: style,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'TRIP SUMMARY. Today you saved: 1.38        Savings value: 20%',
            style: style,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            '=================================================',
            style: style,
          ),
          const SizedBox(
            height: 24,
          ),
        ]);
  }
}

class _CVSRecyclingRow extends StatelessWidget {
  const _CVSRecyclingRow({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('recyrow'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.recycling,
          color: color,
        ),
        Icon(
          Icons.recycling,
          color: color,
        ),
        Icon(
          Icons.recycling,
          color: color,
        ),
      ],
    );
  }
}

class _ReceiptPainter extends CustomPainter {
  const _ReceiptPainter({
    required this.color,
    required this.interval,
  });

  final Color color;
  final double interval;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()..color = color;

    //Start at first line below
    for (double y = interval; y <= size.height; y += interval) {
      linePaint.strokeWidth = (y % interval == 0.0)
          ? 1.0
          : (y % (interval) == 0.0)
              ? 0.5
              : 0.25;
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(_ReceiptPainter oldPainter) {
    return oldPainter.color != color || oldPainter.interval != interval;
  }

  @override
  bool hitTest(Offset position) => false;
}
