import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ScrollMode {
  infinitePackage,
  sliver,
  paged,
  ;

  String get displayName {
    switch (this) {
      case ScrollMode.infinitePackage:
        return 'Infinite Scroll (Stuttery)';
      case ScrollMode.sliver:
        return 'Sliver (experimental)';
      case ScrollMode.paged:
        return 'Paged';
      // case ScrollMode.old_scroll:
      //   return 'Old Scroll';
    }
  }

  static const ScrollMode defaultScroll = sliver;
}

class ViewSettings {
  static ViewSettings instance = ViewSettings.defaultsThenLoad();

  ScrollMode get useInfiniteScroll => _useInfiniteScroll.value;
  bool get useTestRig => _useTestRig.value;
  bool get showFonts => _showFonts.value;

  ValueNotifier<ScrollMode> get infiniteScrollNotifier => _useInfiniteScroll;
  ValueNotifier<bool> get testRigNotifier => _useTestRig;
  ValueNotifier<bool> get showFontsNotifier => _showFonts;

  set useInfiniteScroll(ScrollMode? set) {
    if (set != null && set != _useInfiniteScroll.value) {
      _useInfiniteScroll.value = set;
      setAllSharedPrefs();
    }
  }

  set useTestRig(bool? set) {
    if (set != null && set != _useTestRig.value) {
      _useTestRig.value = set;
      setAllSharedPrefs();
    }
  }

  set showFonts(bool? set) {
    if (set != null && set != _showFonts.value) {
      _showFonts.value = set;
      setAllSharedPrefs();
    }
  }

  final ValueNotifier<ScrollMode> _useInfiniteScroll;
  final ValueNotifier<bool> _useTestRig;
  final ValueNotifier<bool> _showFonts;

  // ViewSettings.defaults()
  //     : _useInfiniteScroll = true,
  //       _useTestRig = false,
  //       _showFonts = true;
  ViewSettings.defaultsThenLoad()
      : _useInfiniteScroll =
            ValueNotifier<ScrollMode>(ScrollMode.defaultScroll),
        _useTestRig = ValueNotifier<bool>(false),
        _showFonts = ValueNotifier<bool>(true) {
    getFromSharedPrefs();
  }

  ViewSettings.values(
      {ScrollMode? useInfiniteScroll, bool? useTestRig, bool? showFonts})
      : _useInfiniteScroll = ValueNotifier<ScrollMode>(
            useInfiniteScroll ?? ScrollMode.defaultScroll),
        _useTestRig = ValueNotifier<bool>(useTestRig ?? false),
        _showFonts = ValueNotifier<bool>(showFonts ?? true);

  void subscribeToListeners(VoidCallback listener,
      {bool? testRig, bool? infiniteScroll, bool? showFonts}) {
    if (testRig ?? false) {
      _useTestRig.addListener(listener);
    }
    if (infiniteScroll ?? false) {
      _useInfiniteScroll.addListener(listener);
    }
    if (showFonts ?? false) {
      _showFonts.addListener(listener);
    }
  }

  void unsubscribeFromListeners(VoidCallback listener,
      {bool? testRig, bool? infiniteScroll, bool? showFonts}) {
    if (testRig ?? false) {
      _useTestRig.removeListener(listener);
    }
    if (infiniteScroll ?? false) {
      _useInfiniteScroll.removeListener(listener);
    }
    if (showFonts ?? false) {
      _showFonts.removeListener(listener);
    }
  }

  @override
  String toString() {
    return 'i=_ r=$_useTestRig f=$_showFonts';
  }

  void getFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? inf = prefs.getInt('scroll');
    bool? rig = prefs.getBool('rig');
    bool? fonts = prefs.getBool('_showFonts');
    if (inf != null && inf != useInfiniteScroll.index) {
      _useInfiniteScroll.value = ScrollMode.values[inf];
    }
    if (rig != null && rig != useTestRig) {
      _useTestRig.value = rig;
    }
    if (fonts != null && fonts != showFonts) {
      _showFonts.value = fonts;
    }
  }

  // String toDense() {
  //   String d = '';
  //   d += _useInfiniteScroll ? 'i' : 'n';
  //   d += _useTestRig ? 't' : 'n';
  //   d += _showFonts ? 'f' : 'n';
  //   return d;
  // }

  void setAllSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('scroll', _useInfiniteScroll.value.index);
    prefs.setBool('rig', _useTestRig.value);
    prefs.setBool('_showFonts', _showFonts.value);
  }

  static bool staticUpdateShouldNotify(ViewSettings a, ViewSettings b) {
    return a.useTestRig != b.useTestRig ||
        a.useInfiniteScroll != b.useInfiniteScroll ||
        a.showFonts != b.showFonts;
  }
}
