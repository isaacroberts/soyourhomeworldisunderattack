import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import '../../icons.dart';
import '../../styles.dart';

class ErrorIcon extends StatelessWidget {
  final String exceptionType;
  const ErrorIcon({super.key, required this.exceptionType});

  IconData getIcon() {
    if (exceptionType == '_ClientSocketException') {
      return RpgAwesome.cannon_shot;
    } else if (exceptionType == 'HttpExceptionWithStatus') {
      return RpgAwesome.cannon_shot;
    } else if (exceptionType == 'BookCodeException') {
      return RpgAwesome.burning_book;
    } else if (exceptionType == 'ChapterFormatException') {
      return RpgAwesome.burning_book;
    } else if (exceptionType == 'FontException') {
      return RpgAwesome.aquarius;
    } else if (exceptionType == 'IdiotException') {
      return RpgAwesome.hand;
    } else if (exceptionType == '_Exception') {
      return RpgAwesome.gear_hammer;
    }

    dev.log("Un-Iconed- exception: $exceptionType");
    return RpgAwesome.flaming_claw;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(getIcon(), size: 50, color: errorColor);
  }
}
