import 'package:flutter/material.dart';

import '../../../backend/chapter_holder.dart';
import '../../components/marquee_text.dart';
import '../../theme/base_text_theme.dart';
import '../holders/textholders.dart';

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

    String headerText = header?.text ?? '...';
    Widget title = MarqueeText.lazy(
      key: Key("MarqueeText_$headerText"),
      text: headerText,
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
