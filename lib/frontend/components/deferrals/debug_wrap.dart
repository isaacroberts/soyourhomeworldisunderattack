import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/debug/holder_debug_sliver.dart'
    deferred as lib;

import '../../elements/holders/holder_base.dart';
import '../../elements/holders/textholders.dart';

class DeferredTextHolderDebugSliver extends StatelessWidget {
  final TextHolder holder;

  const DeferredTextHolderDebugSliver({super.key, required this.holder});

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
    return lib.TextHolderDebugSliver(holder: holder);
  }
}

class DeferredHolderDebugSliver extends StatelessWidget {
  final Holder holder;

  const DeferredHolderDebugSliver({super.key, required this.holder});

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
    return lib.HolderDebugSliver(holder: holder);
  }
}

class DeferredBodyDebugSliver extends StatelessWidget {
  final BodyTextElement holder;

  const DeferredBodyDebugSliver({super.key, required this.holder});

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
    return lib.BodyDebugSliver(holder: holder);
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
    return lib.CodeDebugSliver(holder: holder, showFonts: showFonts);
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
