import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/holders/span_holding_code.dart'
    show SpanHoldingCode;
import 'package:soyourhomeworld/frontend/theme/text_theme.dart';

import '../../../backend/book.dart';
import '../../theme/button_state_property.dart';
import '../../theme/colors.dart';
import '../holders/holder_utils.dart';

// final TextTheme gotoButtonTextTheme = bookTextTheme;
TextTheme get gotoButtonTextTheme => textTheme;

typedef _ChapterTooltip = (String, String);

class GotoButtonHolder extends SpanHoldingCode {
  final String? link;
  //Used to show destination
  final String? dest;
  final bool isChapter;
  final Color color;

  String get destination => dest ?? 'Unknown';
  String get linkText => link ?? 'null';
  const GotoButtonHolder(
      {required this.link,
      required this.dest,
      required super.spans,
      this.color = Colors.white,
      this.isChapter = true});

  @override
  Widget element(BuildContext context) {
    return _GotoButtonWidget(key: Key('goto_widget_$hashCode'), holder: this);
  }
}

class _GotoButtonWidget extends StatefulWidget {
  // final String? link;
  // final String? dest;
  // final String spanText;
  final GotoButtonHolder holder;
  const _GotoButtonWidget({super.key, required this.holder});

  @override
  State<StatefulWidget> createState() => _GotoButtonWidgetState();
}

class _GotoButtonWidgetState extends State<_GotoButtonWidget> {
  String? get link => widget.holder.link;
  //Used to show destination
  String? get dest => widget.holder.dest;
  bool get isChapter => widget.holder.isChapter;
  Color get color => widget.holder.color;

  String get destination => dest ?? 'Unknown';
  String get linkText => link ?? 'null';

  void onPressed(BuildContext context) {
    if (link != null) {
      if (isChapter) {
        context.go('/search/$link');
      } else {
        context.go('/$link');
      }
    } else {
      dev.log("Null link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 600,
        // child: Theme(
        //     data: bookTheme,
        child: Tooltip(
            richMessage: tooltip(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: itineraryBg),

            // message: 'Destination: ${dest ?? 'Unknown'}',
            waitDuration: const Duration(milliseconds: 1500),
            child: card(context)));
  }

  Widget explanationText(BuildContext context) {
    return Text(
      'Link: $linkText',
      style: gotoButtonTextTheme.labelLarge,
    );
  }

  Widget destText(BuildContext context) {
    return Text(
      'Going to: $destination',
      style: gotoButtonTextTheme.labelLarge,
      textAlign: TextAlign.right,
    );
  }

  Widget _buttonText(BuildContext context) {
    dev.log("GotoButton: link=$linkText, isChapter=$isChapter");
    return Text(HolderUtils.stripOutText(widget.holder.spans).trim(),
        style: gotoButtonTextTheme.displaySmall, textAlign: TextAlign.center);
  }

  Column column(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // linkText(context),
        explanationText(context),
        const SizedBox(height: 24),
        _buttonText(context),
        const SizedBox(height: 24),
        destText(context),
      ],
    );
  }

  //
  // Card card(BuildContext context) {
  //   return Card(
  //       // color: color,
  //       // surfaceTintColor: color,
  //       clipBehavior: Clip.hardEdge,
  //       child: InkWell(
  //           onTap: link == null ? null : () => onPressed(context),
  //           child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
  //               child: column(context))
  //           // const SizedBox.shrink()
  //           ));
  // }

  Widget card(BuildContext context) {
    return ElevatedButton(
        clipBehavior: Clip.hardEdge,
        onPressed: link == null ? null : () => onPressed(context),
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            overlayColor: ButtonOverlayColorProperty(
                color: color, selectedColor: planColor)),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: column(context))
        // const SizedBox.shrink()
        );
  }

  static const Color itineraryBg = Color(0xaafafcdf);

  Future<_ChapterTooltip> chapterInfo() async {
    if (link == null) {
      return ('Null', '');
    }
    //TODO:
    Book.of(context).findChapterByVarname(link!);
    // Book.of(context).chapters[]
    return ('ChapterName', 'ChapterInfo');
  }

  InlineSpan tooltip(BuildContext context) {
    if (link == null) {
      return const TextSpan(text: '(No Destination)');
    }
    return WidgetSpan(
        child: Container(
            alignment: Alignment.topLeft,
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
            child: Column(
              children: [
                Text('Destination: $destination'),
                const Divider(),

                //TODO: Get chapter

                const Text("..."),

                const Divider(),

                Text('Link: $linkText'),
              ],
            )));
  }
}
