import 'package:flutter/material.dart';

import '../frontend/elements/scaffold.dart';
import '../frontend/theme/base_text_theme.dart';
import 'error_handler.dart';

const String buildNo = '1.0.0.0';

class ExceptionPage extends StatefulWidget {
  final ExceptionHolder holder;
  const ExceptionPage({super.key, required this.holder});

  @override
  State<ExceptionPage> createState() => _ExceptionPageState();
}

class _ExceptionPageState extends State<ExceptionPage> {
  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'error_page',
        child: Center(child: ExceptionBox.fromHolder(widget.holder)));
  }
}

class ErrorPage extends StatelessWidget {
  final List<ExceptionHolder> list;
  const ErrorPage({super.key, required this.list});
  Widget widget(BuildContext context) {
    return Column(
        key: const Key("errorPageCol"),
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Errors:', style: headerFont),
          const Text('Build: $buildNo', style: bodyFont),
          if (list.isEmpty)
            const Center(
                child: Text(
              "No errors!",
              style: bodyFont,
            )),
          if (list.isNotEmpty)
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              if (index >= 0 && index < list.length) {
                return list[list.length - index - 1].element(context);
              } else {
                return null;
              }
            }))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return McScaffold(source: 'Error', child: widget(context));
  }
}
