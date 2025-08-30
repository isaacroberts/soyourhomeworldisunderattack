import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/mc_fab.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../backend/error_handler.dart';
import '../pages/drawer.dart';
import '../parts/noir_theme.dart';

// final talker = Talker();

// import 'package:flutter_icon'

class McScaffold extends StatefulWidget {
  final String? source;
  final Widget child;
  final bool showFAB;
  const McScaffold(
      {super.key,
      required this.source,
      this.showFAB = true,
      required this.child})
      : assert(child is! McScaffold);

  @override
  State<McScaffold> createState() => _McScaffoldState();
}

class _McScaffoldState extends State<McScaffold>
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
        data: noirTheme,
        child: Scaffold(
            endDrawer: MenuDrawer(source: widget.source),

            // backgroundColor: const Color(0xfff2ce9f),
            // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: widget.showFAB ? const McFAB() : null,
            body: widget.child));
  }

  void checkScaffold(Timer timer) {
    if (mounted) {
      ErrorList.instance.checkSnackbar(context);
    }
  }
}
