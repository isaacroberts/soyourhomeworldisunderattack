import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/components/sliver_center.dart';

import '../parts/part.dart';

class SliverReaderWidth extends StatelessWidget {
  final Widget sliver;
  const SliverReaderWidth({required super.key, required this.sliver});

  static const double readerWidth = 800;

  Widget border({Color? color, double? width, required Widget sliver}) {
    if (color == null) {
      return sliver;
    }
    width ??= 1;
    return DecoratedSliver(
        decoration: BoxDecoration(
            border: Border.symmetric(
                vertical: BorderSide(
                    color: color,
                    width: width,
                    strokeAlign: BorderSide.strokeAlignInside))),
        sliver: SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: width), sliver: sliver));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    Part part = Part.of(context);
    if (screenWidth <= readerWidth) {
      return sliver;
    } else {
      const double borderWidth = 12;
      return DecoratedSliver(
          key: const Key("gutter"),
          decoration: BoxDecoration(
            color: part.secondary.s1,
          ),
          sliver: SliverCenter(
              sliver: SliverConstrainedCrossAxis(
                  maxExtent: readerWidth + borderWidth * 2,
                  sliver: DecoratedSliver(
                      decoration: BoxDecoration(
                        color: part.canvasColor,
                      ),
                      sliver: SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: borderWidth),
                          sliver: sliver)))));
    }
  }
}
