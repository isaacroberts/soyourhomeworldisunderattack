import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../backend/utils.dart';
import 'code_holders.dart';

enum AdSize {
  banner(728, 90),
  tablet(1024, 768),
  wide(970, 250),
  halfPage(300, 600),
  med(336, 280),
  med2(300, 250),
  smallBanner(300, 50),
  column(160, 600);

  final double width;
  final double height;
  const AdSize(this.width, this.height);

  Size get size => Size(width, height);
}

class ImmediateAdWrapper extends StatefulWidget {
  final Widget child;
  final AdSize size;
  final Color backgroundColor;
  const ImmediateAdWrapper(
      {super.key,
      required this.child,
      this.size = AdSize.halfPage,
      required this.backgroundColor});

  @override
  State<ImmediateAdWrapper> createState() => _ImmediateAdWrapperState();
}

class _ImmediateAdWrapperState extends State<ImmediateAdWrapper> {
  void onPress() {}

  Widget slowLoadingContainer(BuildContext context) {
    return MaterialButton(
        onPressed: onPress,
        child: Container(
            // # calculated by hand
            width: widget.size.width,
            height: widget.size.height,
            alignment: Alignment.center,
            // padding: const EdgeInsets.all(5),
            // color: widget.backgroundColor,
            child: widget.child));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            padding:
                const EdgeInsets.only(top: 3, left: 1, bottom: 1, right: 1),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AdSenseRow(),
                slowLoadingContainer(context),
                // const SizedBox(height: 10),
              ],
            )));
  }
}

class AdWrapper extends StatefulWidget {
  final Widget child;
  final AdSize size;
  final Color backgroundColor;

  const AdWrapper(
      {super.key,
      required this.child,
      this.size = AdSize.halfPage,
      required this.backgroundColor});

  @override
  State<AdWrapper> createState() => _AdWrapperState();
}

class _AdWrapperState extends State<AdWrapper> {
  bool loaded = false;
  int loadSpeed = 1;
  int loadLevel = 0;
  static const int maxLoad = 6;

  static Set<Key> adCache = {};

  @override
  void initState() {
    assert(widget.key != null);
    loadSpeed = 1 + RNG.nextInt(5);
    //TODO: This is to prevent them from reloading every time
    if (adCache.contains(widget.child.key)) {
      loaded = true;
      loadLevel = maxLoad;
    }
    super.initState();
  }

  void _becomesVisible(VisibilityInfo info) {
    if (mounted) {
      if (!loaded) {
        if (info.visibleFraction > .4) {
          Future.delayed(const Duration(milliseconds: 30), _loadLevel);
        }
      }
    }
  }

  void _load() async {
    Key? key = widget.key;
    if (key != null) {
      adCache.add(key);
    }
    setState(() {
      loaded = true;
    });
  }

  void _loadLevel() async {
    if (mounted) {
      setState(() {
        loadLevel += 1;
      });
      if (loadLevel < maxLoad) {
        int ms = loadSpeed * loadLevel * RNG.nextInt(10) * RNG.nextInt(30);
        // dev.log("wait $ms");
        Future.delayed(Duration(milliseconds: ms), _loadLevel);
      } else {
        _load();
      }
    }
  }

  Color currentColor() {
    if (loadLevel > 3) {
      return widget.backgroundColor;
    }
    return Colors.white;
  }

  Widget adElement(BuildContext context) {
    if (loadN(4)) {
      return widget.child;
    } else {
      return Container(color: Colors.white, height: 200);
    }
  }

  bool loadN(int amt) {
    return loadLevel >= amt;
  }

  void onPress() {}

  Widget slowLoadingContainer(BuildContext context) {
    return MaterialButton(
        onPressed: onPress,
        child: Container(
            // # calculated by hand
            width: widget.size.width,
            height: widget.size.height,
            alignment: Alignment.center,
            // padding: const EdgeInsets.all(5),
            color: widget.backgroundColor,
            child: adElement(context)));
  }

  Widget adsenseWrapper(BuildContext context) {
    return Align(
        alignment: loadN(5) ? Alignment.bottomCenter : Alignment.bottomLeft,
        child: Container(
            padding:
                const EdgeInsets.only(top: 3, left: 1, bottom: 1, right: 1),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AdSenseRow(),
                slowLoadingContainer(context),
                // const SizedBox(height: 10),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key("VisibDetector${widget.key}"),
        onVisibilityChanged: _becomesVisible,
        child: adsenseWrapper(context));
  }
}

class AdElementHolder extends SpanHoldingCode {
  final Color? color;
  AdElementHolder({required super.spans, this.color});

  @override
  Widget element(BuildContext context) {
    return AdWrapper(
        key: Key('AdElem$hashCode'),
        backgroundColor: color ?? const Color(0xff222225),
        child: renderSpans(context));
  }
}

class AdSenseRow extends StatelessWidget {
  const AdSenseRow({super.key});

  void closePressed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: SizedBox(
            height: 10,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'AdSense',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0x77ffffff),
                      // color: Color(0xFF2196F3),
                      fontSize: 8,
                      fontWeight: FontWeight.w300),
                ),
                IconButton(
                    onPressed: closePressed,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.close,
                      color: Color(0x77ffffff),
                      // color: Color(0xFF2196F3),
                      size: 10,
                    ))
              ],
            )));
  }
}
