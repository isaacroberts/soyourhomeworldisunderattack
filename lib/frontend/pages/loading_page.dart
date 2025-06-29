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
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              // const CircularProgressIndicator(),
              TriWizardLoader(
                text: message,
              ),
              if (message.isNotEmpty)
                Text(
                  message,
                  textAlign: TextAlign.center,
                )
            ])));
  }
}
