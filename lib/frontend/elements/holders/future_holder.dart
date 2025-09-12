import 'package:flutter/material.dart';

import '../../../backend/error_handler.dart';
import '../widgets/loader.dart';
import 'holder_base.dart';

class FutureHolder extends Holder {
  /// CodeElements must be deferred code loaded
  /// So this is the FutureHolder
  final Future<Holder> holder;
  final String? displayName;
  const FutureHolder(this.holder, {this.displayName});

  @override
  String toText() {
    return "[Loading $displayName...]";
  }

  @override
  Widget element(BuildContext context) {
    return FutureBuilder(
        key: Key("FH_$hashCode"), future: holder, builder: futureBuilder);
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot<Holder> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data!.element(context);
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .element(context);
    } else {
      return const SizedBox(
          height: 150,
          child: TriWizardLoader(
            message: 'Getting code element',
          ));
    }
  }

  @override
  Widget fallback(BuildContext context) {
    //I think even on the fallback, try to show these
    //So far this is only used for code
    return FutureBuilder(future: holder, builder: fallbackFutureBuilder);
  }

  Widget fallbackFutureBuilder(
      BuildContext context, AsyncSnapshot<Holder> snapshot) {
    if (snapshot.hasData) {
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
}
