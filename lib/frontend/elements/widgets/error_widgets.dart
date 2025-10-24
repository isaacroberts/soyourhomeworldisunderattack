import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../backend/error_handler.dart';
import '../../theme/base_colors.dart';
import '../../theme/base_text_theme.dart';
import '../scaffold.dart';
import 'error_base.dart';
import 'error_type_icon.dart';

const String buildNo = '1.2.1.0';

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
          Text('Errors:', style: headerFont(color: const Color(0xffffffff))),
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
    return McScaffold(
        source: 'dev_error',
        //Get back button
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        child: widget(context));
  }
}

class ExceptionElement extends StatelessWidget {
  final Object exception;
  final Object stackTrace;

  const ExceptionElement(
      {super.key, required this.exception, required this.stackTrace});

  ExceptionElement.fromHolder({super.key, required ExceptionHolderBase holder})
      : exception = holder.exception,
        stackTrace = holder.stackTrace;

  @override
  Widget build(BuildContext context) {
    String type = exception.runtimeType.toString();
    if (type == 'String') {
      type = 'Exception';
    }
    return Center(
        child: SizedBox(
            width: 800,
            child: SelectionArea(
                child: ExpansionTile(
              // backgroundColor: errorSecondary,
              collapsedBackgroundColor: errorBg,
              // backgroundColor: e,
              iconColor: errorMinor,
              collapsedIconColor: errorColor,
              leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: ErrorIcon(
                      exceptionType: exception.runtimeType.toString())),

              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: errorColor, width: 5)),
              clipBehavior: Clip.none,
              expandedAlignment: Alignment.topCenter,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(type,
                  selectionColor: const Color(0xff000000),
                  // selectionColor: ,
                  style: errorFont.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: errorColor)),
              subtitle: Text(exception.toString(),
                  selectionColor: const Color(0xff000000),
                  style: errorFont.copyWith(color: errorColor)),

              children: [
                Text('StackTrace:\n$stackTrace',
                    selectionColor: const Color(0xff000000), style: errorFont)
              ],
            ))));
  }
}

class ErrorBox extends StatelessWidget {
  final String text;

  const ErrorBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    //return Icon(AppIcons.rpgAwesome);
    return Container(
        // height: 200,
        alignment: Alignment.center,
        color: errorBg,
        child: SingleChildScrollView(child: Text(text, style: bodyFont)));
  }
}

class ExceptionBox extends StatelessWidget {
  final ExceptionHolderBase holder;
  const ExceptionBox.fromHolder(this.holder, {super.key});
  const ExceptionBox.mashObjectIntoHolder({super.key, required Object holder})
      : holder = holder as ExceptionHolder;

  // ErrorBox.fromException(Object exception, {StackTrace? stackTrace, super.key})
  // : holder = ExceptionHolder(exception: exception, stackTrace: stackTrace ?? StackTrace.current);

  // const ErrorBox(Object exception, StackTrace? trace)
  // : holder = ExceptionHolder(exception: exception, stackTrace: trace);

  static ExceptionBox fromException(Object exception,
      [StackTrace? stackTrace]) {
    ExceptionHolder holder = ExceptionHolder(
        exception: exception, stackTrace: stackTrace ?? StackTrace.current);
    return ExceptionBox.fromHolder(holder);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 200,
        alignment: Alignment.center,
        color: errorBg,
        child: SingleChildScrollView(
            child: ExceptionElement.fromHolder(
          holder: holder,
        )));
  }
}

void showErrorSnackBar(
    BuildContext context, ExceptionHolderBase exception, String subline) {
  SnackBar snackBar = SnackBar(
      action: SnackBarAction(
          label: 'View', onPressed: () => _onSnackBarPressed(context)),
      // backgroundColor: errorBg,
      showCloseIcon: true,
      content: Text(
        exception.exception.toString(),
        maxLines: 2,
      ));

  ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackBar);
}

void _onSnackBarPressed(BuildContext context) {
  context.go('/logger');
}
