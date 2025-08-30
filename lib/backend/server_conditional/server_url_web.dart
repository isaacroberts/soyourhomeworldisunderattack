import 'package:web/web.dart' as web;

String serverURLSource() {
  return 'web';
}

String getServerURLPlatformSpecific() {
  ///Use current URL
  return web.window.location.href;
}
