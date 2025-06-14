import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ballot_screen.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/ad_list.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/andy_thumbnail.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/greenland_game.dart';
import 'package:soyourhomeworld/frontend/pages/404page.dart';
import 'package:soyourhomeworld/frontend/pages/downloads.dart';
import 'package:soyourhomeworld/frontend/pages/library_page.dart';
import 'package:soyourhomeworld/frontend/pages/redirect_page.dart';

import '../../backend/error_handler.dart';
import '../pages/index.dart';
import '../scroller_door.dart';

Widget devPage(BuildContext context, GoRouterState state) {
  if (state.pathParameters.isNotEmpty) {}
  return const McScaffold(
      source: 'dev_page',
      child: BallotScreen(holder: BallotHolder(isExtended: true)));
  return const AndyThumbnailHolder(spans: []).element(context);
  return const GreenlandGamePage();
  return const AdList();
}

GoRouter router() {
  return GoRouter(
      errorPageBuilder: (context, state) {
        if (state.error.hashCode == 404) {
          return MaterialPage(
              child: FourOhFourPage(
            whatsMissing: state.pageKey.value,
          ));
        } else {
          return MaterialPage(
              child: ErrorCodePage(
                  code: state.error.hashCode, error: state.error?.message));
        }
      },
      initialLocation: kDebugMode ? '/dev_page' : '/',
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
            return ScrollDoor(startChapter: number ?? 0);
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
            dev.log("Looking for chapter: $chapterName");
            return NamedChapterScrollerDoor(
              testRig: false,
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
        name: 'testrig',
        path: '/testrig',
        // path: '/testrig/:chid',
        builder: (context, state) {
          // try {
          String numStr = state.pathParameters['chid'] ?? '0';

          int? number = int.tryParse(numStr);
          dev.log('Go parsed $number');
          return ScrollDoor(startChapter: number ?? 0, testRig: true);
          // } catch (exception) {
          //   dev.log("Exception!");
          //   dev.log('$exception');
          //   ErrorList.registerError(exception);
          //   return ErrorList.instance.page(context);
          // }
        }),

    GoRoute(
        name: 'ticketstogreenland',
        path: '/ticketstogreenland',
        builder: (context, state) {
          return const GreenlandGamePage();
        }),
    GoRoute(
        name: 'redirect',
        // path: '/scroll',
        path: '/redirect/:pname',
        builder: (context, state) {
          String? pathName = state.pathParameters['pname'];
          return RedirectPage(
            redirectTo: '/$pathName',
          );
        }),
    GoRoute(
        path: '/library',
        builder: (context, state) => const BookSelectorPage()),

    GoRoute(
        path: '/index',
        builder: (context, state) => const SearchIndexPage(searchTerm: null)),
    GoRoute(path: '/404', builder: (context, state) => const FourOhFourPage()),

    GoRoute(path: '/dev_page', builder: devPage),

    // GoRoute(path: '/shop', builder: (context, state) => const ShopPage()),
    // GoRoute(path: '/quiz', builder: (context, state) => const QuizPage()),

    GoRoute(
        path: '/downloads', builder: (context, state) => const DownloadsPage()),
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
