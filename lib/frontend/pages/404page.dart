// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/error_page_button.dart';
import 'package:soyourhomeworld/frontend/icons.dart';
import 'package:soyourhomeworld/frontend/pages/base_error_page.dart';

class FourOhFourPage extends StatelessWidget {
  final String? whatsMissing;
  const FourOhFourPage({super.key, this.whatsMissing});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredIconCard(
        text: '404!',
        extra: whatsMissing,
        color: fireOrangeColor,
        icon: RpgAwesome.campfire,
      ),
    );
  }
}

class ErrorCodePage extends StatelessWidget {
  final int code;
  final String? error;
  final String? trace;
  const ErrorCodePage({super.key, required this.code, this.error, this.trace});

  void goHome(BuildContext context) {
    //TODO: Find a funny place to send them
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return ErrorPage(
        header: 'Error: $code',
        parenthetical: '(Server error)',
        illustration: RpgAwesome.bomb_explosion,
        button: ErrorPageButton.goHome(context: context),
        exception: error,
        stackTrace: trace);
  }
}
