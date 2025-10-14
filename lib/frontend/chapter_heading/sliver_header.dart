import 'package:flutter/material.dart';

import '../../../backend/chapter.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({required super.key});

  @override
  Widget build(BuildContext context) {
    ChapterProvider provider = ChapterProvider.of(context);

    return provider.part.buildHeader(context);
  }
}
