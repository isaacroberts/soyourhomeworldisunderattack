import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'frontend/elements/router.dart';

Future<void> main() async {
  // if (kDebugMode) {
  //   runApp(const MyStatefulApp());
  // } else {
  runApp(const MyApp());
  // }

  // runApp(const ProviderScope(child: MyStatefulApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : Learn about RouteInformationProvider
    return MaterialApp.router(
      title: 'The McKinsey Plan',
      // scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      // scrollBehavior:
      //     ScrollConfiguration.of(context).copyWith(scrollbars: false),
      theme: theme,
      routerConfig: router(),
    );
  }
}

/*
class MyStatefulApp extends StatefulWidget {
  const MyStatefulApp({super.key});

  @override
  State<MyStatefulApp> createState() => _MyStatefulAppState();
}

String twochars(int n) {
  String s = n.toString();
  if (s.isEmpty) {
    return '00';
  }
  if (s.length == 1) {
    return '0$s';
  } else if (s.length == 2) {
    return s;
  } else {
    return s;
  }
}

void _timerCallback(Timer t) {
  int min = t.tick ~/ 60;
  int sec = t.tick % 60;
  if (sec % 5 == 0) {
    dev.log('${twochars(min)}:${twochars(sec)}');
  }
}

class _MyStatefulAppState extends State<MyStatefulApp> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
    dev.log('Timer!');
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'The McKinsey Plan',
      // scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      // scrollBehavior:
      //     ScrollConfiguration.of(context).copyWith(scrollbars: false),
      theme: theme,
      routerConfig: router(),
    );
  }
}
*/
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}
