import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/icons.dart' deferred as icons_lib;

///Use in this file
Future _loadFuture() async {
  // if (loaded) {
  //   return true;
  // }
  _loadedFuture ??= icons_lib.loadLibrary();
  await _loadedFuture;
  // loaded=true;
  return true;
}

///Don't use
Future? _loadedFuture;

class DeferredRpgIcon extends StatelessWidget {
  ///Avoid loading the (I think heavy) RpgAwesome library
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
    Future future = _loadFuture();
    return FutureBuilder(
        key: const Key('iconDefer'), future: future, builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return Icon(
          key: const Key('dIcon'),
          icons_lib.RpgAwesome.values[iconIx],
          size: size,
          color: color);
    } else {
      return Container(
          key: const Key('preIcon'),
          //Should look like a loader
          decoration: BoxDecoration(
            //More like an icon
            shape: BoxShape.circle,
            color: color,
          ),
          width: size,
          height: size);
    }
  }
}
