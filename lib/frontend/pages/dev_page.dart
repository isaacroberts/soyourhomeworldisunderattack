// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/book_waiter.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/ad_list.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/greenland_game.dart';
import 'package:soyourhomeworld/frontend/pages/review_page.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/sliver_scroller.dart';

import '../elements/custom_code/goto_button.dart';
import '../elements/holders/holder_base.dart';
import '../elements/holders/textholders.dart';

class PageWrap extends StatelessWidget {
  final Widget child;
  const PageWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return McScaffold(source: 'dev', child: Center(child: child));
  }
}

class DevPage extends StatelessWidget {
  final GoRouterState routerState;
  const DevPage({super.key, required this.routerState});

  @override
  Widget build(BuildContext context) {
    if (routerState.pathParameters.isNotEmpty) {}

    return const StdBookWaiter(
        child: SliverScrollerPage(
      key: Key('SliverScroller'),
      startChapter: 1,
    ));
    const Holder holder = GotoButtonHolder(
        link: 'ValinorTickets',
        dest: 'Greenland',
        isChapter: false,
        spans: [
          BodyTextElement('Register for tickets'),
        ],
        color: Color(0xff8877ff));
    return PageWrap(child: holder.element(context));
    return const ReviewPage(
      key: Key("ReviewPage"),
    );
    // return const AndyThumbnailHolder(spans: []).element(context);
    return const GreenlandGamePage(
      key: Key("GreenlandGame"),
    );
    return const AdList(
      key: Key("AdList"),
    );
  }
}
