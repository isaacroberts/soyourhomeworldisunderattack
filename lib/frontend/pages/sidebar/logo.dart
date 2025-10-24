import 'package:flutter/material.dart';

import '../../../backend/book.dart';
import '../../parts/part.dart';
import '../../theme/base_text_theme.dart';
import '../../theme/layout_constants.dart';
import '../../theme/timings.dart';

///Just the word Homeworld to show you what site you're on
class SiteLogo extends StatelessWidget {
  const SiteLogo({
    required super.key,
    required this.part,
  });

  final Part part;

  @override
  Widget build(BuildContext context) {
    return Container(
        key: const Key('logoCtr'),
        decoration: BoxDecoration(
            color: part.primary.s4,
            border:
                Border(bottom: BorderSide(color: part.primary.s2, width: 1))),
        height: appBarSize,
        padding: const EdgeInsets.all(12),
        alignment: Alignment.centerLeft,
        child: TextButton(
            key: const Key('logoButton'),
            onPressed: () {},
            child: Text(
              key: const Key('logoTxt'),
              'Homeworld',
              style: headerFont(color: part.primary.sc),
              textAlign: TextAlign.start,
            )));
  }
}

///Just the letter H. To show you what site you're on
class CollapsedSiteLogo extends StatelessWidget {
  const CollapsedSiteLogo({
    required super.key,
    required this.part,
  });
  final Part part;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: 'Homeworld.help',
        child: Container(
            key: const Key('logoCtr'),
            decoration: BoxDecoration(
              color: part.primary.s4,
              // border: Border(
              //     bottom: BorderSide(color: NoirPrimary.shade2, width: 1)),
            ),
            height: appBarSize,
            // padding: const EdgeInsets.all(12),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            child: TextButton(
                key: const Key('logoButton'),
                onPressed: () {
                  scrollToChapter(Book.maybeOf(context)?.chapters[0],
                      context: context);
                },
                child: Text(
                  key: const Key('lgoTxt'),
                  'H',
                  style: headerFont(color: part.primary.sc),
                  textAlign: TextAlign.start,
                ))));
  }
}
