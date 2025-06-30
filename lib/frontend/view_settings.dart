import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewSettings extends ChangeNotifier {
  static ViewSettings instance = ViewSettings.defaultsThenLoad();

  bool get useInfiniteScroll => _useInfiniteScroll;

  bool get useTestRig => _useTestRig;
  bool get showFonts => _showFonts;

  set useInfiniteScroll(bool? set) {
    if (set != null && set != _useInfiniteScroll) {
      _useInfiniteScroll = set;
      notifyListeners();
      setAllSharedPrefs();
    }
  }

  set useTestRig(bool? set) {
    if (set != null && set != _useTestRig) {
      _useTestRig = set;
      notifyListeners();
      setAllSharedPrefs();
    }
  }

  set showFonts(bool? set) {
    if (set != null && set != _showFonts) {
      _showFonts = set;
      notifyListeners();
      setAllSharedPrefs();
    }
  }

  bool _useInfiniteScroll;
  bool _useTestRig;
  bool _showFonts;

  @override
  void notifyListeners() {
    dev.log("Notifying viewsettings change ${toString()}");
    super.notifyListeners();
  }

  // ViewSettings.defaults()
  //     : _useInfiniteScroll = true,
  //       _useTestRig = false,
  //       _showFonts = true;
  ViewSettings.defaultsThenLoad()
      : _useInfiniteScroll = true,
        _useTestRig = false,
        _showFonts = true {
    getFromSharedPrefs();
  }

  ViewSettings.values(
      {bool? useInfiniteScroll, bool? useTestRig, bool? showFonts})
      : _useInfiniteScroll = useInfiniteScroll ?? true,
        _useTestRig = useTestRig ?? false,
        _showFonts = showFonts ?? true;

  @override
  String toString() {
    return 'i=_ r=$_useTestRig f=$_showFonts';
  }

  void getFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? inf = prefs.getBool('inf');
    bool? rig = prefs.getBool('rig');
    bool? fonts = prefs.getBool('_showFonts');
    bool changed = false;
    if (inf != null && inf != _useInfiniteScroll) {
      _useInfiniteScroll = inf;
      changed = true;
    }
    if (rig != null && rig != _useTestRig) {
      _useTestRig = rig;
      changed = true;
    }
    if (fonts != null && fonts != _showFonts) {
      _showFonts = fonts;
      changed = true;
    }
    if (changed) {
      notifyListeners();
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
    prefs.setBool('inf', _useInfiniteScroll);
    prefs.setBool('rig', _useTestRig);
    prefs.setBool('_showFonts', _showFonts);
  }

  static bool staticUpdateShouldNotify(ViewSettings a, ViewSettings b) {
    return a.useTestRig != b.useTestRig ||
        a.useInfiniteScroll != b.useInfiniteScroll ||
        a.showFonts != b.showFonts;
  }
}

class ViewSettingsWrapper extends StatelessWidget {
  final Widget child;
  const ViewSettingsWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: ViewSettings.instance, builder: (context, w) => child);
    // return ChangeNotifierProvider<ViewSettings>(
    //     create: (context) => ViewSettings.instance, child: child);
  }
}
