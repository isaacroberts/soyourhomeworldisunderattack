import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/holder_base.dart';

import '../../parts/part.dart';

class GoogleSearchHolder extends CodeHolder {
  final String? term;
  const GoogleSearchHolder({required this.term});

  @override
  Widget element(BuildContext context) {
    Part part = Part.of(context);
    return Container(
      // height: 24,
      width: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: part.primary.sf),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      child: Container(
          decoration: BoxDecoration(
              border: Border(right: BorderSide(color: part.primary.s3))),
          padding: const EdgeInsets.only(right: 3),
          child: searchContent(context, part)),
    );
  }

  Widget searchContent(BuildContext context, Part part) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(
                Icons.search,
                color: part.primary.s3,
              )),
          text(part),
        ]);
  }

  Widget text(Part part) {
    return Text(
      term ?? '(null)',
      style:
          part.bodyFont.copyWith(fontFamily: 'Rubik', color: part.primary.s0),
    );
  }

  @override
  String toText() {
    return "Google Search: $term";
  }

  @override
  Widget debugSliver(BuildContext context) {
    return sliver(context);
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverToBoxAdapter(child: element(context));
  }
}
