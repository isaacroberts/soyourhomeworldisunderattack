import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/image/image_widget.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/image/no_image_widget.dart';

import '../holders/holder_base.dart';

class ImageHolder extends CodeHolder {
  final String? url;
  final Color? colorHint;
  const ImageHolder({required this.url, this.colorHint});

  @override
  String toText() {
    return '(Image: $url)\n';
  }

  @override
  Widget element(BuildContext context) {
    if (url == null) {
      return NoImageWidget(
          key: const Key("NoImg"),
          reason: NoImageReason.leftBlank,
          displayUrl: '.',
          url: url);
    }
    if (!url!.contains('.')) {
      return NoImageWidget(
          key: const Key("NoImg"),
          reason: NoImageReason.suggestion,
          displayUrl: url,
          url: url);
    } else {
      String cleanedUrl = imageUrl(url!);

      return MyNetworkImageWidget(
          key: Key("Img($cleanedUrl)"),
          url: cleanedUrl,
          displayUrl: url,
          colorHint: colorHint);
    }
  }
}
