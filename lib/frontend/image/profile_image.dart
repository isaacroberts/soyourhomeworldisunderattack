import 'package:flutter/material.dart';

import '../../backend/binary_utils/code_params.dart';
import '../../backend/error_handler.dart';
import '../components/sliver_center.dart';
import 'base_image_holder.dart';

const double profileRadius = 250;

class ProfileImageHolder extends ImageHolder {
  final String? who;
  ProfileImageHolder.fromValues(
      {required super.url,
      super.aspectRatio,
      super.colorHint,
      required super.credit,
      this.who});

  ///Super constructors
  ///Caller must check for params[has]
  ProfileImageHolder.fromParams(super.params)
      : who = params.readString('who'),
        super.fromParams();

  factory ProfileImageHolder(CodeParams params) {
    return ProfileImageHolder.fromParams(params);
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
    if (noImage) {
      return const Icon(
        Icons.person,
        size: 72,
      );
    } else {
      return Image(
        key: Key('profile$id'),
        image: getImageProvider(),
        frameBuilder: frameBuilder,
        loadingBuilder: super.loadingBuilder,
        errorBuilder: errorBuilder,
      );
    }
  }

  @override
  Widget sliver(BuildContext context) {
    return SliverCenter(sliver: SliverToBoxAdapter(child: element(context)));
  }

  ///Returns a TriWizard loader to show an image is coming in.
  @override
  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      //This means done
      return child;
    }
    //Return loader that looks like a connection
    return CircularProgressIndicator(color: colorHint?.foreColor);
  }

  Widget frameBuilder(BuildContext context, Widget child, int? frame,
      bool? wasSynchronouslyLoaded) {
    Color? bg = colorHint?.bgColor;

    return Container(
        key: const Key('profileFrame'),
        margin: const EdgeInsets.all(12),
        width: profileRadius,
        height: profileRadius,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: child);
  }

  ///Common error widget for all Holder-ed Images

  Widget errorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    ErrorList.logError(error.toString(), stackTrace);
    // dev.log("Image Error: $error");
//The error widget is not wrapped in the frameBuilder,
// but it is wrapped in a Sliver
    return Tooltip(
        message: 'Profile image failed: ($nullableUrl)',
        child: const Icon(
          key: Key('profileFailedIcon'),
          Icons.person_outline,
          size: profileRadius / 2,
        ));
  }
}
