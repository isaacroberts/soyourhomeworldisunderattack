import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/slivers/null_slivers.dart';

import '../../../backend/error_handler.dart';
import '../widgets/loader.dart';
import 'holder_base.dart';

class FutureHolder extends Holder {
  /// CodeElements must be deferred code loaded
  /// So this is the FutureHolder
  final Future<Holder> holder;
  Holder? resolvedHolder;
  final String? displayName;
  FutureHolder(this.holder, {this.displayName});

  @override
  String toText() {
    if (resolvedHolder != null) {
      return resolvedHolder!.toText();
    }
    return "[Loading $displayName...]";
  }

  @override
  String toString() {
    if (resolvedHolder != null) {
      return 'ResolvedFuture(${resolvedHolder!.toString()})';
    }
    return "Future ($displayName...)";
  }

  @override
  Widget element(BuildContext context) {
    if (resolvedHolder != null) {
      return resolvedHolder!.element(context);
    }
    return FutureBuilder(
        key: Key('ftr_$id'), future: holder, builder: futureBuilder);
  }

  @override
  Widget sliver(BuildContext context) {
    if (resolvedHolder != null) {
      return resolvedHolder!.sliver(context);
    }
    return FutureBuilder(
        key: Key("ftr_$id"), future: holder, builder: futureSliverBuilder);
  }

  @override
  Widget debugSliver(BuildContext context) {
    if (resolvedHolder != null) {
      return resolvedHolder!.debugSliver(context);
    } else {
      return FutureBuilder(
          key: Key('ftr_$id'),
          future: holder,
          builder: futureDebugSliverBuilder);
    }
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot<Holder> snapshot) {
    if (snapshot.hasData) {
      resolvedHolder = snapshot.data!;
      return snapshot.data!.sliver(context);
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .element(context);
    } else {
      return const SizedTriWizardLoader();
    }
  }

  Widget futureSliverBuilder(
      BuildContext context, AsyncSnapshot<Holder> snapshot) {
    if (snapshot.hasData) {
      resolvedHolder = snapshot.data!;
      return snapshot.data!.sliver(context);
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .sliver(context);
    } else {
      return const SmallLoadSliver();
    }
  }

  Widget futureDebugSliverBuilder(
      BuildContext context, AsyncSnapshot<Holder> snapshot) {
    if (snapshot.hasData) {
      resolvedHolder = snapshot.data!;
      return snapshot.data!.debugSliver(context);
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .sliver(context);
    } else {
      return const SmallLoadSliver();
    }
  }

  //No free labor, king.
  @override
  void sweepForColor(Color find, Color? repl) {}
}
