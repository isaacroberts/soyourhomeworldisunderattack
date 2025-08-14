import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view_settings.dart';

const List<(String, String?)> drawerItems = [
  ('Keep reading', null),
  ('Home', 'home'),
  ("Index", 'index'),
  ('Shop', 'search/tshirts/'),
  ('Valinor', 'valinor'),
  ('Valinor Tickets', 'valinortickets'),
  ("Error logger", 'logger'),
  ('Dev: Test Widget', 'dev_page'),
  ('Dev: Icons', 'dev_icons'),
];

class MenuDrawer extends StatelessWidget {
  final String? source;
  const MenuDrawer({super.key, required this.source});

  Widget? listTile(BuildContext context, String display, String? url) {
    if (source == url) {
      return null;
    }
    return ListTile(
      title: Text(display),
      onTap: () => onUrlTap(context, url),
    );
  }

  void onUrlTap(BuildContext context, String? url) {
    if (url == null) {
      //Assume it's Keep Reading
      dev.log("Close drawer");

      Scaffold.of(context).closeEndDrawer();
    } else if (url.isEmpty) {
      //home
      context.go('/', extra: {});
    } else {
      context.go('/$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    //List tiles

    List<Widget> listTiles = [];
    for ((String, String?) tup in drawerItems) {
      var widget = listTile(context, tup.$1, tup.$2);
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
        // shape: RoundedRectangleBorder(),
        // backgroundColor: canvasFade,
        key: const ValueKey('MenuDrawer'),
        child: ListView(
          children: listTiles,
        ));
  }
}

class ScrollModeDropdown extends StatelessWidget {
  final String label;
  final ValueNotifier<ScrollMode> value;

  const ScrollModeDropdown(
      {super.key, required this.label, required this.value});

  void onChanged(ScrollMode? mode) {
    if (mode != null) {
      value.value = mode;
    }
  }

  DropdownMenuItem<ScrollMode> dropdownElement(ScrollMode mode) {
    return DropdownMenuItem(
        value: mode,
        alignment: Alignment.centerLeft,
        child: Text(mode.displayName));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: DropdownButton<ScrollMode>(
            menuWidth: 300,
            value: value.value,
            items:
                ScrollMode.values.map(dropdownElement).toList(growable: false),
            onChanged: onChanged));
  }
}

class NotifiedSwitch extends StatelessWidget {
  final String label;
  final ValueNotifier<bool> value;

  const NotifiedSwitch({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: value, builder: builder);
  }

  Widget builder(BuildContext context, Widget? orig) {
    return SwitchListTile(
        title: Text(label),
        value: value.value,
        onChanged: (b) => value.value = b);
  }
}
