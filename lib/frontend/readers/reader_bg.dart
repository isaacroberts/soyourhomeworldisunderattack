import 'package:flutter/material.dart';

import '../parts/noir_colors.dart';

BoxDecoration getTallReaderGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      NoirPrimary.shade2,
      // NoirPrimary.shade3,
      NoirPrimary.shade4,
    ],
    stops: [0, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,

    // radius: 1,
    // focalRadius: .1,
    // focal: Alignment(0, 1),
    // center: Alignment(0, .75),
  ));
}

BoxDecoration getShortReaderGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      NoirPrimary.shade2,
      // NoirPrimary.shade3,
      NoirPrimary.shade3,
    ],
    stops: [0, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,

    // radius: 1,
    // focalRadius: .1,
    // focal: Alignment(0, 1),
    // center: Alignment(0, .75),
  ));
}

class SoftReaderBg extends StatelessWidget {
  const SoftReaderBg({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    bool tall = height > 800;
    return DecoratedBox(
        key: const Key('gradBg'),
        decoration: tall ? getTallReaderGradient() : getShortReaderGradient(),
        child: const SizedBox.expand());
  }
}
