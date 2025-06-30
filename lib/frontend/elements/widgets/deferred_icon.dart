import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/icons.dart' deferred as icons_lib;

class DeferredRpgIcon extends StatelessWidget {
  final int iconIx;
  final double size;
  final Color color;
  const DeferredRpgIcon(
      {super.key,
      required this.iconIx,
      required this.size,
      required this.color});

  @override
  Widget build(BuildContext context) {
    Future future = icons_lib.loadLibrary();
    return FutureBuilder(future: future, builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return Icon(icons_lib.RpgAwesome.values[iconIx],
          size: size, color: color);
    } else {
      return Container(
          decoration: BoxDecoration(border: Border.all(color: color, width: 1)),
          width: size,
          height: size);
    }
  }
}

class DeferredRpgIconPicker extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  const DeferredRpgIconPicker(this.icon,
      {super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    Future future = icons_lib.loadLibrary();
    return FutureBuilder(future: future, builder: builder);
  }

  int? findIndex() {
    for (int n = 0; n < icons_lib.RpgAwesome.values.length; ++n) {
      if (icon == icons_lib.RpgAwesome.values[n]) {
        return n;
      }
    }
    return null;
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasError) {
      int? iconIndex = findIndex();
      if (iconIndex == null) {
        dev.log("Could not find Icon index???");
        iconIndex = icons_lib.RpgAwesome.errorIconIndex;
      } else {
        dev.log("Icon == $iconIndex");
      }
      return Icon(icons_lib.RpgAwesome.values[iconIndex],
          size: size, color: color);
    } else {
      return Container(
          decoration: BoxDecoration(border: Border.all(color: color, width: 1)),
          width: size,
          height: size);
    }
  }
}
