import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

import '../../../../backend/chapter.dart';
import '../icons.dart';
import '../parts/part.dart';
import '../theme/layout_constants.dart';

extension PartSidebar on Part {
  Color get sidebarButton => primary.s8;
  Color get sidebarBrite => primary.sc;
  Color get headerColor => primary.se;
}

class DrawerButton extends StatefulWidget {
  const DrawerButton({super.key});

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    Color color = Part.of(context).primary.se;
    return IconButton(
        onPressed: openDrawer,
        icon: Icon(
          Icons.menu,
          color: color,
        ));
  }

  void openDrawer() {
    Scaffold.maybeOf(context)?.openEndDrawer();
  }
}

class StdAppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool hilite;
  const StdAppBarButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.tooltip,
      this.hilite = false});

  @override
  Widget build(BuildContext context) {
    Part? part = ChapterProvider.maybeOf(context)?.part;
    part!;
    Color color = hilite ? part.primary.sb : part.primary.s7;
    Widget child = IconButton(
        padding: const EdgeInsets.all(6),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: 24,
        ));
    if (tooltip != null) {
      child = Tooltip(message: tooltip!, child: child);
    }
    return child;
  }
}

///Show button that copies text of chapter
class CopyTextButton extends StatelessWidget {
  const CopyTextButton({super.key});

  void onPressed(BuildContext context) {
    Chapter chapter = Chapter.of(context);
    chapter.data?.copyText();
  }

  @override
  Widget build(BuildContext context) {
    return StdAppBarButton(
      icon: Icons.copy_all,
      onPressed: () => onPressed(context),
      tooltip: 'Copy text',
    );
  }
}

///Opens
class BookmarkButton extends StatelessWidget {
  ///For any Part
  final Chapter? chapter;
  const BookmarkButton({required super.key, required this.chapter});

  void onPressed(BuildContext context) {
    if (chapter != null) {
      //Uses context.go to ensure URL is being loaded
      context.go(chapter!.searchUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StdAppBarButton(
        key: const Key('bookmark'),
        icon: Icons.bookmark,
        tooltip: 'Link: ${chapter?.varName}',
        onPressed: () => onPressed(context));
  }
}

class CurrentChip extends StatelessWidget {
  ///Any part
  final String? value;
  final String label;
  final Widget? icon;

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

                  // onDeleted: () {},
                  key: const Key("chip"),
                  avatar: icon,
                  label: Text(value!))));
    }
  }
}

/// Size & align headers to match scroller
class HeaderSizer extends StatelessWidget {
  final Widget child;

  const HeaderSizer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
        key: const Key('c'),
        child: SizedBox(
            key: const Key('s'),
            width: maxReaderWidth,
            child:
                //Pad
                Padding(
                    key: const Key('p'),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    //Start at left, with text
                    child: Align(
                        key: const Key('cl'),
                        alignment: Alignment.centerLeft,
                        child: child))));
  }
}

class WhatIcon extends StatefulWidget {
  final String? what;
  const WhatIcon({required super.key, required this.what});

  @override
  State<WhatIcon> createState() => _WhatIconState();
}

class _WhatIconState extends State<WhatIcon> {
  late final IconData? icon;

  @override
  void initState() {
    icon = getIcon();
    super.initState();
  }

  IconData? getIcon() {
    if (widget.what == null) {
      return null;
    }
    switch (widget.what) {
      case 'Call':
        return Icons.call;
      case 'Curse':
      case "Facebook":
        return RpgAwesome.bleeding_eye;
      case 'Essay':
        return RpgAwesome.quill_ink;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return const SizedBox.shrink();
    } else {
      Part part = Part.of(context);
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Tooltip(
              message: 'What: ${widget.what}',
              child: Icon(
                icon,
                color: part.primary.s3,
                size: 24,
              )));
    }
  }
}

class RecapIcon extends StatelessWidget {
  final String? recap;
  const RecapIcon({super.key, required this.recap});

  @override
  Widget build(BuildContext context) {
    Part part = Part.of(context);
    String? recap = this.recap;
    if (recap == null) {
      //Don't show me no information
      return const SizedBox.shrink();
    }
    //TODO: Put this in the python writer
    if (!recap.endsWith('.')) {
      recap = '$recap.';
    }
    const Radius corner = Radius.circular(24);
    const Radius topCorner = Radius.zero;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Tooltip(
            //TODO: Do a rich message so i can show the help icon again on the left
            message: recap,
            // richMessage: WidgetSpan(child: tooltipContent(context)),
            textStyle: part.bodyFont.copyWith(
                fontSize: 12 * fontScale,
                color: part.primary.s3,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.start,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            //Move to look more like speech bubble
            margin: const EdgeInsets.only(
                right: 18,
                top: 0,
                //Make sure it doesn't touch edges
                left: 36),
            decoration: BoxDecoration(
                color: part.primary.se,
                borderRadius: const BorderRadius.only(
                    topRight: topCorner,
                    topLeft: corner,
                    bottomRight: corner,
                    bottomLeft: corner),
                border: Border.all(color: part.primary.s4, width: 1.5)),
            enableFeedback: true,
            verticalOffset: 12,
            constraints: const BoxConstraints(
                minHeight: 24,
                maxWidth: double.infinity,
                minWidth: 36,
                maxHeight: double.infinity
                //This is more accurate but hurts performance, and is unlikely to come up
                // maxHeight:
                //     MediaQuery.sizeOf(context).height - expandedAppBarSize
                ),
            child: Icon(
              Symbols.help,
              color: part.primary.se,
              size: 24,
            )));
  }
}
