import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/frontend/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

class _RpgIconDisplay extends StatelessWidget {
  final int ix;
  const _RpgIconDisplay({super.key, required this.ix});

  void copyText() {
    String name = RpgAwesome.names[ix];
    dev.log("Copied RpgAwesome.$name");
    Clipboard.setData(ClipboardData(text: 'RpgAwesome.$name'));
  }

  @override
  Widget build(BuildContext context) {
    bool inBounds = RpgAwesome.values.length > ix;
    String name = inBounds ? RpgAwesome.names[ix] : 'null';
    return Center(
        child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0x88666666))),
            child: Tooltip(
                decoration: const BoxDecoration(
                  color: Color(0xff000000),
                ),
                textStyle: appFont.copyWith(fontSize: 12),
                enableTapToDismiss: false,
                exitDuration: const Duration(seconds: 0),
                message: '$name ($ix)',
                waitDuration: const Duration(milliseconds: 1000),
                child: MaterialButton(
                    onPressed: copyText,
                    child: Icon(
                      inBounds ? RpgAwesome.values[ix] : null,
                      size: 50,
                    )))));
  }
}

class IconViewerPage extends StatelessWidget {
  const IconViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'dev_icon',
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemBuilder: (c, ix) => _RpgIconDisplay(ix: ix),
          itemCount: RpgAwesome.values.length + 1,
        ));
  }
}
