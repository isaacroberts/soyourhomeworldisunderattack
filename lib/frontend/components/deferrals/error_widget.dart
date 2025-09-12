import 'package:flutter/material.dart';
//Deferred load, BC everything, even early stuff needs this
import 'package:soyourhomeworld/frontend/elements/widgets/error_widgets.dart'
    deferred as lib;

import '../../../backend/error_handler.dart' deferred as error_handler;
import '../../elements/widgets/deferred_load_tools.dart';
import '../../elements/widgets/error_base.dart';

Widget page(BuildContext context) {
  if (_arrived) {
    return lib.ErrorPage(
        key: const Key("ErrorPage"),
        list: error_handler.ErrorList.instance.list);
  } else {
    return DeferredPage(
        key: const Key("ErrorDeferPage"),
        loader: _loadLibrary,
        builder: (c) => lib.ErrorPage(
            key: const Key("ErrorPage"),
            list: error_handler.ErrorList.instance.list));
  }
}

Widget stringBox(BuildContext context, {required String text}) {
//No keys because they're too likely to be similar
  return DeferredWidget(
      loader: lib.loadLibrary, builder: (c) => lib.ErrorBox(text: text));
}

Widget box(BuildContext context, Object exception, StackTrace? trace) {
//No keys because they're too likely to be repeated
//  along the scroll
  return DeferredWidget(
      loader: lib.loadLibrary,
      builder: (c) => lib.ExceptionBox.fromException(exception, trace));
}

Widget holderBox(BuildContext context, {required ExceptionHolderBase holder}) {
//No keys because they're too likely to be repeated
//  along the scroll
  return DeferredWidget(
      loader: lib.loadLibrary,
      builder: (c) {
        return lib.ExceptionBox.mashObjectIntoHolder(holder: holder);
      });
}

Widget element(BuildContext context, {required ExceptionHolderBase holder}) {
  return DeferredWidget(
      key: Key("ErrorDeferElem_${holder.hashCode}"),
      loader: lib.loadLibrary,
      builder: (c) => lib.ExceptionElement.fromHolder(
            key: Key("ExcepElem_${holder.hashCode}"),
            holder: holder,
          ));
}

void showErrorSnackBar(
    BuildContext context, ExceptionHolderBase exception, String subline) {
  lib.showErrorSnackBar(context, exception, subline);
}

Future<bool> _ll() async {
  await lib.loadLibrary();
  await error_handler.loadLibrary();
  return true;
}

Future<bool> _loadLibrary() async {
  if (_arrived) {
    return true;
  }
  if (_load != null) {
    return _load!;
  }
  _load = _ll();
  await _load;
  return true;
}

Future<bool>? _load;
bool _arrived = false;

Future errorWidgetDeferredFuture() => _loadLibrary();
