import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/ad_human_jacks.dart';

import '../../../backend/utils.dart';
import '../../elements/custom_code/ad_widget.dart';
import '../../human_jack_theme.dart';

class AdServeWidget extends StatefulWidget {
  const AdServeWidget({super.key});

  @override
  State<AdServeWidget> createState() => _AdServeWidgetState();
}

class _AdServeWidgetState extends State<AdServeWidget>
    with SingleTickerProviderStateMixin {
  HumanJackAdType? currentType;
  int loadLevel = 0;
  int adPeriodsRemaining = 0;
  static const int adPeriod = 3;
  static const int maxLoad = 3;
  late final Timer timer;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), setRandomAd);
    timer = Timer.periodic(const Duration(seconds: 60), timerCallback);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void setRandomAd() {
    if (!mounted) {
      return;
    }
    HumanJackAdType newType;
    if (kDebugMode) {
      newType = getDebugAd();
    } else {
      List<HumanJackAdType> types =
          HumanJackAdType.getAdsForSize(AdSize.banner);
      newType = types[RNG.nextInt(types.length)];
    }
    dev.log("Ad: Set $newType");
    setState(() {
      currentType = newType;
      loadLevel = 0;
      adPeriodsRemaining = adPeriod;
    });
    Future.delayed(const Duration(milliseconds: 30), _loadLevel);
  }

  void timerCallback(Timer t) {
    if (currentType == null) {
      setRandomAd();
    } else {
      if (adPeriodsRemaining > 0) {
        dev.log("Ad: Wait $adPeriodsRemaining");
        adPeriodsRemaining--;
      } else {
        dev.log("Ad: Clear");
        setState(() {
          currentType = null;
        });
      }
    }
  }

  Widget ad(BuildContext context) {
    return currentType?.getWidget() ?? const Placeholder();
  }

  MaterialButton buttonAndAd(BuildContext context) {
    const double mpad = 0;
    return MaterialButton(
        padding: const EdgeInsets.only(left: mpad, right: mpad),
        onPressed: openHumanJackChapter,
        child: Container(
            width: currentType?.size.width,
            height: currentType?.size.height,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(color: Color(0xff000000), blurRadius: 7)
            ], border: Border.all(color: const Color(0x77ffffff), width: 1)),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: SelectionContainer.disabled(child: ad(context))));
  }

  Widget withinContainer(BuildContext context) {
    if (loadLevel <= 0) {
      return Container(
        width: currentType?.size.width,
        height: currentType?.size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0xff000000), blurRadius: 7)],
        ),
      );
    } else if (loadLevel == 1) {
      return Container(
          width: currentType!.size.width,
          height: currentType!.size.height,
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Color(0xff000000), blurRadius: 7)],
            color: Colors.white,
          ),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 3),
          child: adsense());
    } else //if (loadLevel>=2) {
    {
      return SizedBox(
          width: currentType!.size.width + 10,
          height: currentType!.size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.passthrough,
            children: [
              buttonAndAd(context),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 3),
                      child: adsense())),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: closeButton())),
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    HumanJackAdType? type = currentType;
    if (type == null || loadLevel == 0) {
      return const SizedBox.shrink();
    } else {
      return Theme(
          data: humanJackTheme,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: withinContainer(context)));
    }
  }

  Widget adsense() {
    return const Text(
      'AdSense',
      textAlign: TextAlign.start,
      style: TextStyle(
          fontFamily: 'Montserrat',
          // color: Color(0x77ffffff),
          color: Color(0x882196F3),
          fontSize: 8,
          fontWeight: FontWeight.w300),
    );
  }

  Widget closeButton() {
    return Container(
        width: 17,
        height: 17,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0x22ffffff),
            ),
            color: const Color(0x22000000)),
        child: IconButton(
            onPressed: closePressed,
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            icon: const Icon(
              Icons.close,
              color: Color(0x44ffffff),
              // color: Color(0x772196F3),
              size: 15,
            )));
  }

  void closePressed() {
    setState(() {
      currentType = null;
    });
  }

  void _load() async {
    // if (key != null) {
    //   adCache.add(key);
    // }
    setState(() {
      loadLevel = maxLoad;
    });
  }

  void _loadLevel() async {
    if (mounted) {
      setState(() {
        loadLevel += 1;
      });
      if (loadLevel < maxLoad) {
        int ms = 1 + loadLevel * RNG.nextInt(100) * RNG.nextInt(30);
        Future.delayed(Duration(milliseconds: ms), _loadLevel);
      } else {
        _load();
      }
    }
  }

  bool loadN(int amt) {
    return loadLevel >= amt;
  }

  void openHumanJackChapter() {
    context.go(humanJackNavLink);
  }
}
