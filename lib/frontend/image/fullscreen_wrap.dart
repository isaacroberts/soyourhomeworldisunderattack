import 'package:flutter/material.dart';

import '../parts/noir_colors.dart';
import 'image_holder.dart';

class ImageFullscreenWrapSliver extends StatelessWidget {
  ///For fullscreen
  const ImageFullscreenWrapSliver({
    super.key,
    required this.holder,
    required this.child,
  });

  final ImageHolder holder;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ///Child must be sliver
    ///This is not a builder function, this is the container wrap
    Color outlineColor = holder.outlineColor ?? Colors.black;
    return DecoratedSliver(
        key: const Key('smWrapper'),
        decoration: BoxDecoration(
            color: holder.bgColor ?? NoirPrimary.shade4,
            border: Border.all(color: outlineColor, width: 2),
            borderRadius: BorderRadius.circular(12)),
        sliver: SliverPadding(
            padding:
                const EdgeInsets.only(top: 24, left: 6, right: 6, bottom: 48),
            sliver: child));
  }
}
