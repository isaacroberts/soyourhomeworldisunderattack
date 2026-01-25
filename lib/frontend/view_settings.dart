import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ScrollMode {
  sliver,
  infinitePackage,

  paged,
  ;

  String get displayName {
    switch (this) {
      case ScrollMode.sliver:
        return 'Sliver';
      case ScrollMode.paged:
        return 'Page';
      case ScrollMode.infinitePackage:
        return 'Legacy infinite scroll';
    }
  }

  static const ScrollMode defaultScroll = sliver;
}

class ViewSettings {
  static ViewSettings instance = ViewSettings.defaultsThenLoad();

  ScrollMode get scrollMode => scrollModeNotifier.value;
  bool get useTestRig => testRigNotifier.value;
  bool get showFonts => showFontsNotifier.value;
  bool get showBottomNav => showBottomNavNotifier.value;

  final ValueNotifier<ScrollMode> scrollModeNotifier;
  final ValueNotifier<bool> testRigNotifier;
  final ValueNotifier<bool> showFontsNotifier;
  final ValueNotifier<bool> showBottomNavNotifier;
  final ValueNotifier<bool> showAdsNotifier;

  set scrollMode(ScrollMode? set) {
    if (set != null && set != scrollModeNotifier.value) {
      scrollModeNotifier.value = set;
      setAllSharedPrefs();
    }
  }

  set useTestRig(bool? set) {
    if (set != null && set != testRigNotifier.value) {
      testRigNotifier.value = set;
      setAllSharedPrefs();
    }
  }

  set showFonts(bool? set) {
    if (set != null && set != showFontsNotifier.value) {
      showFontsNotifier.value = set;
      setAllSharedPrefs();
    }
  }

  set showBottomNav(bool? set) {
    if (set != null && set != showBottomNavNotifier.value) {
      showBottomNavNotifier.value = set;
      setAllSharedPrefs();
    }
  }

  set _scrollMode(ScrollMode? set) {
    if (set != null && set != scrollModeNotifier.value) {
      scrollModeNotifier.value = set;
    }
  }

  set _useTestRig(bool? set) {
    if (set != null && set != testRigNotifier.value) {
      testRigNotifier.value = set;
    }
  }

  set _showFonts(bool? set) {
    if (set != null && set != showFontsNotifier.value) {
      showFontsNotifier.value = set;
    }
  }

  set _showBottomNav(bool? set) {
    if (set != null && set != showBottomNavNotifier.value) {
      showBottomNavNotifier.value = set;
    }
  }

  ViewSettings.defaultsThenLoad()
      : scrollModeNotifier =
            ValueNotifier<ScrollMode>(ScrollMode.defaultScroll),
        testRigNotifier = ValueNotifier<bool>(false),
        showFontsNotifier = ValueNotifier<bool>(true),
        showBottomNavNotifier = ValueNotifier<bool>(true),
        showAdsNotifier = ValueNotifier<bool>(true) {
    getFromSharedPrefs();
  }

  ViewSettings.values(
      {ScrollMode? useInfiniteScroll,
      bool? useTestRig,
      bool? showFonts,
      bool? showBottomNav,
      bool? showAds})
      : scrollModeNotifier = ValueNotifier<ScrollMode>(
            useInfiniteScroll ?? ScrollMode.defaultScroll),
        testRigNotifier = ValueNotifier<bool>(useTestRig ?? false),
        showFontsNotifier = ValueNotifier<bool>(showFonts ?? true),
        showBottomNavNotifier = ValueNotifier<bool>(showBottomNav ?? true),
        showAdsNotifier = ValueNotifier<bool>(showAds ?? true) {
    scrollModeNotifier.addListener(anySet);
    testRigNotifier.addListener(anySet);
    showFontsNotifier.addListener(anySet);
    showBottomNavNotifier.addListener(anySet);
  }
  void anySet() {
    setAllSharedPrefs();
  }

  @override
  String toString() {
    return 'i=${scrollModeNotifier.value.name} r=$testRigNotifier f=$showFontsNotifier bn=${showBottomNavNotifier.value}';
  }

  void getFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? inf = prefs.getInt('scroll');
    if (inf != null && inf != scrollMode.index) {
      _scrollMode = ScrollMode.values[inf];
    }

    _useTestRig = prefs.getBool('debug');
    _showFonts = prefs.getBool('showFonts');
    _showBottomNav = prefs.getBool('showBottomNav');
    //TODO: Ad stuff
  }

  void setAllSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('scroll', scrollMode.index);
    prefs.setBool('debug', useTestRig);
    prefs.setBool('showFonts', showFonts);
    prefs.setBool('showBottomNav', showBottomNav);
  }
}
