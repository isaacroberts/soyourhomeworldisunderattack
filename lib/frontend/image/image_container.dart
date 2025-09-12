import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../parts/noir_colors.dart';
import '_common_container.dart';
import '_tall_fit.dart';
import 'image_constants.dart';
import 'image_holder.dart';

class ImageContainer extends StatefulWidget {
  final Widget child;
  final ImageHolder holder;

  const ImageContainer.fromValues({
    required super.key,
    required this.holder,
    //Child last
    required this.child,
  });

  static ImageContainer factory(
      {required ImageHolder holder, bool? allowExpand, required Widget child}) {
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
      key: Key("ImgCtr[${holder.key}]"),
      holder: holder,
      child: child,
    );
  }

  //       assert(child is! ImageContainer, 'No stacking ImageContainers!'), super(key: Key(displayUrl));

  @override
  State<StatefulWidget> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  Widget get child => widget.child;
  String? get url => widget.holder.url;
  String get displayUrl => widget.holder.displayUrl;

  Widget unknownFitLadder(BuildContext context, bool expanded) {
    Widget child = this.child;
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

  Widget landscapeBuilder(BuildContext context, bool expanded) {
    double aspectRatio = holder.aspectRatio!;
    Widget child = this.child;
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

  Widget Function(BuildContext, bool) builderLadder() {
    if (holder.aspectRatio == null) {
      return unknownFitLadder;
    } else if (holder.aspectRatio! > standardImageAspectRatio) {
      return landscapeBuilder;
    } else if (holder.aspectRatio! > 1) {
      //return squareFitLadder()
      return landscapeBuilder;
    } else {
      return portraitBuilder;
    }
  }

  Widget portraitBuilder(BuildContext context, bool expanded) {
    return TallFitImageWidget(
        holder: holder,
        expanded: expanded,
        key: Key('landscape${holder.key}'),
        child: child);
  }

  ImageHolder get holder => widget.holder;

  Color? get bgColor => holder.colorHint?.bgColor;
  Color? get outlineColor => holder.colorHint?.outlineColor;
  Color? get loaderColor => holder.colorHint?.foreColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    bool showContainer = width > 800;

    var builder = builderLadder();

    Widget child = CommonImageContainer(
        key: Key('cmnImgCtr${holder.key}'),
        holder: holder,
        childBuilder: builder);

    if (showContainer) {
      child = Center(key: const Key('icenter'), child: child);
      child = wideContainerWrap(context, child);
      child = Center(key: const Key("ocenter"), child: child);
    }

    // return Padding(
    //     key: const Key('wrap_pad'),
    //     padding: const EdgeInsets.all(5),
    //     child: child);
    return child;
  }

  Widget wideContainerWrap(BuildContext context, Widget child) {
    ///This is not a builder function, this is the container wrap
    ColorHint? colorHint = holder.colorHint;
    //How sick will it be when this becomes an animatedContainer
    return Container(
        key: const Key('smWrapper'),
        decoration: BoxDecoration(
            color: colorHint?.bgColor ?? NoirPrimary.shade4,
            border: Border.all(
                color: outlineColor ?? const Color(0xff000000), width: 2),
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.only(top: 24, left: 6, right: 6, bottom: 48),
        child: child);
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
