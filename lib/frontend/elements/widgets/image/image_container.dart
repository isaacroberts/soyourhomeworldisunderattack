import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//TODO: Defer load
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';

import '../../../parts/part.dart';
import 'image_constants.dart';

class ImageContainer extends StatefulWidget {
  final Widget child;
  final Color? color;
  final String? url;
  final String displayUrl;
  final bool allowExpand;

  const ImageContainer.fromValues({
    required super.key,
    required this.url,
    required this.color,
    required this.displayUrl,
    required this.allowExpand,
    //Child last
    required this.child,
  });

  static ImageContainer factory(
      {required Widget child,
      required String? url,
      String? displayUrl,
      required Color? color,
      bool? allowExpand}) {
    displayUrl ??= url ?? 'null';

    assert(child is! ImageContainer, 'No stacking ImageContainers!');

    if (kDebugMode) {
      for (DiagnosticsNode subchild in child.debugDescribeChildren()) {
        if (subchild.name == 'ImageContainer') {
          assert(false, 'No stacking ImageContainers!');
        }
      }
    }
    allowExpand ??= true;
    return ImageContainer.fromValues(
      key: Key("ImgCtr[$displayUrl]"),
      url: url,
      displayUrl: displayUrl,
      color: color,
      allowExpand: allowExpand,
      child: child,
    );
  }

  //       assert(child is! ImageContainer, 'No stacking ImageContainers!'), super(key: Key(displayUrl));

  @override
  State<StatefulWidget> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  Widget get child => widget.child;
  String? get url => widget.url;
  String get displayUrl => widget.displayUrl;

  bool _expanded = false;
  bool _hovered = false;

  bool get hovered => _hovered;
  bool get expanded => _expanded;

  set hovered(bool s) {
    if (mounted) {
      if (s != _hovered) {
        setState(() {
          _hovered = s;
        });
      }
    }
  }

  set expanded(bool s) {
    if (mounted && widget.allowExpand) {
      if (s != _expanded) {
        setState(() {
          _expanded = s;
        });
      }
    }
  }

  void toggleExpanded() {
    if (mounted && widget.allowExpand) {
      setState(() {
        _expanded = !_expanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Part? part = Part.maybeOf(context);
    part ??= const PartNoir();

    Widget child = this.child;
    if (expanded) {
      child = SizedBox(
          width: standardImageWidth,
          child: FittedBox(fit: BoxFit.fitWidth, child: child));
    } else {
      // child = ClipRRect(
      //     key: const Key("clip"),
      //     borderRadius: BorderRadius.circular(12),
      //     child: SizedBox(
      //         key: const Key("stdSize"),
      //         width: standardImageWidth,
      //         height: standardImageHeight + 24 + 12,
      //         child:child));
      child = FittedBox(fit: BoxFit.fitHeight, child: child);
    }

    // child = ClipRRect(
    //     key: const Key("clip"),
    //     borderRadius: BorderRadius.circular(12),
    //     child:child);
    if (expanded) {
      child = SizedBox(
          key: const Key("stdSize"),
          width: standardImageWidth,
          // height: standardImageHeight,
          child: child);
    } else {
      child = SizedBox(
          key: const Key("stdSize"),
          width: standardImageWidth,
          height: standardImageHeight,
          child: child);
    }
    // dev.log("Widget color: ${widget.color}");
    child = Material(
        color: widget.color,
        type: widget.color == null
            ? MaterialType.transparency
            : MaterialType.card,
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        borderOnForeground: expanded,
        clipBehavior: Clip.antiAlias,
        child: child);

    // if (expanded) {
    //   child = Container(
    //       decoration: BoxDecoration(
    //           border: Border.all(
    //               color: Theme.of(context).colorScheme.outline, width: 2),
    //           borderRadius: BorderRadius.circular(12)),
    //       child: child);
    // }

    child = InkWell(
        key: const Key("Inkwell"),
        onHover: (b) => hovered = b,
        onTap: toggleExpanded,
        child: child);

    // if (hovered) {
    //   child = Stack(
    //     alignment: Alignment.bottomCenter,
    //     fit: StackFit.passthrough,
    //     children: [
    //       child,
    //       socialMediaRow(context),
    //     ],
    //   );
    // }
    if (hovered) {
      child = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            Text(
              hovered ? displayUrl : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 12,
            ),
          ]);
    } else {
      double bottomPad =
          Theme.of(context).textTheme.labelMedium?.fontSize ?? 12;
      bottomPad *= Theme.of(context).textTheme.labelMedium?.height ?? 1;
      child = Padding(
          padding: EdgeInsets.only(bottom: bottomPad + 12), child: child);
    }

    return Padding(padding: const EdgeInsets.all(5), child: child);
  }
/*
  Widget socialMediaRow(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
        decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withAlpha(100),
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: click, child: Text(displayUrl)),
            IconButton(onPressed: click, icon: Icon(Icons.comment)),
            IconButton(onPressed: click, icon: Icon(Icons.add))
          ],
        ));
  }

  void click() {}

 */
}
