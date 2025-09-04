import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//Deferred

//Deferred Loads
import 'package:soyourhomeworld/dev_page.dart' deferred as dev_page_lib;
import 'package:soyourhomeworld/frontend/elements/special_widgets/greenland_game.dart'
    deferred as greenland_game_lib;
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_load_tools.dart';
import 'package:soyourhomeworld/frontend/pages/icon_viewer.dart'
    deferred as icon_viewer_lib;
import 'package:soyourhomeworld/frontend/pages/redirect_page.dart'
    deferred as redirect_lib;

import 'backend/error_handler.dart';
// import 'frontend/pages/games/valinor_website/valinor_website.dart'
//     deferred as valinor_lib;
import 'frontend/pages/index.dart' deferred as index_lib;
import 'frontend/pages/server_error_page.dart' deferred as error_page_lib;
import 'frontend/pages/title/title.dart' deferred as title_lib;
import 'frontend/scrollers/scroller_door.dart';

// const String devMain = '/dev_page/';
//noir
// const String devMain = '/scroll/6';
//greenland
// const String devMain = '/scroll/34';
//noir image
// const String devMain = '/scroll/20';
//title
const String devMain = '/';

Widget devPageBuilder(BuildContext context, GoRouterState routerState) {
  /// Dev Page
  return DeferredPage(
      key: const Key("DeferredDevPage"),
      loader: dev_page_lib.loadLibrary,
      builder: (context) => dev_page_lib.DevPage(routerState: routerState));
}

GoRouter router() {
  //TODO: I think this needs error handling
  return GoRouter(
      errorPageBuilder: _errorPageBuilder,
      initialLocation: (kDebugMode) ? devMain : '/',
      debugLogDiagnostics: true,
      redirect: redirector,
      routes: routes());
}

List<GoRoute> routes() {
  /// ====================================
  /// Routes
  /// ====================================

  return [
    //Book
    GoRoute(
        name: 'Home',
        path: '/',
        builder: (context, state) => const ScrollDoor(
              key: Key("ScrollDoor!"),
            )),
    GoRoute(
        name: 'Title',
        path: '/title',
        builder: (context, state) => DeferredPage(
            key: const Key("DeferredTitlePage"),
            loader: title_lib.loadLibrary,
            builder: (c) => title_lib.TitlePage(
                  key: const Key("TitlePage"),
                ))),
    // GoRoute(path: '/home', builder: (context, state) => const ScrollDoor()),
    GoRoute(
        name: 'Reader',
        // path: '/scroll',
        path: '/scroll/:chid',
        builder: scrollDoorBuilder),

    GoRoute(
        name: 'Chapter Search',
        // path: '/scroll',
        path: '/search/:term',
        builder: (context, state) {
          try {
            String? chapterName = state.pathParameters['term'];

            return NamedChapterScrollerDoor(
              key: const Key("NamedScrollDoor!"),
              chapterName: chapterName,
            );
          } catch (exception) {
            dev.log("Exception!");
            dev.log('$exception');
            ErrorList.logError(exception);
            return ErrorList.instance.page(context);
          }
        }),

    // GoRoute(name: 'Valinor', path: '/valinor', builder: valinorWebsiteBuilder),
    GoRoute(
        name: 'Tickets to Valinor',
        path: '/valinortickets',
        builder: greenlandPageBuilder),
    GoRoute(
        name: 'redirect',
        // path: '/scroll',
        path: '/redirect/:pname',
        builder: (context, state) {
          String? pathName = state.pathParameters['pname'];
          return DeferredPage(
              key: const Key("RedirectDeferral"),
              loader: () => redirect_lib.loadLibrary(),
              builder: (context) => redirect_lib.RedirectPage(
                    key: const Key("RedirectPage"),
                    redirectTo: '/$pathName',
                  ));
        }),

    GoRoute(
        name: 'Index',
        path: '/index',
        builder: (context, state) => DeferredPage(
            key: const Key("DeferredIndex"),
            loader: () => index_lib.loadLibrary(),
            builder: (context) => index_lib.SearchIndexPage(
                key: const Key("SearchIndexPage"), searchTerm: null))),
    // GoRoute(path: '/404', builder: (context, state) =>
    //
    // DeferredPage(loader: () => , builder: builder) FourOhFourPage()),

    GoRoute(path: '/dev_page', builder: devPageBuilder),

    GoRoute(path: '/dev_icons', builder: iconPageBuilder),

    // GoRoute(path: '/shop', builder: (context, state) => const ShopPage()),
    // GoRoute(path: '/quiz', builder: (context, state) => const QuizPage()),

    GoRoute(
        name: '(Dev) Error Logger',
        path: '/logger',
        builder: (context, state) => ErrorList.instance.page(context)),
  ];
}

Widget scrollDoorBuilder(BuildContext context, GoRouterState state) {
  try {
    String numStr = state.pathParameters['chid'] ?? '0';

    int? number = int.tryParse(numStr);
    dev.log('Go parsed $number');
    return ScrollDoor.nullSafe(
      key: const Key("ScrollDoor!"),
      startChapter: number,
    );
  } catch (exception) {
    dev.log("Exception!");
    dev.log('$exception');
    ErrorList.logError(exception);
    return ErrorList.instance.page(context);
  }
}

FutureOr<String?> redirector(BuildContext context, GoRouterState state) {
  String path = state.uri.path;
  dev.log("Redirector $path} ${state.path}");
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

Page _errorPageBuilder(BuildContext context, GoRouterState state) {
  return MaterialPage(
      child: DeferredPage(
          key: const Key("DeferredErrorPage"),
          loader: error_page_lib.loadLibrary,
          builder: (context) => error_page_lib.errorPageBuilder(
              context, state.error, state.extra)));
}

Widget greenlandPageBuilder(BuildContext context, GoRouterState routerState) {
  return DeferredPage(
      key: const Key("DeferredGreenland"),
      loader: greenland_game_lib.loadLibrary,
      builder: (context) => greenland_game_lib.GreenlandGamePage(
            key: const Key("GreenlandGame"),
          ));
}

Widget iconPageBuilder(BuildContext context, GoRouterState routerState) {
  return DeferredPage(
      key: const Key("DeferredIconPage"),
      loader: icon_viewer_lib.loadLibrary,
      builder: (context) => icon_viewer_lib.IconViewerPage(
            key: const Key("IconPage"),
          ));
}
