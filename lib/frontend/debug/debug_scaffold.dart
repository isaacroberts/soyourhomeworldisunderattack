import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/mc_fab.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../backend/error_handler.dart';
import '../pages/debug_drawer.dart';
import '../parts/noir_theme.dart';

// final talker = Talker();

// import 'package:flutter_icon'

///Used by main's shorter DebugApp
class McDebugScaffold extends StatefulWidget {
  final Widget child;
  const McDebugScaffold({super.key, String? source, required this.child})
      : assert(child is! McDebugScaffold);

  @override
  State<McDebugScaffold> createState() => _McDebugScaffoldState();
}

class _McDebugScaffoldState extends State<McDebugScaffold>
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
            endDrawer: const DebugDrawer(),
            floatingActionButton: const McFAB(),
            body: widget.child));
  }

  void checkScaffold(Timer timer) {
    if (mounted) {
      ErrorList.instance.checkSnackbar(context);
    }
  }
}
