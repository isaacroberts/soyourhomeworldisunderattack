import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/debug/debug_wrap.dart' deferred as lib;

import '../../elements/holders/holder_base.dart';

class DeferredDebugWrap extends StatelessWidget {
  final Holder holder;
  final bool showFonts;

  const DeferredDebugWrap(
      {super.key, required this.holder, this.showFonts = true});

  @override
  Widget build(BuildContext context) {
    if (_arrived) {
      return builder(context, null);
    } else {
      _loadLibrary();
      return FutureBuilder(future: _load, builder: builder);
    }
  }

  Widget builder(BuildContext context, AsyncSnapshot? snapshot) {
    if (snapshot != null) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const SliverPadding(padding: EdgeInsets.symmetric(vertical: 12));
      }
    }
    return lib.DebugHolderWrap(holder: holder, showFonts: showFonts);
  }
}

class DeferredCodeWrap extends StatelessWidget {
  final Holder holder;
  final bool showFonts;

  const DeferredCodeWrap(
      {super.key, required this.holder, this.showFonts = true});

  @override
  Widget build(BuildContext context) {
    if (_arrived) {
      return builder(context, null);
    } else {
      _loadLibrary();
      return FutureBuilder(future: _load, builder: builder);
    }
  }

  Widget builder(BuildContext context, AsyncSnapshot? snapshot) {
    if (snapshot != null) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const SliverPadding(padding: EdgeInsets.symmetric(vertical: 12));
      }
    }
    return lib.CodeDebugWrap(holder: holder, showFonts: showFonts);
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
