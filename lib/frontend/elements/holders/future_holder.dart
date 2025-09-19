import 'package:flutter/material.dart';

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
  Widget sliver(BuildContext context) {
    if (resolvedHolder != null) {
      return resolvedHolder!.sliver(context);
    }
    return FutureBuilder(
        key: Key("FH_$hashCode"), future: holder, builder: futureBuilder);
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot<Holder> snapshot) {
    if (snapshot.hasData) {
      resolvedHolder = snapshot.data!;
      return snapshot.data!.sliver(context);
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .element(context);
    } else {
      return const SliverToBoxAdapter(
          child: SizedBox(
              height: 150,
              child: TriWizardLoader(
                message: 'Getting code element',
              )));
    }
  }

  @override
  Widget element(BuildContext context) {
    if (resolvedHolder != null) {
      return resolvedHolder!.element(context);
    }
    //I think even on the fallback, try to show these
    //So far this is only used for code
    return FutureBuilder(future: holder, builder: fallbackFutureBuilder);
  }

  @override
  Widget fallback(BuildContext context) {
    if (resolvedHolder != null) {
      return resolvedHolder!.fallback(context);
    }
    //I think even on the fallback, try to show these
    //So far this is only used for code
    return FutureBuilder(future: holder, builder: fallbackFutureBuilder);
  }

  Widget fallbackFutureBuilder(
      BuildContext context, AsyncSnapshot<Holder> snapshot) {
    if (snapshot.hasData) {
      resolvedHolder = snapshot.data!;
      return snapshot.data!.fallback(context);
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .element(context);
    } else {
      return const SizedBox(
          height: 150,
          child: TriWizardLoader(
            message: 'Getting code element (fallback)',
          ));
    }
  }

  @override
  Widget debugSliver(BuildContext context) {
    if (resolvedHolder != null) {
      return resolvedHolder!.debugSliver(context);
    } else {
      return super.debugSliver(context);
    }
  }
}
