import 'package:flutter/foundation.dart';

String serverURLSource() {
  return 'desktop/mobile';
}

String getServerURLPlatformSpecific() {
  ///Linux. Try localhost / setup url
  if (kDebugMode || kProfileMode) {
    return 'http://127.0.0.1:5000';
  } else {
    //TODO: Check whether https is working.
    return 'http://homeworld.help';
  }
}
