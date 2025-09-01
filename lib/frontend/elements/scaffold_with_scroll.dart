import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

class ScaffoldWithScroll extends StatelessWidget {
  final Color? bg;
  final Widget? body;
  final String? source;

  ///For readability, pages shouldn't be full width.
  ///This defaults to 800 but can be set to null
  final double? maxWidth;

  final double horizPad;

  const ScaffoldWithScroll({
    super.key,
    this.bg,
    required this.source,
    required this.body,
    this.maxWidth = 800,
    this.horizPad = 12,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = Padding(
        key: const Key('pad'),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: horizPad),
        child: body);

    widget = SingleChildScrollView(
        key: const Key("scrollView"),
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: widget);

    if (maxWidth != null) {
      widget =
          SizedBox(key: const Key('maxwidth'), width: maxWidth!, child: widget);
    }

    //Center if undersized
    widget = Center(key: const Key('center'), child: widget);
    if (bg != null) {
      widget = ColoredBox(key: const Key('bgcol'), color: bg!, child: widget);
    }

    return McScaffold(key: const Key('mcscaf'), source: source, child: widget);
  }
}
