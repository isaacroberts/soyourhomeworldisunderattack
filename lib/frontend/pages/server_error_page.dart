import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/pages/404page.dart'
    deferred as four04_lib;

import '../elements/scaffold.dart';

Page<dynamic> serverErrorPageBuilder(BuildContext context, state) {
  return MaterialPage(
      child: McScaffold(
          source: null,
          child: FutureBuilder(
              future: four04_lib.loadLibrary(),
              builder: (context, libSnapshot) {
                if (libSnapshot.hasData) {
                  if (state.error.hashCode == 404) {
                    return four04_lib.FourOhFourPage(
                      whatsMissing: state.pageKey.value,
                    );
                  } else {
                    return four04_lib.ErrorCodePage(
                        code: state.error.hashCode,
                        error: state.error?.message);
                  }
                } else if (libSnapshot.hasError) {
                  ErrorList.logError(
                      libSnapshot.error!, libSnapshot.stackTrace);
                  return ErrorList.instance.page(context);
                } else {
                  return const TriWizardLoader(
                    text: 'Loading error page...',
                  );
                }
              })));
}
