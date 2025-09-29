import 'package:flutter/material.dart';

import '../parts/noir_colors.dart';

BoxDecoration getReaderGradient() {
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

class SoftReaderBg extends StatelessWidget {
  const SoftReaderBg({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        key: const Key('gradBg'),
        decoration: getReaderGradient(),
        child: const SizedBox.expand());
  }
}
