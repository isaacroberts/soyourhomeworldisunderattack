import 'package:flutter/material.dart';

import '../theme/layout_constants.dart';
import 'image_constants.dart';
import 'image_holder.dart';

class TallFitImageWidget extends StatelessWidget {
  const TallFitImageWidget({
    required super.key,
    required this.holder,
    required this.expanded,
    required this.child,
  });

  final StdImageHolder holder;
  final bool expanded;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double aspectRatio = holder.aspectRatio!;
    Widget child = this.child;
    child = FittedBox(key: const Key('fit'), fit: BoxFit.cover, child: child);

    Size size = MediaQuery.sizeOf(context);
    double maxHeight = standardImageHeight;
    double width = size.width;
    double height = width / aspectRatio;

    //Increase max height when expanded
    if (expanded) {
      //A little bit of scrolling is fine, to allow you to see it.
      //But, no frigging pages
      // maxHeight *= 1.5;
      maxHeight = size.height - appBarSize;
    } else {
      //Leave room for appBar.
      //Expanded, so you're not having
      //   to carefully adjust your scroll.
      //   (Up. Oops, the appBarExpanded and I can't see the whole image. Down. Oops, too far. Up, twice. Down.)
      // maxHeight -= expandedAppBarSize;
    }
    if (height > maxHeight) {
      height = maxHeight;
      width = maxHeight * aspectRatio;
    }

    child = AnimatedContainer(
      key: const Key('lsAnimCtr'),
      duration: const Duration(milliseconds: 500),
      width: width,
      height: height,
      child: child,
    );

    return child;
  }
}
