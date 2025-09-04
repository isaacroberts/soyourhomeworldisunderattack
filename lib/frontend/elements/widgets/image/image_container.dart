import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//TODO: Defer load
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';
import 'package:soyourhomeworld/frontend/theme/base_colors.dart';

import '../../../parts/noir_colors.dart';
import '../../../parts/part.dart';
import 'image_constants.dart';

class ImageContainer extends StatefulWidget {
  final Widget child;
  final ColorHint? colorHints;
  final String? url;
  final String displayUrl;

  ///width / height
  /// Used to keep the image from jumping
  final double? aspectRatio;
  final bool allowExpand;

  const ImageContainer.fromValues({
    required super.key,
    required this.url,
    required this.colorHints,
    required this.displayUrl,
    required this.allowExpand,
    required this.aspectRatio,
    //Child last
    required this.child,
  });

  static ImageContainer factory(
      {required Widget child,
      required String? url,
      String? displayUrl,
      required double? aspectRatio,
      required ColorHint? color,
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
      aspectRatio: aspectRatio,
      allowExpand: allowExpand,
      colorHints: color,
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

  bool get allowExpand => (widget.aspectRatio ?? .9) < 1;

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
    if (mounted && allowExpand) {
      if (s != _expanded) {
        setState(() {
          _expanded = s;
        });
      }
    }
  }

  void toggleExpanded() {
    if (mounted && allowExpand) {
      setState(() {
        _expanded = !_expanded;
      });
    }
  }

  Widget unknownFitLadder(BuildContext context, Widget child) {
    if (expanded) {
      child = SizedBox(
          width: standardImageWidth,
          child: FittedBox(fit: BoxFit.fitWidth, child: child));
    } else {
      // child = SizedBox(
      //     width: standardImageHeight,
      //     child: FittedBox(fit: BoxFit.fitWidth, child: child));
      child = FittedBox(fit: BoxFit.fitHeight, child: child);
    }
    return child;
  }

  Widget portraitFitLadder(BuildContext context, Widget child) {
    double aspectRatio = widget.aspectRatio!;

    child = FittedBox(key: const Key('fit'), fit: BoxFit.cover, child: child);

    if (expanded) {
      //Double height of image
      double height = standardImageWidth / aspectRatio * 2;
      child = SizedBox(
          key: const Key('imgSize'),
          //Double width
          width: standardImageWidth * 2,
          height: height,
          child: child);
      //Allow user to scroll
      child = SingleChildScrollView(
        key: const Key('imgScroll'),
        scrollDirection: Axis.horizontal,
        child: child,
      );
      child = Center(key: const Key('center'), child: child);
    } else {
      child = SizedBox(
          key: const Key('imgSize'),
          width: standardImageHeight * aspectRatio,
          height: standardImageHeight,
          child: child);
    }
    return child;
  }

  Widget landscapeFitLadder(BuildContext context, Widget child) {
    double aspectRatio = widget.aspectRatio!;

    child = FittedBox(key: const Key('fit'), fit: BoxFit.cover, child: child);

    // child = AnimatedFractionallySizedBox(
    //     key: const Key('lsAnimFracSize'),
    //     duration: Duration(milliseconds: 150),
    //     widthFactor: 1,
    //     child: child);
    Size size = MediaQuery.sizeOf(context);
    // size = Size(size.width - 30, size.height - 30);
    double maxHeight = standardImageHeight;
    double width = size.width;
    double height = width / aspectRatio;

    //Increase max height when expanded
    if (expanded) {
      //A little bit of scrolling is fine, to allow you to see it.
      //But, no frigging pages
      // maxHeight *= 1.5;
      maxHeight = size.height - appBarSize;
    } else {
      //Leave room for appBar.
      //Expanded, so you're not having
      //   to carefully adjust your scroll.
      //   (Up. Oops, the appBarExpanded and I can't see the whole image. Down. Oops, too far. Up, twice. Down.)
      // maxHeight -= expandedAppBarSize;
    }
    bool clamped = false;
    if (height > maxHeight) {
      height = maxHeight;
      width = maxHeight * aspectRatio;
      clamped = true;
    }
    child = AnimatedContainer(
      key: const Key('lsAnimCtr'),
      duration: const Duration(milliseconds: 500),
      width: width,
      height: height,
      child: child,
    );

    // child = SizedBox(
    //     key: const Key('lsChangingSize'),
    //     width: width,
    //     height: height,
    //     child: child);
    // child = AnimatedSize(
    //   key: const Key('lsAnimCtr'),
    //   duration: const Duration(milliseconds: 500),
    //
    //   alignment: Alignment.center,
    //   // width: width,
    //   // height: height,
    //   child: child,
    // );

    // if (clamped) {
    // child = Center(key: const Key('centr'), child: child);
    // child = Padding(
    //     padding: EdgeInsets.all(12), key: Key('innerPad'), child: child);
    // }
    return child;
  }

  Widget wideFit(BuildContext context, Widget child) {
    ColorHint? colorHint = widget.colorHints;
    if (!expanded || true) {
      //How sick will it be when this becomes an animatedContainer
      child = Container(
          key: const Key('smWrapper'),
          decoration: BoxDecoration(
              color: colorHint?.bgColor ?? NoirPrimary.shade4,
              border: Border.all(
                  color: outlineColor ?? const Color(0x22fffff), width: 2),
              borderRadius: BorderRadius.circular(12)),
          padding:
              const EdgeInsets.only(top: 24, left: 6, right: 6, bottom: 48),
          child: child);
    } else {}
    return child;
  }

  Widget fitLadder(BuildContext context, Widget child) {
    if (widget.aspectRatio == null) {
      return unknownFitLadder(context, child);
    } else if (widget.aspectRatio! > 1) {
      return portraitFitLadder(context, child);
    } else if (widget.aspectRatio! < 1) {
      return landscapeFitLadder(context, child);
    } else {
      //If ladder hit floating point error
      //Return default
      return unknownFitLadder(context, child);
    }
  }

  Color? get bgColor => widget.colorHints?.bgColor;
  Color? get outlineColor => widget.colorHints?.outlineColor;
  Color? get loaderColor => widget.colorHints?.loaderColor;

  @override
  Widget build(BuildContext context) {
    Part? part = Part.maybeOf(context);
    part ??= const PartNoir();

    double width = MediaQuery.sizeOf(context).width;

    bool showContainer = width > 800;
    Widget child = widget.child;

    if (!showContainer) {
      child = fitLadder(context, widget.child);
    } else {}

    child = Material(
        key: const Key('img_mat'),
        color: bgColor,
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: (showContainer ? loaderColor : outlineColor) ??
                  const Color(0xff000000),
              width: 2,
              strokeAlign: BorderSide.strokeAlignCenter),
        ),
        elevation: 5,
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
        child: child);

    if (showContainer) {
      child = Center(key: const Key('icenter'), child: child);
      child = wideFit(context, child);
      child = Center(key: const Key("ocenter"), child: child);
    }

    // child = Padding(
    //     padding: const EdgeInsets.all(15),
    //     key: const Key('outl2'),
    //     child: child);
    if (kDebugMode) {
      //For debugging the damn if ladder
      child = Tooltip(
          key: const Key('dev_ttp'),
          message: 'AspectRatio: ${widget.aspectRatio}; Expanded=$expanded',
          child: child);
    }
    ColorHint? colorHint = widget.colorHints;

    child = InkWell(
        key: const Key("Inkwell"),
        onHover: (b) => hovered = b,
        onTap: toggleExpanded,
        child: child);

    if (hovered) {
      child = Column(
          key: const Key('credit_col'),
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            //TODO: Replace with image credit
            Text(
              key: const Key('credit'),
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
          key: const Key('credit_space_replacer'),
          padding: EdgeInsets.only(bottom: bottomPad + 12),
          child: child);
    }

    // return Padding(
    //     key: const Key('wrap_pad'),
    //     padding: const EdgeInsets.all(5),
    //     child: child);
    return child;
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
