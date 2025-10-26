import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/image/_landscape_sliver.dart';
import 'package:soyourhomeworld/frontend/image/_portrait_sliver.dart';
import 'package:soyourhomeworld/frontend/image/no_image_widget.dart';

import '../../backend/binary_utils/code_params.dart';
import '../elements/widgets/loader.dart';
import 'base_image_holder.dart';
import 'image_constants.dart';

class StdImageHolder extends ImageHolder {
  StdImageHolder.fromValues(
      {required super.url,
      super.aspectRatio,
      super.colorHint,
      required super.credit});

  ///Super constructors
  ///Caller must check for params[has]
  StdImageHolder.fromParams(super.params) : super.fromParams();
  StdImageHolder.notExpected({required super.url}) : super.notExpected();

  factory StdImageHolder(CodeParams params) {
    if (params.readBool('has') ?? true) {
      return StdImageHolder.fromParams(params);
    } else {
      //Some images aren't had on the server
      return StdImageHolder.notExpected(url: params.main);
    }
  }

  @override
  String toText() {
    return '(Image: $nullableUrl)\n';
  }

  @override
  //Use hashCode if 'null' image
  String get id => '${displayUrl}_$hashCode';

  @override
  Widget element(BuildContext context) {
    //Shouldn't be callable anymore
    assert(false);
    return const SizedBox.shrink();
  }

  //TODO: Move this to subclass
  @override
  Widget sliver(BuildContext context) {
    if (nullableUrl == null || !expected || !url.contains('.')) {
      return NoImageWidget(
          key: Key("NoImg$url"), reason: getNoImageReason(), holder: this);
    }
    if (aspectRatio == null) {
      // return SliverToBoxAdapter(child: widget.child);
      return LandscapeSliver(key: Key('landscape_$id'), holder: this);
    } else if (aspectRatio! > standardImageAspectRatio) {
      return LandscapeSliver(key: Key('landscape_$id'), holder: this);
    } else if (aspectRatio! > 1) {
      //return squareFitLadder()
      return LandscapeSliver(key: Key('landscape_$id'), holder: this);
    } else {
      return PortraitSliver(key: Key('portrait_$id'), holder: this);
    }
  }

  @override
  Widget debugSliver(BuildContext context) {
//No fancy image stuff
    //TODO: Buttons
    //TODO: debugPane
    return PortraitSliver(key: Key('portrait_$id'), holder: this);
  }

  ///Common loading widget for all Holder-ed Images

  ///Returns a TriWizard loader to show an image is coming in.
  ///If colorHint is available, it provides a nifty loading/fill animation
  @override
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
      //Code to fade in BG:
      // Part part = ChapterProvider.partOf(context);
      // double pct = loadingProgress.cumulativeBytesLoaded /
      //     (loadingProgress.expectedTotalBytes ?? standardImageByteSize);
      // pct = util.clampDouble(0, pct, 1);
      // Color bg =
      //     Color.lerp(part.pageColor, colorHint?.bgColor, pct) ?? part.pageColor;
      double width = MediaQuery.sizeOf(context).width;
      //
      Widget child = TriWizardLoader(
          key: const Key('imgLoader'),
          message: displayUrl,
          loaderColor: colorHint?.foreColor);
      child = Center(key: const Key('c'), child: child);
      //Bg
      Color? bg = colorHint?.bgColor;
      if (bg == null) {
        child =
            ColoredBox(key: const Key('colorHintBg'), color: bg!, child: child);
      }
//Spacing
      return SizedBox(width: width, key: const Key('s'), child: child);
    }
  }

  ///Common error widget for all Holder-ed Images

  Widget errorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    //Don't log - I know some of the images are missing
    // ErrorList.logError(error.toString(), stackTrace);
    // dev.log("Image Error: $error");
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
      reason: reason,
      displayUrl: displayUrl,
    );
  }
}
