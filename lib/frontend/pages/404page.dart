// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/icons.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredIconCard(
        text: 'Error: $code',
        extra: error,
        color: errorBg,
        icon: RpgAwesome.capitol,
      ),
    );
  }
}
