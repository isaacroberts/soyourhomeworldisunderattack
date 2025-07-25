import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

class ScaffoldWithScroll extends StatelessWidget {
  final Color? bg;
  final Widget? child;
  final String? source;
  const ScaffoldWithScroll({
    super.key,
    this.bg,
    required this.source,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (bg == null) {
      return McScaffold(source: source, child: buildSingleChildScrollView());
    } else {
      return McScaffold(
          source: source,
          child: ColoredBox(color: bg!, child: buildSingleChildScrollView()));
    }
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24), child: child));
  }
}
