import 'dart:developer' as dev;
import 'dart:ui' as util;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/backend/utils.dart';
import 'package:soyourhomeworld/frontend/image/_landscape_sliver.dart';
import 'package:soyourhomeworld/frontend/image/_portrait_sliver.dart';
import 'package:soyourhomeworld/frontend/image/no_image_widget.dart';

import '../../backend/chapter.dart';
import '../../backend/error_handler.dart';
import '../elements/holders/holder_base.dart';
import '../elements/widgets/loader.dart';
import '../parts/part.dart';
import 'image_constants.dart';

class ImageHolder extends CodeHolder {
  final String? _url;
  final String displayUrl;
  final double? aspectRatio;
  final String credit;
  final ColorHint? colorHint;
  ImageProvider? imageProvider;

  // In most use cases, this will already be checked
  String get url => _url!;
  String? get nullableUrl => _url;

  //Convenience functions for objects
  Color? get bgColor => colorHint?.bgColor;
  Color? get outlineColor => colorHint?.outlineColor;
  Color? get foreColor => colorHint?.foreColor;

  ImageHolder(
      {required String? url,
      this.aspectRatio,
      this.colorHint,
      required this.credit})
      : displayUrl = url ?? 'null',
        _url = (url == null) ? null : imageUrl(url);

  ImageHolder.fromList(
      {required String? url,
      this.aspectRatio,
      List<Color>? colorHints,
      required this.credit})
      : colorHint = colorHints == null ? null : ColorHint.fromList(colorHints),
        displayUrl = url ?? 'null',
        _url = (url == null) ? null : imageUrl(url);

  @override
  String toText() {
    return '(Image: $_url)\n';
  }

  @override
  //Use hashCode if 'null' image
  String get key => '${displayUrl}_$hashCode';

  bool get tryable => _url != null && url.contains('.');

  @override
  Widget element(BuildContext context) {
    //Shouldn't be callable anymore
    //TODO: PageReader is still doing this
    assert(false);
    return const SizedBox.shrink();
  }

  @override
  Widget sliver(BuildContext context) {
    if (_url == null) {
      return NoImageWidget(
          key: const Key("NoImg"),
          reason: NoImageReason.leftBlank,
          holder: this);
    }
    if (!url.contains('.')) {
      return NoImageWidget(
          key: const Key("NoImg"),
          reason: NoImageReason.suggestion,
          holder: this);
    } else {
      if (aspectRatio == null) {
        // return SliverToBoxAdapter(child: widget.child);
        return LandscapeSliver(key: Key('landscape_$key'), holder: this);
      } else if (aspectRatio! > standardImageAspectRatio) {
        return LandscapeSliver(key: Key('landscape_$key'), holder: this);
      } else if (aspectRatio! > 1) {
        //return squareFitLadder()
        return LandscapeSliver(key: Key('landscape_$key'), holder: this);
      } else {
        return PortraitSliver(key: Key('portrait_$key'), holder: this);
      }
    }
  }

  ImageProvider getImageProvider() {
    imageProvider ??= NetworkImage(url);
    return imageProvider!;
  }

  void cacheImage(BuildContext context) {
    imageProvider ??= NetworkImage(url);
    //TODO: Create a custom imageProvider that fetches smaller images based on devicePixelRatio
    imageProvider!.resolve(ImageConfiguration(
        devicePixelRatio: MediaQuery.devicePixelRatioOf(context),
        locale: godBless,
        textDirection: TextDirection.ltr,
        size: MediaQuery.sizeOf(context),
        platform: Theme.of(context).platform));
  }

  void dispose() {
    imageProvider?.evict();
    imageProvider = null;
  }

  ///Common loading widget for all Holder-ed Images

  ///Returns a TriWizard loader to show an image is coming in.
  ///If colorHint is available, it provides a nifty loading/fill animation
  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      //This means done
      return child;
    }
    if (colorHint == null) {
      return Center(
          key: const Key('c'),
          child: TriWizardLoader(
              key: const Key('imgLoader'), message: displayUrl));
    } else {
      //Set loader to color - fade in BG
      Part part = ChapterProvider.partOf(context);
      double pct = loadingProgress.cumulativeBytesLoaded /
          (loadingProgress.expectedTotalBytes ?? standardImageByteSize);
      pct = util.clampDouble(0, pct, 1);
      Color bg =
          Color.lerp(part.pageColor, colorHint?.bgColor, pct) ?? part.pageColor;

      return Center(
          key: const Key('c'),
          child: ColoredBox(
              key: const Key('colorHintBg'),
              color: bg,
              child: TriWizardLoader(
                  key: const Key('imgLoader'),
                  message: displayUrl,
                  //TODO: Send the second color hint,
                  // used for the loader
                  loaderColor: colorHint?.foreColor)));
    }
  }

  ///Common error widget for all Holder-ed Images

  Widget errorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    ErrorList.logError(error.toString(), stackTrace);
    dev.log("Image Error: $error");
    late final NoImageReason reason;
    if (error.toString().contains('statusCode: 404')) {
      reason = NoImageReason.suggestion;
    } else {
      reason = NoImageReason.networkError;
    }
//The error widget is not wrapped in the frameBuilder,
// but it is wrapped in a Sliver
    return UnwrappedNoImageWidget(
      key: const Key("NoImg(Err)"),
      reason: reason, displayUrl: displayUrl,
      // holder: this,
    );
  }

  ///Guess why image is missing, to display to user
  NoImageReason getNoImageReason() {
    if (_url == null) {
      return NoImageReason.leftBlank;
    }
    if (!url.contains('.') || url.contains(' ')) {
      //For meme-aligning purposes, "x.jpg" means user-provided
      return NoImageReason.imageIOU;
    }
    if (url.startsWith('!')) {
      return NoImageReason.suggestion;
    }

    return NoImageReason.unknown;
  }
}
