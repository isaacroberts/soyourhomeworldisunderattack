import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/mc_fab.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../backend/error_handler.dart';
import '../pages/drawer.dart';
import '../parts/part.dart';

// final talker = Talker();

// import 'package:flutter_icon'

class ThemeChangingScaffold extends StatefulWidget {
  final String? source;
  final Part part;
  final Widget child;
  final bool showFAB;
  final Widget? bottomNavigationBar;
  final Color? background;
  const ThemeChangingScaffold(
      {super.key,
      required this.source,
      this.showFAB = true,
      required this.child,
      required this.part,
      this.background,
      this.bottomNavigationBar});

  @override
  State<ThemeChangingScaffold> createState() => _ThemedScaffoldState();
}

class _ThemedScaffoldState extends State<ThemeChangingScaffold>
    with SingleTickerProviderStateMixin {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    //For ErrorSnackbars

    //Avoid showing ErrorSnackbar immediately upon open
    Future.delayed(
        const Duration(seconds: kDebugMode ? 1 : 10), startErrorChecking);
    ViewSettings.instance.scrollModeNotifier.addListener(rebuildViewSettings);
  }

  void startErrorChecking() {
    //For ErrorSnackbars
    timer = Timer.periodic(const Duration(seconds: 1), checkScaffold);
  }

  void rebuildViewSettings() {
    setState(() {});
  }

  @override
  dispose() {
    ViewSettings.instance.scrollModeNotifier
        .removeListener(rebuildViewSettings);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        key: const Key("Theme"),
        data: widget.part.theme,
        child: Scaffold(
            key: const Key("Scaffold"),
            backgroundColor: widget.background,
            bottomNavigationBar: widget.bottomNavigationBar,
            // persistentFooterButtons: [
            //   IconButton(onPressed: () {}, icon: Icon(Icons.add))
            // ],
            extendBody: true,
            // persistentFooterAlignment: AlignmentDirectional.topCenter,
            endDrawer: MenuDrawer(source: widget.source),
            floatingActionButton: widget.showFAB ? const McFAB() : null,
            body: widget.child));
  }

  void checkScaffold(Timer timer) {
    if (mounted) {
      ErrorList.instance.checkSnackbar(context);
    }
  }
}
