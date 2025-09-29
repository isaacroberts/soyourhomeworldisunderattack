import 'package:flutter/material.dart';

import '../elements/holders/holder_base.dart';
import 'debug_pane.dart' deferred as pane_lib;

Future<void> showDebugPane(BuildContext context, Holder holder) async {
  await pane_lib.loadLibrary();
  if (context.mounted) {
    Navigator.push(
        context, pane_lib.HolderDebugDialog(holder: holder, nestLevel: 0));
  }
}
