import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/driven_bar.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/measure.dart';

import '../../theme/colors.dart';
import 'heading_data.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({required super.key});

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 60;
    const double expandedHeight = 120;

    ChapterHeadingData? headingData = ChapterHeadingData.maybeOf(context);

    return ChapterHeaderMeasureSliver(
        onBecomesMain: headingData?.onChapterBecomesMain,
        // child: SliverCenter(
        //     sliver: SliverConstrainedCrossAxis(
        //         maxExtent: 600,
        child: const SliverAppBar(
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          flexibleSpace: DrivenAppBar(key: Key("AppBar")),
          leadingWidth: 50,
          collapsedHeight: collapsedHeight,
          // collapsedHeight: expandedHeight,
          expandedHeight: expandedHeight,
          backgroundColor: Primary.shade2,
          surfaceTintColor: Primary.shadea,
          // backgroundColor: CanvasColor.shade1,
          scrolledUnderElevation: 4,
          forceElevated: true,
          elevation: 0,
          // shadowColor: CanvasColor.shade0,
          // surfaceTintColor: CanvasColor.shaded,
          floating: true,
          snap: false,
          pinned: true,
          stretch: false,
        ));
  }
}
