import 'package:flutter/material.dart';

import '../../pages/drawer.dart' deferred as lib;

class DeferredDrawer extends StatelessWidget {
  final String? source;
  const DeferredDrawer({super.key, this.source});

  @override
  Widget build(BuildContext context) {
    if (_arrived) {
      return lib.MenuDrawer(key: const Key("drawer"), source: source);
    } else {
      return FutureBuilder(
          key: const Key("FutureDrawer"),
          future: _loadLibrary(),
          builder: builder);
    }
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return Container(
          key: const Key('preDrawer'),
          width: 200,
          color: const Color(0xff666688));
    }
    return lib.MenuDrawer(key: const Key("drawer"), source: source);
  }
}

Future<bool> _ll() async {
  await lib.loadLibrary();
  return true;
}

Future<bool> _loadLibrary() async {
  if (_load != null) {
    return _load!;
  }
  _load = _ll();
  _arrived = await _load!;
  return _arrived;
}

Future<bool>? _load;
bool _arrived = false;
