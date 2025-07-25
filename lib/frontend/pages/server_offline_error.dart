import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' as go;
import 'package:soyourhomeworld/frontend/elements/widgets/error_page_button.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

import 'base_error_page.dart';

class ServerOfflinePage extends StatelessWidget {
  final Object exception;
  final Object? stackTrace;
  const ServerOfflinePage(
      {super.key, required this.exception, required this.stackTrace});

  void refresh(BuildContext context) {
    go.GoRouter.of(context).refresh();
    // context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return ErrorPage(
        header: 'Server offline',
        parenthetical: '(Connection error)',
        illustration: RpgAwesome.battery_0,
        button: ErrorPageButton(
          onPressed: () => refresh(context),
          icon: Icons.refresh,
          text: null,
        ),
        exception: exception,
        stackTrace: stackTrace);
  }
}
