import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/error_page_button.dart';
import 'package:soyourhomeworld/frontend/pages/server_offline_error.dart'
    deferred as server_offline_lib;

import '../elements/widgets/deferred_load_tools.dart';
import '../icons.dart';
import 'base_error_page.dart';

//TODO: It will be easier to paste the code in here

Widget errorPageBuilder(
    BuildContext context, Object? exception, Object? stackTrace) {
  if (exception == null) {
    return ErrorPage(
      header: 'Null error!',
      parenthetical: '(worst case!)',
      illustration: RpgAwesome.cancel,
      button: const ErrorPageButton.tooBusted(),
      exception: exception,
      stackTrace: null,
    );
  }

  String errorType = exception.runtimeType.toString();
  if (errorType == '_ClientSocketException') {
    return DeferredPage(
        key: const Key("DeferredServerOffline"),
        loader: server_offline_lib.loadLibrary,
        builder: (context) => server_offline_lib.ServerOfflinePage(
            exception: exception, stackTrace: stackTrace));
  }

  return ErrorPage(
    header: exception.toString(),
    parenthetical: '($errorType)',
    illustration: null,
    button: ErrorPageButton.goHome(context: context),
    exception: exception,
    stackTrace: stackTrace,
  );
}
