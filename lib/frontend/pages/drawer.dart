import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const List<(String, String?)> drawerItems = [
  ('Keep reading', null),
  ('Home', 'home'),

  // ("Library", 'library'),
  ("Index", 'index'),
  // ('Downloads', 'downloads'),
  // ('Access', 'access'),
  // ('Shop', 'shop'),
  ('Dev Page', 'dev_page'),

  // ('Quiz', 'quiz'),

  ("Test Rig", 'testrig'),

  ("Error logger", 'logger'),
  ('Cause error', 'error'),
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
      context.go('/');
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
