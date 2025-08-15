import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/deferred_load_tools.dart';
//Deferred
import 'package:soyourhomeworld/frontend/elements/widgets/error_type_icon.dart';

import '../frontend/elements/holders/holder_base.dart';
import '../frontend/theme/base_text_theme.dart';
import '../frontend/theme/colors.dart';
import '../frontend/theme/text_theme.dart';
import 'error_page.dart' deferred as error_lib_page;

class ErrorList {
  static ErrorList instance = ErrorList();

  final List<ExceptionHolder> list = [];
  final List<ExceptionHolder> _snackbarWaiting = [];
  final Set<Type> errorSnackbarsShown = {};

  ErrorList();

  // ===  Errors =======
  static void showErrorNow(BuildContext context, Object e,
      [StackTrace? trace]) {
    printError(e, trace);

    ExceptionHolder holder =
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current);
    instance.list.add(holder);
    instance._showSnackBar(context, holder);
  }

  static void showError(Object e, [StackTrace? trace]) {
    printError(e, trace);

    ExceptionHolder holder =
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current);
    instance.list.add(holder);
    instance._queueSnackBar(holder);
  }

  static void logError(Object e, [StackTrace? trace]) {
    printError(e, trace);
    instance.list.add(
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current));
  }

  static void logWarning(Object warning, [StackTrace? trace]) {
    dev.log("Warning: $warning");
    if (trace != null) {
      dev.log("Trace:");
      dev.log(trace.toString());
    }
    instance.list.add(ExceptionHolder.warning(warning,
        stackTrace: trace ?? StackTrace.current));
  }

  static void logErrorHolder(ExceptionHolder e) {
    printError(e.exception, e.stackTrace);

    instance.list.add(e);
  }

  static void printError(Object exception, Object? trace) {
    dev.log('\n\n');
    dev.log(' -!- Exception -!- ');
    dev.log(exception.toString());
    if (trace != null) {
      dev.log(' --- Stack Trace ---');
      dev.log(trace.toString());
    }
    dev.log('\n\n');
  }

  Widget page(BuildContext context) {
    return DeferredPage(
        key: const Key("ErrorDeferPage"),
        loader: error_lib_page.loadLibrary,
        builder: (c) =>
            error_lib_page.ErrorPage(key: const Key("ErrorPage"), list: list));
  }

  // === Snackbar ================

  void _onSnackBarPressed(BuildContext context) {
    context.go('/logger');
  }

  SnackBar _errorSnackBar(BuildContext context, ExceptionHolder exception) {
    String txt = exception.exception.toString();
    String rt = exception.exception.runtimeType.toString();
    if (rt != 'String') {
      txt = '$rt:$txt';
    }
    if (_snackbarWaiting.isNotEmpty) {
      txt += ' (${_snackbarWaiting.length} errors waiting)';
    }
    return SnackBar(
        action: SnackBarAction(
            label: 'View', onPressed: () => _onSnackBarPressed(context)),
        backgroundColor: errorBg,
        content: Text(txt, maxLines: 2, style: monoFont));
  }

  bool firstErrorOfType(ExceptionHolder exec) {
    if (!errorSnackbarsShown.contains(exec.exception.runtimeType)) {
      errorSnackbarsShown.add(exec.exception.runtimeType);
      return true;
    } else {
      return false;
    }
  }

  void _showSnackBar(BuildContext context, ExceptionHolder exec) {
    if (firstErrorOfType(exec)) {
      ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar(context, exec));
    }
  }

  void _queueSnackBar(ExceptionHolder exec) {
    if (firstErrorOfType(exec)) {
      _snackbarWaiting.add(exec);
    }
  }

  void checkSnackbar(BuildContext context) {
    if (_snackbarWaiting.isNotEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_errorSnackBar(context, _snackbarWaiting.removeAt(0)));
    }
  }
}

class ExceptionHolder extends Holder {
  final Object exception;
  final Object stackTrace;
  final bool isWarning;
  const ExceptionHolder({required this.exception, required this.stackTrace})
      : isWarning = false;
  const ExceptionHolder.warning(Object warning, {required this.stackTrace})
      : isWarning = true,
        exception = warning;

  @override
  Widget element(BuildContext context) {
    return ExceptionElement(exception: exception, stackTrace: stackTrace);
  }

  @override
  Widget fallback(BuildContext context) {
    return ExceptionElement(exception: exception, stackTrace: stackTrace);
  }

  @override
  String toText() {
    return '[Exception: $exception]';
  }
}

class ExceptionElement extends StatelessWidget {
  final Object exception;
  final Object stackTrace;

  const ExceptionElement(
      {super.key, required this.exception, required this.stackTrace});

  ExceptionElement.fromHolder({super.key, required ExceptionHolder holder})
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
                  style: appMonoFont.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: errorColor)),
              subtitle: Text(exception.toString(),
                  selectionColor: const Color(0xff000000),
                  style: appMonoFont.copyWith(fontSize: 12, color: errorColor)),

              children: [
                Text('StackTrace:\n$stackTrace',
                    selectionColor: const Color(0xff000000),
                    style: appMonoFont.copyWith(fontSize: 12))
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
  final ExceptionHolder holder;
  const ExceptionBox.fromHolder(this.holder, {super.key});
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
        child: SingleChildScrollView(child: holder.element(context)));
  }
}

class DeveloperException implements Exception {
  final String msg;
  const DeveloperException(this.msg);
  @override
  String toString() => 'DeveloperException (Unhandled dev error): $msg';
}

class IdiotException implements Exception {
  final String msg;
  const IdiotException(this.msg);
  @override
  String toString() => 'IdiotException (Unhandled dev error): $msg';
}

class UserException implements Exception {
  final String msg;
  const UserException(this.msg);
  @override
  String toString() => 'UserError: $msg';
}

class ChapterFormatException implements Exception {
  final String msg;
  String? debugId;
  ChapterFormatException(this.msg, {required this.debugId});
  @override
  String toString() =>
      'ChapterFormatException (Error from chapter binary input): $msg [debugId=$debugId]';
}

class BookCodeException implements Exception {
  final String msg;
  // String? chapter;
  BookCodeException(this.msg);
  @override
  String toString() =>
      'BookCodeException (Error from book\'s code markers): $msg';
}

class FontException implements Exception {
  final String msg;
  final String? family;
  // final int fileId;
  const FontException(this.msg, {required this.family});
  // const FontException.fromId(this.msg, {required int id}) : this.family = fontFamilyFrom
  @override
  String toString() => 'FontException: $msg ($family)';
}
