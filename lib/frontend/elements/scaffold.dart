import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../backend/error_handler.dart';
import '../pages/drawer.dart';
import '../text_theme.dart';

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
    //For ErrorSnackbars
    timer = Timer.periodic(const Duration(seconds: 1), checkScaffold);
    ViewSettings.instance.addListener(rebuildViewSettings);
  }

  void rebuildViewSettings() {
    setState(() {});
  }

  @override
  dispose() {
    ViewSettings.instance.removeListener(rebuildViewSettings);
    timer.cancel();
    super.dispose();
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
