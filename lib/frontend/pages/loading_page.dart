import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

import '../elements/widgets/loader.dart';

class LoadingPage extends StatelessWidget {
  final String message;
  const LoadingPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return McScaffold(
      source: null,
      child: TriWizardLoader(
        message: message,
      ),
    );
  }
}
