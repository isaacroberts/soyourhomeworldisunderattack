import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';

import '../holders/holder_base.dart';

class ImageHolder extends Holder {
  final String? url;
  const ImageHolder({required this.url});

  Widget placeholder() {
    return const SizedBox(height: 400, width: 600, child: Placeholder());
  }

  @override
  Widget element(BuildContext context) {
    if (url == null) {
      return placeholder();
    }
    return Image.network(imageUrl(url!),
        width: 600, height: 400, fit: BoxFit.contain);
  }

  @override
  Widget fallback(BuildContext context) {
    return placeholder();
  }
}
