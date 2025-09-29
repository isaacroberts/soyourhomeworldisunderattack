import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/chapter.dart';
import 'package:soyourhomeworld/frontend/elements/holders/span_holding_code.dart';

import '../../icons.dart';
import '../../parts/part.dart';

/// For CodeElements that just have backgrounds
abstract class RaisedSpanHolder extends SpanHoldingCode {
  const RaisedSpanHolder({required super.spans});

  Color color(Part part);
  Color border(Part part);
  EdgeInsets get outerPad;
  EdgeInsets get padding;
  double get borderRadius;
  Icon? buildIcon(BuildContext context);

  @override
  Widget sliver(BuildContext context) {
    Part part = ChapterProvider.of(context).part;
    return SliverPadding(
        key: const Key("RaisedMargin"),
        padding: outerPad,
        sliver: DecoratedSliver(
            key: const Key('RaisedSpanCtr'),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: color(part),
              border: Border.all(color: border(part), width: 1),
            ),
            sliver: SliverMainAxisGroup(key: const Key('IconCol'), slivers: [
              SliverToBoxAdapter(
                key: const Key('IconBox'),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: buildIcon(context))),
              ),
              SliverPadding(
                  key: const Key('PadCtr'),
                  padding: padding,
                  sliver: SliverToBoxAdapter(
                      key: const Key('RaisedCtt'),
                      child: renderSpans(context,
                          crossAxisAlignment: CrossAxisAlignment.start))),
            ])));
  }
}

/// For reading the speech of a Youtube video
class YoutubeTranscriptHolder extends RaisedSpanHolder {
  YoutubeTranscriptHolder({required super.spans});

  @override
  Color color(Part part) {
    return part.primary.s3;
  }

  @override
  Icon? buildIcon(BuildContext context) {
    Part part = ChapterProvider.of(context).part;
    return Icon(Icons.ondemand_video_sharp, size: 72, color: part.primary.s7);
  }

  @override
  Color border(Part part) {
    return part.primary.s5;
  }

  @override
  double get borderRadius => 0;

  @override
  EdgeInsets get outerPad =>
      const EdgeInsets.symmetric(vertical: 24, horizontal: 0);
  @override
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(vertical: 24, horizontal: 12);
}

/// For D&D splat elements
///
class DnDSplatHolder extends RaisedSpanHolder {
  DnDSplatHolder({required super.spans});

  @override
  Color color(Part part) {
    return part.primary.s6;
  }

  @override
  Icon? buildIcon(BuildContext context) {
    Part part = ChapterProvider.of(context).part;
    return Icon(RpgAwesome.wyvern, size: 24, color: part.primary.sc);
  }

  @override
  Color border(Part part) {
    return part.primary.s8;
  }

  @override
  double get borderRadius => 0;

  @override
  EdgeInsets get outerPad =>
      const EdgeInsets.symmetric(vertical: 36, horizontal: 12);
  @override
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(vertical: 24, horizontal: 12);
}

///There is exactly one MtG card in the book
class MtgCardHolder extends RaisedSpanHolder {
  MtgCardHolder({required super.spans});

  @override
  Color color(Part part) {
    return part.primary.s2;
  }

  @override
  Icon? buildIcon(BuildContext context) {
    Part part = ChapterProvider.of(context).part;
    return Icon(RpgAwesome.lion, size: 24, color: part.primary.sc);
  }

  @override
  Color border(Part part) {
    return part.primary.s4;
  }

  @override
  double get borderRadius => 24;

  @override
  EdgeInsets get outerPad =>
      const EdgeInsets.symmetric(vertical: 6, horizontal: 12);

  @override
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(vertical: 6, horizontal: 6);
}
