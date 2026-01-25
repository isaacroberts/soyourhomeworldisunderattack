import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/theme/timings.dart';

import '../../../backend/binary_utils/code_params.dart';
import '../../../backend/chapter.dart';
import '../../parts/part.dart';
import '../../theme/base_text_theme.dart';
import '../holders/holder_base.dart';

/// Fake notifications in the book
/// [ Palantir: I see you ]

class NotificationTextHolder extends CodeHolder {
  late final String from;
  late final String text;

  late final String? link;

  NotificationTextHolder.fromSpans(
      {required CodeParams? data, required List<Holder> spans}) {
    link = data?['Link'];
    String result = spans.map((s) => s.toText()).join('');
    List<String> r = result.split(':');
    if (r.length == 1) {
      from = '';
      text = r.first.trim();
    } else {
      from = r.first.trim();
      text = r.sublist(1).join().trim(); //.replaceAll('e', '\n');
    }
  }
  NotificationTextHolder.fromText(
      {required CodeParams? data, required String text}) {
    link = data?['Link'];
    List<String> r = text.split(':');
    if (r.length == 1) {
      from = '';
      text = r.first.trim();
    } else {
      from = r.first.trim();
      text = r.sublist(1).join().trim(); //.replaceAll('e', '\n');
    }
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        sliver: SliverToBoxAdapter(
            child: _DragNotif(key: const Key('notifDrag'), holder: this)));
  }

  @override
  Widget element(BuildContext context) {
    //Draggable without sliver
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: _DragNotif(key: const Key('notifDrag'), holder: this));
  }

  @override
  String toText() {
    if (from.isEmpty) {
      return text;
    } else {
      return '$from: $text';
    }
  }
}

class _DragNotif extends StatefulWidget {
  final NotificationTextHolder holder;
  const _DragNotif({super.key, required this.holder});

  @override
  State<_DragNotif> createState() => _DragNotifState();
}

class _DragNotifState extends State<_DragNotif> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: const Key('notifDrag'),
        onDismissed: onDismiss,
        confirmDismiss: confirmDismiss,
        background: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ChapterProvider.of(context).part.primary.s3,
        )),
        child: NotifTextWidget(
            key: const Key('notifWidget'), holder: widget.holder));
  }

  void onDismiss(DismissDirection? direction) {
    //This function is unused because confirmDismiss will always return null
  }

  Future<bool> confirmDismiss(DismissDirection? d) async {
    if (widget.holder.link != null) {
      openLink(widget.holder.link, context);
    }
    await Future.delayed(const Duration(seconds: 1));
//Otherwise the thingy disappears
    return false;
  }
}

///The base object that can be dragged
class NotifTextWidget extends StatelessWidget {
  final NotificationTextHolder holder;
  const NotifTextWidget({required super.key, required this.holder});

  // Helper function
  Widget renderSpans(BuildContext context) {
    // dev.log("SpanHoldingCode showFonts=$showFonts");

    Part part = ChapterProvider.of(context).part;
    TextStyle style = appFont(
        fontSize: 12 * fontScale,
        color: part.primary.s2,
        fontWeight: FontWeight.w400);
    return Row(
        key: const Key('notif_row'),
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Icon Container
          const _NotifIcon(
            key: Key('notifIcon'),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(holder.from,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style.copyWith(fontWeight: FontWeight.w900)),
              Text(
                holder.text,
                maxLines: 4,
                // softWrap: false,
                // textWidthBasis: TextWidthBasis.longestLine,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: style,
              ),
            ],
          )),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Part part = ChapterProvider.of(context).part;

    //Notif container
    return Container(
        key: const Key('notifContainer'),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: part.primary.sc,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: renderSpans(context));
  }
}

class _NotifIcon extends StatelessWidget {
  const _NotifIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Part part = ChapterProvider.of(context).part;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: part.primary.sc),
            borderRadius: BorderRadius.circular(12),
            color: part.primary.s6),
        padding: const EdgeInsets.all(6),
        child: Icon(
          Icons.notifications_none,
          color: part.primary.s4,
          size: 24,
        ));
  }
}
