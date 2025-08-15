import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/icon_viewer.dart';

import '../../backend/error_handler.dart';
import '../view_settings.dart';
import 'drawer.dart';

const List<String> drawerItems = [
  'Home',
  "Errors",
  'DevIcons',
];

class DebugDrawer extends StatelessWidget {
  const DebugDrawer({super.key});

  Widget? listTile(BuildContext context, String display) {
    return ListTile(
      title: Text(display),
      onTap: () => onUrlTap(context, display),
    );
  }

  void onUrlTap(BuildContext context, String url) {
    if (url == 'Errors') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ErrorList.instance.page(context)));
    } else if (url == 'Home') {
      Navigator.pop(context);
    } else if (url == 'DevIcons') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const IconViewerPage(
                    key: Key("IconViewer"),
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    //List tiles

    List<Widget> listTiles = [];
    for (String tup in drawerItems) {
      var widget = listTile(context, tup);
      if (widget != null) {
        listTiles.add(widget);
      }
    }
    listTiles.add(ScrollModeDropdown(
        label: 'Scroll mode',
        value: ViewSettings.instance.infiniteScrollNotifier));
    listTiles.add(NotifiedSwitch(
      label: 'Dev Rig',
      value: ViewSettings.instance.testRigNotifier,
    )); // listTiles.add(SwitchListTile(
    listTiles.add(NotifiedSwitch(
      label: 'Fonts',
      value: ViewSettings.instance.showFontsNotifier,
    )); //Drawer
    return Drawer(
        key: const ValueKey('MenuDrawer'),
        child: ListView(
          children: listTiles,
        ));
  }
}
