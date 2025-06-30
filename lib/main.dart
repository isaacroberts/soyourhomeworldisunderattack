import 'dart:async';
import 'dart:developer' as dev;
import 'dart:ui';

import 'package:flutter/material.dart';
//Checked imports
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

//Loaded directly

//Deferred load
import 'backend/error_handler.dart';
import 'frontend/text_theme.dart';
import 'router.dart' as router_lib;

Future<void> main() async {
  // if (kDebugMode) {
  //   runApp(const MyStatefulApp());
  // } else {
  runApp(const MyApp());
  // }

  // runApp(const ProviderScope(child: MyStatefulApp()));
}

final ViewSettings settings = ViewSettings.defaultsThenLoad();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future future() async {
    dev.log("Loading router");
    // return router_lib.loadLibrary();
    // var f = await router_lib.loadLibrary();
    // dev.log("Loaded router $f");
    return 'hi';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: const Key('ROUTER'),
      title: 'The McKinsey Plan',
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      theme: theme,
      themeMode: ThemeMode.dark,
      routerConfig: router_lib.router(),
      // showPerformanceOverlay: true,
    );
    return FutureBuilder(future: future(), builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      dev.log("Router load error");
      ErrorList.logError(snapshot.error!, snapshot.stackTrace);
      return MaterialApp(
          title: 'The McKinsey Plan',
          scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
          theme: theme,
          themeMode: ThemeMode.dark,
          home: ErrorList.instance.page(context));
    } else if (snapshot.connectionState == ConnectionState.done) {
      dev.log("Got lib: ${snapshot.data}");
      //TODO: I think move this under the router, using a wrapper to distribute the ViewSettings and an instance to single-ize.
      //Then, see if that fixes it.
      // Router
      //    ViewSettingsProvider
      //       Scaffold
      //           Deferred Loaders (which seem like they have to be stateful)
      return MaterialApp.router(
        key: const Key('ROUTER'),
        title: 'The McKinsey Plan',
        scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
        theme: theme,
        themeMode: ThemeMode.dark,
        routerConfig: router_lib.router(),
        // showPerformanceOverlay: true,
      );
    } else {
      // dev.log("Loadingpage: ${snapshot.connectionState} ${snapshot.}");
      return MaterialApp(
          title: 'The McKinsey Plan',
          scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
          theme: theme,
          themeMode: ThemeMode.dark,
          home: const McScaffold(
              source: null,
              child: Center(
                  child: TriWizardLoader(
                text: 'Loading router',
              ))));
    }
  }
}

class NoThumbScrollBehavior extends ScrollBehavior {
  // const NoThumbScrollBehavior() : super(sh)
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}
