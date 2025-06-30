import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/app_cta_overlay.dart';

import '../pages/drawer.dart';
import '../pages/scrollers/adserve.dart';
import '../text_theme.dart';

class AdSupportingScaffold extends StatefulWidget {
  final String? source;
  final Widget child;
  final bool showAppCTA;
  final bool showAds;
  const AdSupportingScaffold(
      {super.key,
      this.source,
      required this.child,
      required this.showAppCTA,
      required this.showAds})
      : assert(child is! AdSupportingScaffold);

  @override
  State<AdSupportingScaffold> createState() => _AdSupportingScaffoldState();
}

class _AdSupportingScaffoldState extends State<AdSupportingScaffold> {
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.showAppCTA) {
      Future.delayed(const Duration(seconds: 1), showAppCTA);
    }
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    overlayEntry = null;

    // Navigator.of(context).overlay.overlayEntry?.dispose();
    super.dispose();
  }

  Widget _overlayEntryBuilder(BuildContext context) {
    return OpenExistingAppOverlay(onClose: hideAppCTA);
  }

  void showAppCTA() {
    if (mounted) {
      dev.log("show cta");

      overlayEntry = OverlayEntry(builder: _overlayEntryBuilder);
      Navigator.of(context).overlay?.insert(overlayEntry!);
    }
    // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner())
  }

  void hideAppCTA() {
    dev.log("remove cta");
    overlayEntry?.remove();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme,
        child: Scaffold(
            endDrawer: MenuDrawer(source: widget.source),
            //If the ad is being shown, the FAB needs to be above the ad.
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const McFAB(),
            body: widget.showAds
                ? Stack(
                    children: [
                      widget.child,
                      const AdServeWidget(key: Key("AdServe_Stack"))
                    ],
                  )
                : widget.child));
  }
}
