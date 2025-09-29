import 'dart:async';
import 'dart:developer' as dev;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/backend/start_chapter.dart';
import 'package:soyourhomeworld/frontend/book_waiter.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import 'backend/error_handler.dart';
//TODO: Conditional import (debugMode)
import 'frontend/debug/debug_scaffold.dart';
import 'frontend/parts/noir_colors.dart';
import 'frontend/parts/noir_theme.dart';
import 'frontend/scrollers/sliver_scroller.dart';
import 'router.dart' as router_lib;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: noirBarColor,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  FlutterError.onError = (FlutterErrorDetails details) {
    //details.silent = whether error should be silent in release mode
    if (!(details.silent && kReleaseMode)) {
      dev.log('\n\n');
      dev.log(" -!- FlutterErrorDetails (${details.library}) -!- ");

      dev.log(details.exceptionAsString());
      dev.log(details.toString());
      if (details.exception == null || details.exception == 'null') {
        dev.log("(Null exception");
      }
      ErrorList.silentLogError(details.exception, details.stack);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    dev.log(' -!- Platform Error -!- ');
    ErrorList.logError(error, stack);
    return true;
  };

  if (kDebugMode && false) {
    runApp(const DebugApp());
  } else {
    runApp(const MyApp());
  }
}

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: noirTheme,
        title: 'Help! My Debugging!',
        home: const McDebugScaffold(
            child: BookWaiter(
          child: SliverScroller(
            key: Key('DebugSliverScroller'),
            startChapter: IntStartChapter(0),
            hasIndex: false,
          ),
        )));
  }
}

final ViewSettings settings = ViewSettings.defaultsThenLoad();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: const Key('ROUTER'),
      title: 'Help! My Homeworld!',
      routerConfig: router_lib.router(),

      theme: noirTheme,
      themeMode: ThemeMode.dark,
      //Blocks the drawer
      debugShowCheckedModeBanner: false,
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
    );
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
