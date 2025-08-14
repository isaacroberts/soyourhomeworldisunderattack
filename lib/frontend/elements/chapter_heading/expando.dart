import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/chapter_heading/subtitle.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';
import 'package:soyourhomeworld/frontend/theme/colors.dart';

import '../../../backend/chapter_holder.dart';

class ExpandoAppBar extends StatefulWidget {
  final ChapterHolder? chapter;
  const ExpandoAppBar({super.key, required this.chapter});

  @override
  State<ExpandoAppBar> createState() => _ExpandoAppBarState();
}

bool _expanded = false;

class _ExpandoAppBarState extends State<ExpandoAppBar> {
  bool hovered = false;
  // bool _expanded = false;
  bool get expanded => hovered || _expanded;
  ChapterHolder? get chapter => widget.chapter;

  void toggleExpand() {
    if (mounted) {
      setState(() {
        _expanded = !_expanded;
      });
    }
  }

  void setHover(bool set) {
    if (set != hovered) {
      setState(() {
        hovered = set;
      });
    }
  }

  void setExpand(bool set) {
    //No idea why it's reversed
    set = !set;
    if (mounted & set != _expanded) {
      setState(() {
        _expanded = set;
      });
    }
  }

  void setReverseExpand(bool set) {
    //No idea why it's reversed
    setExpand(!set);
  }

  Widget row1(BuildContext context) {
    return Row(
      key: const Key("headerRow"),
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            key: const Key("expandoIconButton"),
            onPressed: toggleExpand,
            icon: AnimatedRotation(
              key: const Key("rotatingExpando"),
              turns: expanded ? .75 : 1,
              duration: const Duration(milliseconds: 250),
              child: const Icon(key: Key("expandIcon"), Icons.expand_more),
            )),
        //TODO: Use Holder element so CustomHeaders can be shown
        //Right now they're all getting labelled as Rubik
        Text(
          chapter?.chapter?.header?.text ?? '-',
          style: headerFont,
        ),
        // chapter?.header?.element(context) ??
        //     const Text(
        //       '-',
        //       style: headerFont,
        //     ),
        const SizedBox(width: 60),
      ],
    );
  }

  Widget column(BuildContext context) {
    return Column(
      key: const Key("stack"),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(key: const Key("row1Size"), height: 48, child: row1(context)),
        //Replaces divider with color change
        const SizedBox(height: 6),

        Container(
            height: 60,
            //Other 6 px of divider
            padding: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              //Color
              color: canvasFade,
              //Match outside border
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9)),
            ),
            //Only render child on expanded
            child: expanded
                ? ChapterHeadingSubtitle(
                    key: const Key("Subtitle"), chapter: chapter)
                : null),
      ],
    );
  }

  Widget overflowWrap(Widget child) {
    return ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
            alignment: Alignment.topCenter, maxHeight: 120, child: child));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        key: const Key("inkwell"),
        onTap: toggleExpand,
        onHover: setHover,
        child: AnimatedContainer(
            key: const Key("Switcher"),
            duration: const Duration(milliseconds: 300),
            height: expanded ? 120 : 60,
            decoration: BoxDecoration(
                color: canvasSlightElevation,
                border: Border.all(color: canvasFade, width: 3),
                borderRadius: BorderRadius.circular(12)),
            child: overflowWrap(column(context))));
  }
}
