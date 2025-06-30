import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../../backend/error_handler.dart';
import '../icons.dart';

class ServerOfflinePage extends StatelessWidget {
  final ExceptionHolder sourceError;
  const ServerOfflinePage({super.key, required this.sourceError});

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: null,
        child: ColoredBox(
            color: errorBg,
            child: Center(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 48,
                        ),
                        const Text('Server offline'),
                        const Text('Try sending money'),
                        const SizedBox(
                          height: 6,
                        ),
                        const Icon(
                          RpgAwesome.battery_0,
                          size: 108,
                          color: Color(0x22ffffff),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text('If you are the dev'),
                        const Text('Try starting the server'),
                        const SizedBox(
                          height: 48,
                        ),
                        sourceError.element(context),
                      ],
                    )))));
  }
}
