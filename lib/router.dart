import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_load_tools.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/greenland_game.dart'
    deferred as greenland_game_lib;
//Deferred

//Deferred Loads
import 'package:soyourhomeworld/frontend/pages/dev_page.dart'
    deferred as dev_page_lib;
import 'package:soyourhomeworld/frontend/pages/downloads.dart'
    deferred as downloads_page_lib;
import 'package:soyourhomeworld/frontend/pages/icon_viewer.dart'
    deferred as icon_viewer_lib;
import 'package:soyourhomeworld/frontend/pages/redirect_page.dart'
    deferred as redirect_lib;

import 'backend/error_handler.dart';
import 'frontend/pages/index.dart' deferred as index_lib;
import 'frontend/pages/scrollers/scroller_door.dart';
import 'frontend/pages/server_error_page.dart';

GoRouter router() {
  return GoRouter(
      errorPageBuilder: serverErrorPageBuilder,
      initialLocation: kDebugMode ? '/' : '/',
      debugLogDiagnostics: true,
      redirect: redirector,
      routes: routes());
}

List<GoRoute> routes() {
  return [
    //Book
    GoRoute(path: '/', builder: (context, state) => const ScrollDoor()),
    // GoRoute(path: '/home', builder: (context, state) => const ScrollDoor()),

    GoRoute(
        name: 'scroll',
        // path: '/scroll',
        path: '/scroll/:chid',
        builder: (context, state) {
          try {
            String numStr = state.pathParameters['chid'] ?? '0';

            int? number = int.tryParse(numStr);
            dev.log('Go parsed $number');
            return ScrollDoor(
              startChapter: number ?? 0,
            );
          } catch (exception) {
            dev.log("Exception!");
            dev.log('$exception');
            ErrorList.logError(exception);
            return ErrorList.instance.page(context);
          }
        }),
    GoRoute(
        name: 'search',
        // path: '/scroll',
        path: '/search/:term',
        builder: (context, state) {
          try {
            String? chapterName = state.pathParameters['term'];

            return NamedChapterScrollerDoor(
              chapterName: chapterName,
            );
          } catch (exception) {
            dev.log("Exception!");
            dev.log('$exception');
            ErrorList.logError(exception);
            return ErrorList.instance.page(context);
          }
        }),

    GoRoute(
        name: 'ticketstogreenland',
        path: '/ticketstogreenland',
        builder: greenlandPageBuilder),
    GoRoute(
        name: 'redirect',
        // path: '/scroll',
        path: '/redirect/:pname',
        builder: (context, state) {
          String? pathName = state.pathParameters['pname'];
          return DeferredPage(
              loader: () => redirect_lib.loadLibrary(),
              builder: (context) => redirect_lib.RedirectPage(
                    redirectTo: '/$pathName',
                  ));
        }),

    GoRoute(
        path: '/index',
        builder: (context, state) => DeferredPage(
            loader: () => index_lib.loadLibrary(),
            builder: (context) => index_lib.SearchIndexPage(searchTerm: null))),
    // GoRoute(path: '/404', builder: (context, state) =>
    //
    // DeferredPage(loader: () => , builder: builder) FourOhFourPage()),

    GoRoute(path: '/dev_page', builder: devPageBuilder),

    GoRoute(path: '/dev_icons', builder: iconPageBuilder),

    // GoRoute(path: '/shop', builder: (context, state) => const ShopPage()),
    // GoRoute(path: '/quiz', builder: (context, state) => const QuizPage()),

    GoRoute(
        path: '/downloads',
        builder: (context, state) => DeferredPage(
            loader: () => downloads_page_lib.loadLibrary(),
            builder: (context) => downloads_page_lib.DownloadsPage())),
    GoRoute(
        path: '/logger',
        builder: (context, state) => ErrorList.instance.page(context)),
  ];
}

FutureOr<String?> redirector(BuildContext context, GoRouterState state) {
  String path = state.uri.path;
  dev.log("Redirector $path} $state");
  if (path == '/home') {
    return '/scroll/0';
  } else if (path == '/humanjacks') {
    return '/redirect/hjredirect';
  } else if (path == '/hjredirect') {
    return '/search/humanjack';
  } else {
    return null;
  }
}

Widget devPageBuilder(BuildContext context, GoRouterState routerState) {
  return DeferredPage(
      loader: dev_page_lib.loadLibrary,
      builder: (context) => dev_page_lib.DevPage(routerState: routerState));
}

Widget greenlandPageBuilder(BuildContext context, GoRouterState routerState) {
  return DeferredPage(
      loader: greenland_game_lib.loadLibrary,
      builder: (context) => greenland_game_lib.GreenlandGamePage());
}

Widget iconPageBuilder(BuildContext context, GoRouterState routerState) {
  return DeferredPage(
      loader: icon_viewer_lib.loadLibrary,
      builder: (context) => icon_viewer_lib.IconViewerPage());
}
