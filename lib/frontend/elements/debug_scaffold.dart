import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../backend/error_handler.dart';
import '../pages/debug_drawer.dart';
import '../theme/theme.dart';

// final talker = Talker();

// import 'package:flutter_icon'

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
    ViewSettings.instance.infiniteScrollNotifier
        .addListener(rebuildViewSettings);
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
    ViewSettings.instance.infiniteScrollNotifier
        .removeListener(rebuildViewSettings);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme,
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

class TopLevelWrapper extends StatelessWidget {
  final Widget child;
  const TopLevelWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(data: theme, child: child);
  }
}

class McFAB extends StatelessWidget {
  const McFAB({super.key});

  @override
  Widget build(BuildContext context) {
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
