import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/utils.dart' as util;
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';

import '../../../../backend/error_handler.dart';
import '../../../parts/part.dart';
import 'image_constants.dart';
import 'image_container.dart';
import 'no_image_widget.dart';

class MyNetworkImageWidget extends StatelessWidget {
  ///Where to get the image
  final String? url;

  ///In case you know the short name of the url
  final String? displayUrl;
  final Color? colorHint;

  const MyNetworkImageWidget(
      {super.key,
      required this.url,
      String? displayUrl,
      required this.colorHint})
      : displayUrl = displayUrl ?? url ?? '-';

  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    ///Returns a TriWizard loader to show an image is coming in.
    ///If colorHint is available, it provides a nifty loading/fill animation
    /// ImageLoadingBuilder;
    if (loadingProgress == null) {
      //This means done
      return child;
    }
    if (colorHint == null) {
      return ImageContainer.factory(
          url: url,
          displayUrl: displayUrl,
          color: colorHint,
          child: TriWizardLoader(
              key: const Key('imgLoader'), message: displayUrl));
    } else {
      Color colorHint = this.colorHint!;
      //Set loader to color - fade in BG
      Part part = Part.of(context);
      double pct = loadingProgress.cumulativeBytesLoaded /
          (loadingProgress.expectedTotalBytes ?? standardImageByteSize);
      pct = util.clampDouble(0, pct, 1);
      Color bg =
          Color.lerp(part.canvasColor, colorHint, pct) ?? part.canvasColor;

      return ColoredBox(
          color: bg,
          child: TriWizardLoader(
              key: const Key('imgLoader'),
              message: displayUrl,
              loaderColor: colorHint));
    }
  }

  Widget frameBuilder(BuildContext context, Widget child, int? frame,
      bool wasSynchronouslyLoaded) {
    ///wasSynchronouslyLoaded = 'popping' in
    return ImageContainer.factory(
        url: url, displayUrl: displayUrl, color: colorHint, child: child);
  }

  Widget imageItself(BuildContext context) {
    if (url == null) {
      return const NoImageWidget(
          key: Key("NoImg"),
          url: null,
          displayUrl: 'null',
          reason: NoImageReason.leftBlank);
    } else {
      return Image.network(url!,
          key: const Key("ImageObj"),
          loadingBuilder: loadingBuilder,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder,
          width: standardImageWidth,
          height: standardImageHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return const NoImageWidget(
          key: Key("NoImg"),
          url: null,
          displayUrl: 'null',
          reason: NoImageReason.leftBlank);
    } else {
      return Image.network(url!,
          cacheHeight: standardImageHeight.toInt(),
          key: const Key("ImageObj"),
          loadingBuilder: loadingBuilder,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder,
          width: standardImageWidth,
          height: standardImageHeight);
    }
  }

  Widget errorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    ErrorList.logError(error.toString(), stackTrace);
    dev.log("Image Error: $error");
    late final NoImageReason reason;
    if (error.toString().contains('statusCode: 404')) {
      reason = NoImageReason.imageIOU;
    } else {
      reason = NoImageReason.networkError;
    }
//The error widget is not wrapped in the frameBuilder
    return NoImageWidget(
      key: const Key("NoImg"),
      reason: reason,
      displayUrl: displayUrl,
      url: url,
    );
  }
}

Color getOnArbitraryColor(Color colorHint, Part part) {
  double lum = colorHint.computeLuminance();
  if (lum > .666) {
    //White bg; dark loader
    return part.primary.s2;
  } else if (lum > .333) {
    //Mid ranges; canvasColor loader
    return part.canvasColor;
  } else {
    //Dark hint, white loader
    return part.primary.sf;
  }
}
