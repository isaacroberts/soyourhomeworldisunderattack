import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/components/marquee_text.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/subtitle.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

import '../../../backend/chapter_holder.dart';
import '../../theme/colors.dart';

class DrivenAppBar extends StatefulWidget {
  final ChapterHolder? chapter;
  final HeaderOfText? header;
  final Animation<double> animation;
  const DrivenAppBar(
      {super.key,
      required this.chapter,
      required this.header,
      required this.animation});

  @override
  State<DrivenAppBar> createState() => _DrivenAppBarState();
}

class _DrivenAppBarState extends State<DrivenAppBar> {
  Animation<double> get animation => widget.animation;
  ChapterHolder? get chapter => widget.chapter;

  bool get fullyContracted => animation.value == 0;
  bool get partiallyExpanded => animation.value > 0;
  bool get fullyExpanded => animation.value >= 1;

  Widget column(BuildContext context) {
    return Column(
      key: const Key("col"),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            key: const Key("row1Size"),
            height: 60,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                //Row

                child: HeadingTitleRow(
                    header: chapter?.chapter?.header, chapter: chapter))),
        //Replaces divider with color change
        // const SizedBox(height: 6),

        Container(
            height: 60,
            //Other 6 px of divider
            // padding: const EdgeInsets.only(top: 8),
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Primary.shade5, width: 1))
                // color: Color(0x2faaaaaa),
                // color: CanvasColor.shade1,
                ),
            //Only render child on expanded
            alignment: Alignment.center,
            child: ChapterHeadingSubtitle(
                key: const Key("Subtitle"), chapter: chapter)),
      ],

      //Bookmark Button
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        key: const Key("Switcher"),
        child:
            _OverflowWrap(key: const Key('overflow'), child: column(context)));
  }
}

class HeadingTitleRow extends StatelessWidget {
  const HeadingTitleRow({
    super.key,
    required this.chapter,
    required this.header,
  });

  final ChapterHolder? chapter;
  final HeaderOfText? header;

  @override
  Widget build(BuildContext context) {
    late final Color headerColor;
    late final TextStyle headerStyle;
    HeaderOfText? header = this.header;
    if (header is CustomHeaderOfText) {
      headerColor = header.font.color ?? textColor;

      //TODO: Figure out Rubik headers issue
      // Then Use Holder element so CustomHeaders can be shown
      //TODO: Fallback instancing?
      // headerStyle = header.font.instance();
      //TODO: This is disabling header styles
      headerStyle = headerFont;
    } else {
      headerColor = textColor;
      headerStyle = headerFont;
    }
    double screenWidth = MediaQuery.sizeOf(context).width;

    Widget title = MarqueeText.lazy(
      key: const Key("MarqueeText"),
      text: header?.text ?? '...',
      style: headerStyle,
      alignment: Alignment.center,
    );

    if (screenWidth < 400) {
      return SizedBox(
          height: 60,
          child: Center(
            child: title,
          ));
    }

    return Row(
      key: const Key("headerRow"),
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            key: const Key('bkmk_sb'),
            width: 60,
            child: Align(
                key: const Key("bkmk_align"),
                alignment: Alignment.center,
                child: Padding(
                    key: const Key("bkmk_pad_elem"),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      '${chapter?.id}.',
                      style:
                          bodyFont.copyWith(fontSize: 18, color: headerColor),
                    )))),
        // _BookmarkPadding(
        //     key: const Key('bkmk_pad'),
        //     chapter: chapter,
        //     headerColor: headerColor),
        Expanded(child: Center(child: title)),
        //Ensure header centers
        const SizedBox(width: 60),
      ],
    );
  }
}

class _OverflowWrap extends StatelessWidget {
  final Widget child;
  const _OverflowWrap({required super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
            alignment: Alignment.topCenter, maxHeight: 120, child: child));
  }
}
