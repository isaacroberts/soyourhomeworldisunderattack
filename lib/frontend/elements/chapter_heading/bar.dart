import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/bar_driver.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/driven_bar.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/measure.dart';

import '../../../backend/chapter_holder.dart';
import '../../theme/colors.dart';
import '../holders/textholders.dart';
import 'heading_data.dart';

class SliverHeader extends StatelessWidget {
  final ChapterHolder? chapter;
  final HeaderOfText? header;
  const SliverHeader({super.key, required this.chapter, required this.header});

  Widget animBuilder(BuildContext context, Animation<double> anim) {
    return DrivenAppBar(
        key: Key("AppBar${chapter?.varName}"),
        chapter: chapter,
        header: chapter?.chapter?.header,
        animation: anim);
  }

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 60;
    const double expandedHeight = 120;

    ChapterHeadingData? headingData = ChapterHeadingData.maybeOf(context);

    return ChapterHeaderMeasureSliver(
        chapter: chapter,
        onBecomesMain: headingData?.onChapterBecomesMain,
        // child: SliverCenter(
        //     sliver: SliverConstrainedCrossAxis(
        //         maxExtent: 600,
        child: SliverAppBar(
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          flexibleSpace: AppBarSizeDriver(
              minExtent: collapsedHeight,
              maxExtent: expandedHeight,
              builder: animBuilder),
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
