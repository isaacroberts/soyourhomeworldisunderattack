import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';

import '../../parts/noir_colors.dart';
import '../../theme/base_text_theme.dart';

// const String titleText = "Help! My Homeworld!";
const String titleText = "My Homeworld is Under Attack!";
const String? authorText = null; //'by Joseph Silverstein';

class TitleTextWide extends StatelessWidget {
  ///
  /// Standard Title & Author name
  /// Centered
  ///
  ///
  final Widget? child;
  const TitleTextWide({super.key, required this.size, this.child});

  void onPressed() {}

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //Center
              mainAxisAlignment: MainAxisAlignment.start,
              //Left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: titleFont,
                ),
                if (authorText != null) Text(authorText!, style: authorFont),
                // const SizedBox(
                //   height: 48,
                // ),
                if (child != null) child!
              ],
            )));
  }
}

class TitleTextPhone extends StatelessWidget {
  ///
  /// Put author name at the bottom of the screen
  ///
  final Widget? child;
  const TitleTextPhone({
    super.key,
    required this.size,
    this.child,
  });

  final Size size;

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: const EdgeInsets.all(12),
      height: 200,
      decoration: BoxDecoration(
        color: NoirPrimary.shadec,
        border: Border.all(color: NoirPrimary.shade0),
        borderRadius: BorderRadius.circular(24),
        // boxShadow: const [
        //   BoxShadow(
        //       offset: Offset(-5, -8),
        //       blurRadius: 5,
        //       color: NoirPrimary.shade1)
        // ]
      ),
      alignment: Alignment.center,
      child: Text(
        key: Key('titleText'),
        titleText,
        textAlign: TextAlign.left,
        style: titleFont,
      ),
    );
    return builder(context, null);
    return FutureBuilder(future: initHyphenation(), builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot? snapshot) {
    //TODO: Move
    if (snapshot?.connectionState != ConnectionState.done) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: NoirPrimary.shadec,
          border: Border.all(color: NoirPrimary.shade0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                offset: Offset(-5, -8),
                blurRadius: 5,
                color: NoirPrimary.shade1)
          ]),
      alignment: Alignment.topLeft,
      child: Text(
        key: Key('titleText'),
        titleText,
        textAlign: TextAlign.left,
        style: titleFont,
      ),
    );
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              //Put author name at the bottom of the screen
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoHyphenatingText(titleText,
                    textAlign: TextAlign.left, style: titleFont),
                if (authorText != null)
                  Text(authorText!,
                      textAlign: TextAlign.left, style: authorFont),
                // const SizedBox(height: 24),
                if (child != null) child!
              ],
            )));
  }
}

const Color _textColor = NoirPrimary.shadef;

TextStyle get titleFont => bodyFont.copyWith(
    color: NoirPrimary.shadee, fontSize: 36, fontWeight: FontWeight.w500);

TextStyle get authorFont => bodyFont.copyWith(
    color: _textColor, fontWeight: FontWeight.w400, fontSize: 24);
