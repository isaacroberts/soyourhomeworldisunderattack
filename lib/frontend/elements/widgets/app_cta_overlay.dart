import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

class McKinseyAppIcon extends StatelessWidget {
  const McKinseyAppIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Material(
            child: Container(
                // shape: RoundedRectangleBorder(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    // color: KevinColor.shade5,
                    gradient: LinearGradient(
                        colors: [
                          primary.shade700,
                          primary.shade500,
                          primary.shade400,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                margin: const EdgeInsets.all(5),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: const ClipRect(
                    child: Icon(
                  Icons.fireplace_outlined,
                  color: fireOrangeColor,
                )))));
  }
}

class OpenExistingAppOverlay extends StatelessWidget {
  /*
    What shows up when you open YouTube or whatever and it wants you to open the native app 
   */
  final VoidCallback onClose;
  const OpenExistingAppOverlay({super.key, required this.onClose});

  void fakeoutClose() {
    Future.delayed(const Duration(milliseconds: 250), onClose);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            color: const Color(0xff111111),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
                const SizedBox(
                    height: 45,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            McKinseyAppIcon(),
                            Material(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'McKinsey eReader',
                                  style: TextStyle(
                                      height: .9,
                                      fontFamily: 'Rubik',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text('Open in the McKinsey app',
                                    style: TextStyle(
                                        height: .9,
                                        fontFamily: 'Rubik',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200))
                              ],
                            ))
                          ],
                        ))),
                FilledButton(
                  onPressed: fakeoutClose,
                  // color: humanJack2,
                  // margin: EdgeInsets.symmetric(horizontal: 5),
                  child: const Text('OPEN'),
                )
              ],
            )));
  }
}

// Smaller, more spartan
class AppCtaOverlay2 extends StatelessWidget {
  final VoidCallback onClose;
  const AppCtaOverlay2({super.key, required this.onClose});

  void fakeoutClose() {
    Future.delayed(const Duration(milliseconds: 30), onClose);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            color: const Color(0x22000000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
                FilledButton(
                    onPressed: fakeoutClose,
                    // color: humanJack2,
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: SizedBox(
                            height: 25,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Looks better in the app!'),
                                Icon(Icons.adb),
                              ],
                            ))))
              ],
            )));
  }
}
