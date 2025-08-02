import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewSettings {
  static ViewSettings instance = ViewSettings.defaultsThenLoad();

  bool get useInfiniteScroll => _useInfiniteScroll.value;
  bool get useTestRig => _useTestRig.value;
  bool get showFonts => _showFonts.value;

  ValueNotifier<bool> get infiniteScrollNotifier => _useInfiniteScroll;
  ValueNotifier<bool> get testRigNotifier => _useTestRig;
  ValueNotifier<bool> get showFontsNotifier => _showFonts;

  set useInfiniteScroll(bool? set) {
    if (set != null && set != _useInfiniteScroll) {
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

  final ValueNotifier<bool> _useInfiniteScroll;
  final ValueNotifier<bool> _useTestRig;
  final ValueNotifier<bool> _showFonts;

  // ViewSettings.defaults()
  //     : _useInfiniteScroll = true,
  //       _useTestRig = false,
  //       _showFonts = true;
  ViewSettings.defaultsThenLoad()
      : _useInfiniteScroll = ValueNotifier<bool>(true),
        _useTestRig = ValueNotifier<bool>(false),
        _showFonts = ValueNotifier<bool>(true) {
    getFromSharedPrefs();
  }

  ViewSettings.values(
      {bool? useInfiniteScroll, bool? useTestRig, bool? showFonts})
      : _useInfiniteScroll = ValueNotifier<bool>(useInfiniteScroll ?? true),
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
    bool? inf = prefs.getBool('inf');
    bool? rig = prefs.getBool('rig');
    bool? fonts = prefs.getBool('_showFonts');
    if (inf != null && inf != useInfiniteScroll) {
      _useInfiniteScroll.value = inf;
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
    prefs.setBool('inf', _useInfiniteScroll.value);
    prefs.setBool('rig', _useTestRig.value);
    prefs.setBool('_showFonts', _showFonts.value);
  }

  static bool staticUpdateShouldNotify(ViewSettings a, ViewSettings b) {
    return a.useTestRig != b.useTestRig ||
        a.useInfiniteScroll != b.useInfiniteScroll ||
        a.showFonts != b.showFonts;
  }
}
