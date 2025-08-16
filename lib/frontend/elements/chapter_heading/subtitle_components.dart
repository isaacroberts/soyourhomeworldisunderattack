import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../backend/chapter.dart';
import '../../../backend/error_handler.dart';
import '../../../backend/server.dart';
import '../../theme/colors.dart';

class BookmarkButton extends StatelessWidget {
  final Chapter? chapter;
  const BookmarkButton({required super.key, required this.chapter});
  Color get color => Primary.shadee.withAlpha(128);
  String get url => '$displayURL/search/${chapter?.varName}';

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: url,
        child: IconButton(
            padding: const EdgeInsets.all(6),
            onPressed: chapter != null
                ? () {
                    context.go(chapter!.searchUrl);
                    // Clipboard.setData(ClipboardData(text: url));
                  }
                : null,
            icon: Icon(
              Icons.bookmark,
              color: color,
              size: 24,
            )));
  }
}

class CurrentChip extends StatelessWidget {
  final String? value;
  final String label;
  final IconData? icon;

  const CurrentChip(
      {required super.key,
      required this.value,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox.shrink();
    } else {
      return Padding(
          key: const Key("lpad"),
          padding: const EdgeInsets.only(right: 12),
          child: Tooltip(
              key: const Key("tooltip"),
              message: label,
              //Because there's no onClick
              triggerMode: TooltipTriggerMode.tap,
              child: Chip(
                  key: const Key("chip"),
                  avatar: icon != null ? Icon(icon) : null,
                  label: Text(value!))));
    }
  }
}

class FutureChip extends StatelessWidget {
  final Future<String?>? value;
  final String label;
  final IconData? icon;
  const FutureChip(
      {required super.key,
      required this.value,
      required this.label,
      required this.icon});

  Widget buildChip(BuildContext context, String value) {
    return CurrentChip(
        key: const Key('currentChpi'), value: value, label: label, icon: icon);
  }

  Widget buildNoData(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget buildError(BuildContext context, String error) {
    return Padding(
        key: const Key("lpad"),
        padding: const EdgeInsets.only(right: 12),
        child: Tooltip(
            key: const Key("tooltip"),
            message: error,
            //Because there's no onClick
            triggerMode: TooltipTriggerMode.tap,
            child: Chip(
                key: const Key("chip"),
                avatar: icon != null ? const Icon(Icons.error_outline) : null,
                label: const Text('   '))));
  }

  Widget buildWaiting(BuildContext context) {
    return Padding(
        key: const Key("lpad"),
        padding: const EdgeInsets.only(right: 12),
        child: Chip(
            key: const Key("chip"),
            avatar: icon != null ? const Icon(Icons.hourglass_empty) : null,
            label: const Text(' ')));
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot<String?> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        return buildChip(context, snapshot.data!);
      } else {
        return buildNoData(context);
      }
    } else if (snapshot.hasError) {
      ErrorList.logError(snapshot.error!, snapshot.stackTrace);
      return buildError(context, snapshot.error!.toString());
    } else {
      return buildWaiting(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return buildNoData(context);
    }
    return FutureBuilder<String?>(
        key: const Key("futureBuilder"),
        future: value!,
        builder: futureBuilder);
  }
}
