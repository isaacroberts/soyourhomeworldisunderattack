import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/icons.dart';
import 'package:soyourhomeworld/frontend/parts/noir_colors.dart';

class SiteLogo extends StatelessWidget {
  const SiteLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 400,
      // height: 200,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: const EdgeInsets.only(top: 24, bottom: 24, left: 12, right: 36),
      decoration: BoxDecoration(
        color: NoirPrimary.shade5,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: NoirPrimary.shadea, width: 3),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StackLogo(
            size: 144 - 48,
          ),
          // BurningEarthLogo(size: 144 - 48),
          SizedBox(
            width: 12,
          ),
          Flexible(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Help! My\nHomeworld!",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: NoirPrimary.shadeb),
                    textAlign: TextAlign.start,
                  ),
                  // Text(
                  //   "JSSM",
                  //   style: TextStyle(
                  //       fontFamily: 'Rubik',
                  //       fontSize: 48,
                  //       fontWeight: FontWeight.w900,
                  //       color: NoirPrimary.shade7),
                  //   textAlign: TextAlign.start,
                  // ),
                ],
              ))
        ],
      ),
    );
  }
}

class StackLogo extends StatelessWidget {
  final double? size;
  const StackLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size! * 1.5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BurningEarthLogo(
              size: size,
            ),
            Align(
                alignment: const Alignment(0, 1),
                child: Icon(
                  RpgAwesome.sickle,
                  size: size != null ? size! / 2 : null,
                  color: NoirPrimary.shadec,
                )),
          ],
        ));
  }
}

class BurningEarthLogo extends StatelessWidget {
  final double? size;
  const BurningEarthLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: 4 - 3.14159,
        child: Icon(
          RpgAwesome.burning_meteor,
          color: NoirPrimary.shadea,
          size: size,
        ));
  }
}
