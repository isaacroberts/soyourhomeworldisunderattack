import 'package:flutter/material.dart';

import '../../../backend/binary_utils/code_params.dart';
import '../../../backend/chapter.dart';
import '../../parts/part.dart';
import '../../theme/timings.dart';
import '../holders/holder_base.dart';

class SourceCitationHolder extends CodeHolder {
  final String? link;
  final CodeParams params;
  const SourceCitationHolder({required this.link, required this.params});
  @override
  Widget element(BuildContext context) {
    return SourceCitation(holder: this);
  }

  @override
  Widget debugSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Text("Source:"),
          if (link != null) SelectableText(link!),
          if (link == null) const Icon(Icons.not_interested),
          TextButton(
              onPressed: () => openSource(context), child: const Text('Open')),
        ],
      ),
    );
  }

  void openSource(BuildContext context) async {
    openLinkFast(link, context);
  }

  @override
  String toText() {
    return '[Source: $link]';
  }

  String get tooltip =>
      params.readString('hover') ??
      'If into the sources you go, only pain will you find.';
}

class SourceCitation extends StatelessWidget {
  final SourceCitationHolder holder;
  String? get link => holder.link;
  const SourceCitation({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    Part part = ChapterProvider.of(context).part;
    return Container(
        key: const Key('srcCt'),
        decoration: BoxDecoration(
            color: part.secondary.s2,
            border: Border.all(color: part.secondary.s7),
            borderRadius: BorderRadius.circular(6)),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          key: const Key('srcRw'),
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Flexible(child: Text("Source:")),
            Flexible(
                child: Tooltip(
                    key: Key('src${holder.id}'),
                    message: holder.tooltip,
                    child: FilledButton(
                        key: const Key('openSource'),
                        onPressed: () => holder.openSource(context),
                        child: Text(
                          link ?? 'unavailable',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))))
          ],
        ));
  }
}
