import 'package:flutter/material.dart';

import '../../backend/error_handler.dart';
import '../elements/scaffold_with_scroll.dart';
import '../elements/widgets/error_page_button.dart';

class ErrorPage extends StatelessWidget {
  final IconData? illustration;
  final ErrorPageButton button;
  final String header;
  final String parenthetical;
  final List<Widget> preIconElements;
  final List<Widget> postIconElements;
  final List<Widget> tailElements;
  // final ExceptionElement exception;
  final Object? exception;
  final Object? stackTrace;
  const ErrorPage({
    super.key,
    required this.header,
    required this.parenthetical,
    this.preIconElements = const [],
    required this.illustration,
    required this.button,
    this.postIconElements = const [],
    required this.exception,
    required this.stackTrace,
    this.tailElements = const [],
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        header,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      Text(parenthetical),
      const SizedBox(
        height: 6,
      ),
    ];

    if (preIconElements.isNotEmpty) {
      children.addAll(preIconElements);
      children.add(const SizedBox(height: 12));
    } else {
      children.add(const SizedBox(height: 6));
    }
    children.add(Icon(
      illustration,
      size: 108,
      color: const Color(0x22ffffff),
    ));

    if (postIconElements.isNotEmpty) {
      children.addAll(postIconElements);
      children.add(const SizedBox(height: 12));
    } else {
      children.add(const SizedBox(height: 6));
    }

    children.addAll([
      const SizedBox(
        height: 12,
      ),
      button,
      const SizedBox(
        height: 24,
      ),
      ExceptionElement(
          exception: exception ?? '[no error]', stackTrace: '[no trace]')
    ]);
    return ScaffoldWithScroll(
        bg: null,
        source: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ));
  }
}
