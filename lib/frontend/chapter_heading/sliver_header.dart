import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({required super.key});

  @override
  Widget build(BuildContext context) {
    ChapterProvider provider = ChapterProvider.of(context);
    int level = provider.chapter?.info.level ?? 2;
    return provider.part.buildHeader(context, level);
  }
}
