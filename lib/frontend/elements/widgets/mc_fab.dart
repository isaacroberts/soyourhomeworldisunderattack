import 'package:flutter/material.dart';

class McFAB extends StatelessWidget {
  const McFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        key: const Key("McScaffoldFAB"),
        heroTag: 'DrawerMcFab',
        onPressed: () => Scaffold.of(context).openEndDrawer(),
        child: const Icon(Icons.menu));
  }
}
