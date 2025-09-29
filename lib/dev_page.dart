// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/book_waiter.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/special_widgets/ad_list.dart';
import 'package:soyourhomeworld/frontend/elements/special_widgets/greenland_game.dart';
import 'package:soyourhomeworld/frontend/parts/all_parts.dart';

import 'backend/book.dart';
import 'backend/chapter.dart';
import 'backend/part_id.dart';
import 'frontend/elements/holders/holder_base.dart';
import 'frontend/elements/holders/textholders.dart';
import 'frontend/parts/part.dart';

class PageWrap extends StatelessWidget {
  final Widget child;
  const PageWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return McScaffold(source: 'dev', child: Center(child: child));
  }
}

class CowboyHolderWrap extends StatefulWidget {
  final Holder holder;
  final PartId part;

  const CowboyHolderWrap(
      {super.key, required this.holder, this.part = PartId.noir});

  @override
  State<StatefulWidget> createState() => _CowboyHolderWrapState();
}

///This is needed to make sure InheritedWidgets are included
class _NestedHolderWrap extends StatelessWidget {
  final Holder holder;
  const _NestedHolderWrap({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    return holder.sliver(context);
  }
}

class _CowboyHolderWrapState extends State<CowboyHolderWrap> {
  Widget subBuilder(BuildContext context) {
    Part part = getPartImmediate(widget.part);

    return ChapterProvider(
        key: const Key('debugChpProvider'),
        chapter: Book.of(context).chapters[1],
        part: part,
        child: McScaffold(
            source: 'dev',
            child: CustomScrollView(slivers: [
              const _NestedHolderWrap(
                  key: Key('nested'),
                  holder: BodyTextElement('Lorem ipsem sit amer ')),
              _NestedHolderWrap(holder: widget.holder),
              const _NestedHolderWrap(
                  holder: BodyTextElement(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return CowboyBookBuilder(doneBuilder: subBuilder);
  }
}

class DevPage extends StatelessWidget {
  final GoRouterState routerState;
  const DevPage({super.key, required this.routerState});

  @override
  Widget build(BuildContext context) {
    if (routerState.pathParameters.isNotEmpty) {}

    // return CowboyHolderWrap(
    //     holder: NotificationTextHolder.fromSpans(
    //         data: CodeParams(dict: {'Link': 'https://google.com'}),
    //         spans: [
    //       const BodyTextElement(
    //           'WaPo: Peter Thiel signs 10 billion \$ AI contract with the DoD.')
    //     ]);

    // return const ImageUploadPage(
    //   sourceImage: 'urmom.jpg',
    // );
    // return const StdBookWaiter(
    //     child: SliverScroller(
    //   key: Key('SliverScroller'),
    //   startChapter: 1,
    // ));

    // return const AndyThumbnailHolder(spans: []).element(context);
    return const GreenlandGamePage(
      key: Key("GreenlandGame"),
    );
    return const AdList(
      key: Key("AdList"),
    );
  }
}
