import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/code_holders.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/wave_background.dart';
import 'package:soyourhomeworld/frontend/human_jack_theme.dart';

import '../../../backend/utils.dart';
import '../custom_code/ad_widget.dart';
import '../holders/textholders.dart';
import 'party_ad.dart';

/*
  banner(728, 90),
  tablet(1024, 768),
  wide(970, 250),
  halfPage(300, 600),
  med(336, 280),
  med2(300, 250),
  smallBanner(300, 50),
  column(160, 600);
 */
enum HumanJackAdType {
  bannerShell(AdSize.banner),
  banner5P(AdSize.banner),
  bannerCares(AdSize.banner),
  childrenFixIt(AdSize.banner),
  partyStillGoing(AdSize.banner),
  ;

  Widget getWidget() {
    switch (this) {
      case HumanJackAdType.bannerShell:
        return const _HumanJackBannerShell();
      case HumanJackAdType.banner5P:
        return const _HumanJackBanner5P();
      case HumanJackAdType.bannerCares:
        return const _HumanJackBannerCares();
      case HumanJackAdType.childrenFixIt:
        return const _HumanJackChildrenFixIt();

      case HumanJackAdType.partyStillGoing:
        return const HumanJackPartyStillGoing();
    }
  }

  final AdSize size;
  const HumanJackAdType(this.size);

  static List<HumanJackAdType> getAdsForSize(AdSize size) {
    List<HumanJackAdType> matches = [];
    for (HumanJackAdType t in values) {
      if (t.size == size) {
        matches.add(t);
      }
    }
    return matches;
  }
}

HumanJackAdType getDebugAd() {
  return HumanJackAdType.bannerShell;
}

const String humanJackNavLink = '/humanjacks';
void humanJacksClicked(BuildContext context) {
  context.go(humanJackNavLink);
}

Widget slowLoadingHumanJackAdWidget(HumanJackAdType type) {
  return AdWrapper(
      key: Key('HumanJackAdWrapper${type.name}'),
      size: type.size,
      backgroundColor: humanJack1,
      child: Theme(
          data: humanJackTheme,
          child: SelectionContainer.disabled(child: type.getWidget())));
}

Widget humanJackAdWidget(HumanJackAdType type) {
  return ImmediateAdWrapper(
      key: Key('HumanJackAdWrapper${type.name}'),
      size: type.size,
      backgroundColor: humanJack1,
      child: Theme(
          data: humanJackTheme,
          child: SelectionContainer.disabled(child: type.getWidget())));
}

class HumanJackAdHolder extends Holder {
  final HumanJackAdType type;
  const HumanJackAdHolder(this.type);
  HumanJackAdHolder.random()
      : type =
            HumanJackAdType.values[RNG.nextInt(HumanJackAdType.values.length)];

  @override
  Widget element(BuildContext context) {
    return slowLoadingHumanJackAdWidget(type);
  }

  @override
  Widget fallback(BuildContext context) {
    //Choose not to dick them around on the fallback
    return IsFallbackProvider(showFonts: false, child: type.getWidget());
  }
}

class _HumanJackBannerShell extends StatelessWidget {
  const _HumanJackBannerShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        // decoration: const BoxDecoration(color: humanJack0),
        //     gradient: LinearGradient(colors: [
        //   humanJack0,
        //   humanJack1,
        //   humanJack3,
        //   humanJack4,
        //   // humanJack5
        // ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        color: const Color(0xff000000),
        child: WaveBackground(
            color: humanJack5,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Human Jack's",
                        style: humanJackTextTheme.displaySmall
                            ?.copyWith(color: humanJack5)),
                    Text("Get your shell back",
                        style: humanJackTextTheme.bodySmall?.copyWith(
                            color: humanJack0, fontWeight: FontWeight.w400)),
                  ],
                ))));
  }
}

class _HumanJackBanner5P extends StatelessWidget {
  const _HumanJackBanner5P({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          humanJack1,
          humanJack3,
          humanJack4,
          // humanJack5
        ], begin: Alignment.bottomRight, end: Alignment.topRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Human Jack's",
                style: humanJackTextTheme.displaySmall
                    ?.copyWith(color: humanJack0)),
            Text(
                "A daily dose of the 5Ps is critical to shell health. Learn more about how you can get your shell back.",
                style: humanJackTextTheme.bodySmall),
          ],
        ));
  }
}

class _HumanJackBannerCares extends StatelessWidget {
  const _HumanJackBannerCares({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          humanJack2,
          humanJack1,
        ], begin: Alignment.topRight, end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Human Jack's Cares.",
                style: humanJackTextTheme.displaySmall
                    ?.copyWith(color: Colors.white)),
            Text("Human Jack is a member of the Shell Research Commission.",
                style: humanJackTextTheme.bodySmall),
          ],
        ));
  }
}

class _HumanJackChildrenFixIt extends StatelessWidget {
  const _HumanJackChildrenFixIt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        color: const Color(0xff112233),
        child: WaveBackground(
            color: const Color(0xff215524),
            waves: 1,
            waveAmplitude: 80,
            duration: const Duration(milliseconds: 14000),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Human Jack",
                          style: humanJackTextTheme.labelMedium,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Text("“Our children will fix it!”",
                            textAlign: TextAlign.center,
                            style: humanJackTextTheme.displayLarge
                                ?.copyWith(color: const Color(0x88ffffff)))),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "trusts children.",
                          style: humanJackTextTheme.labelMedium,
                        )),
                  ],
                ))));
  }
}
