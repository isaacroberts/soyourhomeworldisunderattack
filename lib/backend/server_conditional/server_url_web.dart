import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

String serverURLSource() {
  return 'web';
}

String getServerURLPlatformSpecific() {
  if (kDebugMode) {
    return 'http://127.0.0.1:5000';
  }

  ///Use current URL
  return web.window.location.href;
}
