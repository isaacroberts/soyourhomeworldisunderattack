import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';
import 'package:soyourhomeworld/frontend/parts/gn_colors.dart';
import 'package:soyourhomeworld/frontend/parts/rev_colors.dart';

import '../../backend/part_id.dart';
import '../parts/noir_colors.dart';
import '../parts/red_colors.dart';

BoxDecoration getTallReaderGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      NoirPrimary.shade1,
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

BoxDecoration getShortReaderGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      // NoirPrimary.shade2,
      NoirPrimary.shade2,
      NoirPrimary.shade1,
    ],
    stops: [0, .9],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,

    // radius: 1,
    // focalRadius: .1,
    // focal: Alignment(0, 1),
    // center: Alignment(0, .75),
  ));
}

BoxDecoration getTallGreenlandGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      GnPrimary.shadeb,
      GnPrimary.shadee,
      GnPrimary.shadef,
    ],
    stops: [0, .5, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,

    // radius: 1,
    // focalRadius: .1,
    // focal: Alignment(0, 1),
    // center: Alignment(0, .75),
  ));
}

BoxDecoration getShortGreenlandGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      GnPrimary.shadec,
      GnPrimary.shaded,
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

BoxDecoration getShortRevGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      RevPrimary.shaded,
      RevPrimary.shadee,
    ],
    stops: [0, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  ));
}

BoxDecoration getShortRedGradient() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      RedPrimary.shaded,
      RedPrimary.shadee,
    ],
    stops: [0, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
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

class GreenlandReaderBg extends StatelessWidget {
  const GreenlandReaderBg({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    bool tall = height > 800;
    return DecoratedBox(
        key: const Key('gradBg'),
        decoration:
            tall ? getTallGreenlandGradient() : getShortGreenlandGradient(),
        child: const SizedBox.expand());
  }
}

class RevReaderBg extends StatelessWidget {
  const RevReaderBg({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        key: const Key('gradBg'),
        decoration: getShortRevGradient(),
        child: const SizedBox.expand());
  }
}

class RedReaderBg extends StatelessWidget {
  const RedReaderBg({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        key: const Key('gradBg'),
        decoration: getShortRedGradient(),
        child: const SizedBox.expand());
  }
}

Widget getGradientBg(PartId part) {
  if (NOIR_ONLY) {
    return const SoftReaderBg(
      key: Key('noirBg'),
    );
  }

  switch (part) {
    case PartId.noir:
      return const SoftReaderBg(
        key: Key('noirBg'),
      );
    case PartId.greenland:
      return const GreenlandReaderBg(
        key: Key('gnBg'),
      );

    case PartId.redemption:
      return const RedReaderBg(
        key: Key('rxBg'),
      );
    case PartId.revolution:
      return const RevReaderBg(
        key: Key('rxBg'),
      );
  }
}
