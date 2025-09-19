import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../frontend/components/deferrals/error_widget.dart' as defer;
import '../frontend/elements/holders/holder_base.dart';
import '../frontend/elements/widgets/error_base.dart';

class ErrorList {
  static ErrorList instance = ErrorList();

  final List<ExceptionHolder> list = [];
  final List<ExceptionHolderBase> _snackbarWaiting = [];
  final Set<Type> errorSnackbarsShown = {};

  ErrorList();

  // ===  Errors =======
  static void showErrorNow(BuildContext context, Object e,
      [StackTrace? trace]) {
    printError(e, trace);

    ExceptionHolder holder =
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current);
    instance.list.add(holder);
    instance.showSnackBar(context, holder);
  }

  static void showError(Object e, [StackTrace? trace]) {
    printError(e, trace);

    ExceptionHolder holder =
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current);
    instance.list.add(holder);
    bool typeToShow = (e.runtimeType.toString() != 'FontException');
    if (kDebugMode || typeToShow) {
      instance._queueSnackBar(holder);
    }
  }

  ///Returns the ExceptionHolder in case you want to display the widget
  static ExceptionHolder logError(Object e, [StackTrace? trace]) {
    printError(e, trace);
    ExceptionHolder exceptionHolder =
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current);

    instance.list.add(exceptionHolder);
    return exceptionHolder;
  }

  static ExceptionHolder logWarning(Object warning, [StackTrace? trace]) {
    dev.log("Warning: $warning");
    if (trace != null) {
      dev.log("Trace:");
      dev.log(trace.toString());
    }
    ExceptionHolder exceptionHolder = ExceptionHolder.warning(warning,
        stackTrace: trace ?? StackTrace.current);

    instance.list.add(exceptionHolder);
    return exceptionHolder;
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

  // == Element routers

  static Widget page(BuildContext context) {
    return defer.page(context);
  }

  static Widget stringBox(BuildContext context, {required String text}) {
    return defer.stringBox(context, text: text);
  }

  Widget box(BuildContext context, Object exception, StackTrace? trace) {
    return defer.box(context, exception, trace);
  }

  Widget holderBox(BuildContext context,
      {required ExceptionHolderBase holder}) {
//No keys because they're too likely to be repeated
//  along the scroll
    return defer.holderBox(context, holder: holder);
  }

  static Widget element(BuildContext context,
      {required ExceptionHolderBase holder}) {
    return defer.element(context, holder: holder);
  }

  // === Snackbar ================

  void showSnackBar(BuildContext context, ExceptionHolderBase exception) async {
    if (firstErrorOfType(exception)) {
      String txt = exception.exception.toString();
      String rt = exception.exception.runtimeType.toString();
      if (rt != 'String') {
        txt = '$rt:$txt';
      }
      String subt = '';
      if (_snackbarWaiting.isNotEmpty) {
        subt = ' (${_snackbarWaiting.length} errors waiting)';
      }
      await defer.errorWidgetDeferredFuture();
      if (context.mounted) {
        defer.showErrorSnackBar(context, exception, subt);
      }
    }
  }

  bool firstErrorOfType(ExceptionHolderBase exec) {
    if (!errorSnackbarsShown.contains(exec.exception.runtimeType)) {
      errorSnackbarsShown.add(exec.exception.runtimeType);
      return true;
    } else {
      return false;
    }
  }

  void _queueSnackBar(ExceptionHolderBase exec) {
    if (firstErrorOfType(exec)) {
      _snackbarWaiting.add(exec);
    }
  }

  void checkSnackbar(BuildContext context) {
    if (_snackbarWaiting.isNotEmpty) {
      showSnackBar(context, _snackbarWaiting.removeAt(0));
    }
  }
}

class ExceptionHolder extends Holder implements ExceptionHolderBase {
  @override
  final Object exception;
  @override
  final Object stackTrace;
  @override
  final bool isWarning;
  const ExceptionHolder({required this.exception, required this.stackTrace})
      : isWarning = false;
  const ExceptionHolder.warning(Object warning, {required this.stackTrace})
      : isWarning = true,
        exception = warning;

  @override
  Widget element(BuildContext context) {
    return defer.element(context, holder: this);
  }

  Widget box(BuildContext context) {
    return defer.holderBox(context, holder: this);
  }

  @override
  Widget fallback(BuildContext context) {
    return defer.element(context, holder: this);
  }

  @override
  String toText() {
    return '[Exception: $exception]';
  }
}
