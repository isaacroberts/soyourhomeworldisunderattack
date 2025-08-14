import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../backend/utils.dart';
import '../holders/span_holding_code.dart';

class SignWidget extends StatelessWidget {
  final Widget? child;
  final bool dark;
  const SignWidget({super.key, required this.dark, required this.child});

  static const Color darkColor = Color(0xff6e574f);
  static const Color lightColor = Color(0xfff6ebe5);

  Widget signBack(BuildContext context) {
    return Container(
      height: 600,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: dark ? darkColor : lightColor),
    );
  }

  Widget sign(BuildContext context) {
    int signAlpha = 0xbb + rNG.nextInt(0x25);
    return Container(
        height: 600,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: (dark ? darkColor : lightColor).withAlpha(signAlpha),
            border: Border.all(
                color: dark ? const Color(0xaa322a28) : Colors.black,
                width: 2)),
        child: child);
  }

  Widget picket(BuildContext context) {
    return Container(
      color: const Color(0xff503626),
      margin: const EdgeInsets.only(top: 200),
      width: 70,
      height: 610,
    );
  }

  Widget tape(BuildContext context, int nTape, double lPad) {
    lPad += (rNG.nextInt(5) - rNG.nextInt(5)).toDouble();
    return Container(
      color: dark ? const Color(0xaa434343) : const Color(0xaa5c5c5c),
      margin: EdgeInsets.only(
          top: nTape == 0 ? 0 : 300,
          bottom: nTape == 0 ? 100 : 0,
          left: math.max(lPad, 0),
          right: math.max(-lPad, 0)),
      width: 200,
      height: 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    double lPad = (rNG.nextInt(50) - rNG.nextInt(50)).toDouble();
    int nTape = rNG.nextInt(4);
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        signBack(context),
        picket(context),
        for (int n = 0; n < nTape; ++n) tape(context, n, lPad),
        sign(context),
      ],
    );
  }
}

class Sign extends SpanHoldingCode {
  const Sign({required super.spans});

  @override
  Widget element(BuildContext context) {
    return SignWidget(
        key: Key('Sign$hashCode'), dark: true, child: super.element(context));
  }
}
