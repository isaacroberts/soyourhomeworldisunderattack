import 'package:flutter/material.dart';

class BuildFrog extends StatelessWidget {
  /// It calls the builder, man.
  ///I just need to get the build call below the stack frame, for InheritedWidget purposes.
  final WidgetBuilder builder;
  const BuildFrog({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
