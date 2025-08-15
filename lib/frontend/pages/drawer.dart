import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/colors.dart';
import '../view_settings.dart';

const List<(String, String?)> drawerItems = [
  // ('Keep reading', null),
  ('Home', 'home'),
  ("Index", 'index'),
  ('Shop', 'search/tshirts/'),
];
const List<(String, String)> devItems = [
  // ('Valinor', 'valinor'),
  // ('Valinor Tickets', 'valinortickets'),
  //
  // ('-', null),
  ("Dev: Errors", 'logger'),
  ('Dev: Test Widget', 'dev_page'),
  ('Dev: Icons', 'dev_icons'),
];

class MenuDrawer extends StatelessWidget {
  final String? source;
  const MenuDrawer({super.key, required this.source});

  Widget? listTile(BuildContext context, String display, String? url) {
    //Don't add current location to drawer
    if (source == url) {
      return null;
    }
    return ListTile(
      key: Key("Tile$display"),
      style: ListTileStyle.drawer,
      title: Text(display),
      onTap: () => onUrlTap(context, url),
    );
  }

  Widget devTile(BuildContext context, String display, String url) {
    //Don't add current location to drawer

    return DevListTile(
      key: Key("Tile$display"),
      title: display,
      link: url,
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

  int get devStart {
    for (int n = 0; n < drawerItems.length; ++n) {
      if (drawerItems[n].$1.startsWith('Dev:')) {
        return n;
      }
    }
    return drawerItems.length;
  }

  @override
  Widget build(BuildContext context) {
    //List tiles

    List<Widget> listTiles = [];

    //Locations
    for ((String, String?) tup in drawerItems) {
      String title = tup.$1;
      String? link = tup.$2;

      var widget = listTile(context, title, link);
      if (widget != null) {
        listTiles.add(widget);
      }
    }
    //Settings
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

    //Dev

    for ((String, String) tup in devItems) {
      listTiles.add(devTile(context, tup.$1, tup.$2));
    }

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

class DevListTile extends StatelessWidget {
  final String title;
  final String link;
  const DevListTile({super.key, required this.title, required this.link});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: const Key("ListTile"),
      style: ListTileStyle.drawer,
      tileColor: Secondary.shade5,
      textColor: Secondary.shadee,
      iconColor: Secondary.shadee,
      leading: const Icon(Icons.construction),
      title: Text(title),
      onTap: () {
        if (link.isEmpty) {
          //home
          context.go('/', extra: {});
        } else {
          context.go('/$link');
        }
      },
    );
  }
}
