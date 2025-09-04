// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/book_waiter.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/special_widgets/ad_list.dart';
import 'package:soyourhomeworld/frontend/elements/special_widgets/greenland_game.dart';
import 'package:soyourhomeworld/frontend/pages/image_upload_page.dart';
import 'package:soyourhomeworld/frontend/pages/review_page.dart';
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';

import 'backend/book.dart';
import 'backend/chapter.dart';
import 'frontend/elements/custom_code/goto_button.dart';
import 'frontend/elements/holders/holder_base.dart';
import 'frontend/elements/holders/textholders.dart';

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

    return const ImageUploadPage(
      sourceImage: 'urmom.jpg',
    );
    // return const StdBookWaiter(
    //     child: SliverScroller(
    //   key: Key('SliverScroller'),
    //   startChapter: 1,
    // ));
    const Holder holder = GotoButtonHolder(
        link: 'ValinorTickets',
        isChapter: false,
        spans: [
          BodyTextElement('Register for tickets'),
        ],
        color: Color(0xff8877ff));
    return CowboyBookBuilder(
        doneBuilder: (context) => ChapterProvider(
            key: const Key("DevChpProvider"),
            chapter: Book.of(context).chapters[1],
            part: const PartNoir(),
            child: PageWrap(child: holder.element(context))));
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
