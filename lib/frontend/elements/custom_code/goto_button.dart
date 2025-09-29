import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/holders/holder_base.dart';
import 'package:soyourhomeworld/frontend/elements/holders/span_holding_code.dart'
    show SpanHoldingCode;

import '../../../backend/book.dart';
import '../../../backend/chapter.dart';
import '../../components/button_state_property.dart';
import '../../parts/part.dart';
import '../../theme/base_colors.dart';
import '../holders/holder_utils.dart';

class GotoButtonHolder extends SpanHoldingCode {
  final String? link;
  final bool isChapter;
  final Color color;

  String get linkText => link ?? 'null';
  const GotoButtonHolder(
      {required this.link,
      required super.spans,
      this.color = Colors.white,
      this.isChapter = true});

  @override
  Widget element(BuildContext context) {
    return _GotoButtonWidget(key: Key('goto_widget_$id'), holder: this);
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverToText(
        key: Key(id),
        child: _GotoButtonWidget(key: Key('goto_widget_$id'), holder: this));
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
  late Part part;

  Chapter? destination;
  String? where;
  String? when;

  @override
  void didChangeDependencies() {
    ChapterProvider provider = ChapterProvider.of(context);
    part = provider.part;

    super.didChangeDependencies();
    updateDestination();
  }

  @override
  void dispose() {
    super.dispose();
    //This might crash because it's not always added
    destination?.loadNotifier.removeListener(chapterLoaded);
  }

  void updateDestination() async {
    Chapter? destination = await getDestination();
    if (destination != null) {
      if (destination.extra != null) {
        where = destination.where;
        when = destination.when;
      } else {
        destination.loadNotifier.addListener(chapterLoaded);
      }
    }
  }

  void chapterLoaded() {
    where = destination?.where;
    when = destination?.when;
    if (mounted) {
      setState(() {});
    }
  }

  Future<Chapter?> getDestination() async {
    if (link == null) {
      return null;
    }
    Book book = Book.of(context);
    return book.findChapterBySearchTerm(link!);
  }

  String? get link => widget.holder.link;
  //Used to show destination
  bool get isChapter => widget.holder.isChapter;
  Color get color => widget.holder.color;

  String get linkText => link ?? 'null';

  TextTheme get textTheme => part.textTheme;

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
        child: _TooltipWrap(
            key: const Key('tooltip'),
            holder: widget.holder,
            where: where,
            when: when,
            child: card(context)));
  }

  Widget explanationText(BuildContext context) {
    return Text(
      'Link: $linkText',
      style: part.textTheme.labelLarge,
    );
  }

  Widget destText(BuildContext context) {
    return Text(
      'Going to: $where',
      style: textTheme.labelLarge,
      textAlign: TextAlign.right,
    );
  }

  Widget _buttonText(BuildContext context) {
    // dev.log("GotoButton: link=$linkText, isChapter=$isChapter");
    return Text(HolderUtils.stripOutText(widget.holder.spans).trim(),
        style: textTheme.displaySmall, textAlign: TextAlign.center);
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

  Widget card(BuildContext context) {
    return ElevatedButton(
        clipBehavior: Clip.hardEdge,
        onPressed: link == null ? null : () => onPressed(context),
        style: Theme.of(context).filledButtonTheme.style?.copyWith(
            overlayColor: ButtonOverlayColorProperty(
                color: color, selectedColor: planColor)),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: column(context))
        // const SizedBox.shrink()
        );
  }
}

class _TooltipWrap extends StatelessWidget {
  final GotoButtonHolder holder;
  final String? where;
  final String? when;
  final Widget child;
  const _TooltipWrap(
      {required super.key,
      required this.holder,
      required this.child,
      required this.where,
      required this.when});

  InlineSpan tooltip(BuildContext context) {
    if (holder.link == null) {
      return const TextSpan(text: '(No Destination)');
    }
    return WidgetSpan(
        child: Container(
            alignment: Alignment.topLeft,
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
            child: Column(
              children: [
                Text('Destination: ${where ?? '...'}'),
                const Divider(),

                //TODO: Get chapter
                if (when != null) Text("Time: ${when ?? '...'}"),

                const Divider(),

                Text('Link: ${holder.linkText}'),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        richMessage: tooltip(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primaryFixed),

        // message: 'Destination: ${dest ?? 'Unknown'}',
        waitDuration: const Duration(milliseconds: 1500),
        child: child);
  }
}
