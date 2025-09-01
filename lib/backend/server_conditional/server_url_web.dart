import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

String serverURLSource() {
  return 'web';
}

String getServerURLPlatformSpecific() {
  //This is annoying because it depends on whether we're using ngrok
  if (kDebugMode) {
    return 'http://127.0.0.1:5000';
  } else {
    return 'https://homeworld.help';
  }

  ///Use current URL
  ///
  return web.window.location.href;
}
