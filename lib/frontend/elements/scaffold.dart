import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/app_cta_overlay.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../../backend/error_handler.dart';
import '../pages/drawer.dart';
import '../pages/scrollers/adserve.dart';

// final talker = Talker();

// import 'package:flutter_icon'

class McScaffold extends StatefulWidget {
  final String? source;
  final Widget child;
  const McScaffold({super.key, required this.source, required this.child})
      : assert(child is! McScaffold);

  @override
  State<McScaffold> createState() => _McScaffoldState();
}

class _McScaffoldState extends State<McScaffold>
    with SingleTickerProviderStateMixin {
  late final Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), checkScaffold);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme,
        child: Scaffold(
            endDrawer: MenuDrawer(source: widget.source),

            // backgroundColor: const Color(0xfff2ce9f),
            // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: const McFAB(),
            body: widget.child));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void checkScaffold(Timer timer) {
    if (mounted) {
      ErrorList.instance.checkSnackbar(context);
    }
  }
}

class TopLevelWrapper extends StatelessWidget {
  final Widget child;
  const TopLevelWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(data: theme, child: child);
  }
}

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

class McFAB extends StatelessWidget {
  const McFAB({super.key});

  @override
  Widget build(BuildContext context) {
    // dev.log(
    //     "Primary: ${Theme.of(context).colorScheme.primary.value.toRadixString(16)}");
    // dev.log("Primary: ${theme.colorScheme.primary.value.toRadixString(16)}");

    return FloatingActionButton(
        key: const Key("McScaffoldFAB"),
        heroTag: 'DrawerMcFab',
        // backgroundColor: theme.colorScheme.primary,
        // splashColor: Color(0x0),
        // backgroundColor: Color(0xffff0000),
        onPressed: () => Scaffold.of(context).openEndDrawer(),
        child: const Icon(Icons.menu));
  }
}
