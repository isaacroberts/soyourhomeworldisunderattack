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
  EdgeInsets get margin;
  EdgeInsets get padding;
  double get borderRadius;
  Icon? buildIcon(BuildContext context);

  ///Sizes the inner part, not including the icon
  BoxConstraints? get constraints;

  @override
  Widget sliver(BuildContext context) {
    Part part = ChapterProvider.of(context).part;

    Widget child =
        renderSpans(context, crossAxisAlignment: CrossAxisAlignment.start);
    //Overridden getter
    BoxConstraints? constraints = this.constraints;

    if (constraints != null) {
      //Sizes the inner part
      child = ConstrainedBox(constraints: constraints, child: child);
      //Use SliverConstraintedAxis
    }

    child = SliverPadding(
        key: const Key('PadCtr'),
        padding: padding,
        sliver: SliverToBoxAdapter(key: const Key('RaisedCtt'), child: child));

    Widget? icon = buildIcon(context);
    if (icon != null) {
      //Wrap
      icon = SliverToBoxAdapter(
          key: const Key('IconBox'),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: icon)));

      child = SliverMainAxisGroup(key: const Key('IconCol'), slivers: [
        //TODO: Update to new operator
        icon,
        SliverPadding(key: const Key('PadCtr'), padding: padding, sliver: child)
      ]);
    } else {
      //child = child
    }

    return SliverPadding(
        key: const Key("RaisedMargin"),
        padding: margin,
        sliver: DecoratedSliver(
            key: const Key('RaisedSpanCtr'),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: color(part),
              border: Border.all(color: border(part), width: 1),
            ),
            sliver: child));
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
  //Should already be sized to screen width
  BoxConstraints? get constraints => null;

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
  EdgeInsets get margin =>
      const EdgeInsets.symmetric(vertical: 24, horizontal: 0);
  @override
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(vertical: 24, horizontal: 12);
}

/// For D&D splat elements
///  Like the inset boxes in the PHB
class DnDSplatHolder extends RaisedSpanHolder {
  DnDSplatHolder({required super.spans});

  @override
  Color color(Part part) {
    return part.primary.s6;
  }

  @override
  //Like the inset boxes in the PHB
  BoxConstraints? get constraints => const BoxConstraints(
      minWidth: 400, maxWidth: 800, minHeight: 200, maxHeight: double.infinity);

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
  EdgeInsets get margin =>
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
  //Like the inset boxes in the PHB
  //TODO: Tune these
  BoxConstraints? get constraints => const BoxConstraints(
      minWidth: 400, maxWidth: 500, minHeight: 800, maxHeight: 1200);

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
  EdgeInsets get margin =>
      const EdgeInsets.symmetric(vertical: 6, horizontal: 12);

  @override
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(vertical: 6, horizontal: 6);
}

///Drivers license, ID, etc
class LicenseHolder extends RaisedSpanHolder {
  LicenseHolder({required super.spans});

  @override
  Color color(Part part) {
    return part.primary.s3;
  }

  @override
  //Drivers license
  BoxConstraints? get constraints =>
      const BoxConstraints.tightFor(width: 190, height: 120);

  @override
  Icon? buildIcon(BuildContext context) {
    Part part = ChapterProvider.of(context).part;
    return Icon(Icons.drive_eta, size: 24, color: part.primary.sa);
  }

  @override
  Color border(Part part) {
    return part.primary.s5;
  }

  @override
  double get borderRadius => 36;

  @override
  EdgeInsets get margin =>
      const EdgeInsets.symmetric(vertical: 12, horizontal: 24);

  @override
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(vertical: 24, horizontal: 12);
}

///Drivers license, ID, etc
class ArticleHolder extends RaisedSpanHolder {
  ArticleHolder({required super.spans});

  @override
  Color color(Part part) {
    return part.primary.s0;
  }

  @override
  //Drivers license
  BoxConstraints? get constraints => null;

  @override
  Icon? buildIcon(BuildContext context) {
    return null;
  }

  @override
  Color border(Part part) {
    return part.primary.s2;
  }

  @override
  double get borderRadius => 0;

  @override
  EdgeInsets get margin =>
      const EdgeInsets.symmetric(vertical: 12, horizontal: 12);

  @override
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(vertical: 12, horizontal: 12);
}
