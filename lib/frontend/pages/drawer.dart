import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view_settings.dart';

const List<(String, String?)> drawerItems = [
  ('Keep reading', null),
  ('Home', 'home'),
  ("Index", 'index'),
  ('Shop', 'search/tshirts/'),
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
    dev.log("ViewSettings values: ${ViewSettings.instance.toString()}");
    listTiles.add(SwitchListTile(
        title: const Text('Dev Rig'),
        value: ViewSettings.instance.useTestRig,
        onChanged: (b) => ViewSettings.instance.useTestRig = b));
    // listTiles.add(SwitchListTile(
    //     title: const Text('Infinite scroll'),
    //     value: useInfiniteScroll,
    //     onChanged: (b) => useInfiniteScroll = b));
    listTiles.add(SwitchListTile(
        title: const Text('Fonts'),
        value: ViewSettings.instance.showFonts,
        onChanged: (b) => ViewSettings.instance.showFonts = b));
    //Drawer
    return Drawer(
        key: const ValueKey('MenuDrawer'),
        child: ListView(
          children: listTiles,
        ));
  }
}

/*

class MenuPage extends StatefulWidget {
  final String source;
  const MenuPage({super.key, required this.source});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('The McKinsey Plan'),
      ),
      body: Align(
          alignment: Alignment.centerLeft,
          child: ListView(children: [
            ListTile(
              title: const Text('Scroll'),
              onTap: () => context.go('/scroll/r'),
            ),
            ListTile(
              title: const Text('Index'),
              onTap: () => context.go('/index'),
            ),
            ListTile(
              title: const Text('Downloads'),
              onTap: () => context.go('/downloads'),
            ),
            ListTile(
              title: const Text('Error logger'),
              onTap: () => context.go('/logger'),
            )
          ])),
      // floatingActionButton: FloatingActionButton(
      //   // onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
