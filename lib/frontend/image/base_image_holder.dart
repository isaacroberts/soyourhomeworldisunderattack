import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/backend/utils.dart';
import 'package:soyourhomeworld/frontend/image/no_image_widget.dart';

import '../../backend/binary_utils/code_params.dart';
import '../elements/holders/holder_base.dart';
import '../elements/widgets/loader.dart';
import 'image_constants.dart';

class ImageHolder extends Holder {
  final String? _url;
  final String displayUrl;
  final double? aspectRatio;
  final String credit;
  final bool expected;
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
        _url = (url == null) ? null : imageUrl(url),
        expected = true;

  ImageHolder.fromParams(CodeParams params)
      : _url = params.main,
        displayUrl = params.main ?? 'null',
        aspectRatio = params.readDouble('aspectRatio'),
        colorHint = ColorHint.fromList(params.colorList('colorHint')),
        credit = params['credit'] ?? '(Credit lost)',
        expected = params['has'] ?? true;

  ImageHolder.notExpected({required String? url})
      : displayUrl = url ?? 'null',
        _url = (url == null) ? null : imageUrl(url),
        expected = false,
        aspectRatio = 1,
        colorHint = null,
        credit = '';

  @override
  String toText() {
    return '(Image: $_url)\n';
  }

  @override
  //Use hashCode if 'null' image
  String get id => '${displayUrl}_$hashCode';

  bool get tryable => _url != null && url.contains('.');

  bool get noImage => _url == null || !expected || !url.contains('.');

  @override
  Widget element(BuildContext context) {
    //This is default because you should be overriding it
    return Image(image: getImageProvider());
  }

  @override
  Widget sliver(BuildContext context) {
    //This is default because you should be overriding it
    return SliverToBoxAdapter(child: element(context));
  }

  @override
  Widget debugSliver(BuildContext context) {
    // TODO: implement debugSliver
    //This isn't done because it's directly on the thing
    throw UnimplementedError();
  }

  ImageProvider getImageProvider() {
    imageProvider ??= NetworkImage(imageUrl(url));
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
      double width = MediaQuery.sizeOf(context).width;
      return SizedBox(
          width: width,
          key: const Key('s'),
          child: Center(
              key: const Key('c'),
              child: TriWizardLoader(
                  key: const Key('imgLoader'), message: displayUrl)));
    } else {
      return TriWizardLoader(
          key: const Key('imgLoader'),
          message: displayUrl,
          //TODO: Send the second color hint,
          // used for the loader
          loaderColor: colorHint?.foreColor);
    }
  }

  ///Guess why image is missing, to display to user
  NoImageReason getNoImageReason() {
    if (_url == null) {
      return NoImageReason.leftBlank;
    }
    if (expected) {
      //This means file was on the server
      return NoImageReason.networkError;
    }
    if (url.contains('.jpg')) {
      //For meme purposes, "x.jpg" means user-provided
      return NoImageReason.suggestion;
    }
    //If no extension
    if (!url.contains('.') || url.contains(' ')) {
      //Therefore, "img name" means author-will-provide
      return NoImageReason.imageIOU;
    }

    //Else; unknown
    return NoImageReason.unknown;
  }
}
