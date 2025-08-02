import 'package:flutter/material.dart';

import '../../theme/styles.dart';

void _goHome(BuildContext context) {}

class ErrorPageButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? text;

  const ErrorPageButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.text});

  static ErrorPageButton goHome({Key? key, required BuildContext context}) {
    return ErrorPageButton(
        icon: Icons.home, text: null, onPressed: () => _goHome(context));
  }

  const ErrorPageButton.tooBusted({super.key})
      : onPressed = null,
        icon = null,
        text = null;

  @override
  Widget build(BuildContext context) {
    //Icon, no text
    if (icon != null && text == null) {
      return MaterialButton(
          color: errorColor,
          padding: const EdgeInsets.all(12),
          // shape: const CircleBorder(),
          onPressed: onPressed,
          child: Icon(
            icon,
            size: 24,
            color: const Color(0xaaffffff),
          ));
    }
    //Text, no Icon
    else if (icon == null && text != null) {
      return MaterialButton(
          color: errorColor,
          padding: const EdgeInsets.all(12),
          // shape: const CircleBorder(),
          onPressed: onPressed,
          child: Text(
            text!,
            style: Theme.of(context).textTheme.labelMedium,
          ));
    }
    //Both
    else if (icon != null && text != null) {
      //Todo: Color
      return FilledButton.tonalIcon(
          // style: ButtonStyle(),
          onPressed: onPressed,
          label: Text(
            text!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          icon: Icon(
            icon,
            size: 24,
            color: const Color(0xaaffffff),
          ));
    }
    //Neither
    else if (icon == null && text == null) {
      return MaterialButton(
          onPressed: onPressed,
          color: errorColor,
          child: const SizedBox(width: 24, height: 24));
    } else {
      throw Exception('Logic has broken down!');
    }
  }
}
