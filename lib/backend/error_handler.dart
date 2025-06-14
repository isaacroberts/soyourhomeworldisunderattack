import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

import '../frontend/elements/holders/textholders.dart';
import '../frontend/icons.dart';
import '../frontend/styles.dart';

class ErrorList {
  static ErrorList instance = ErrorList();

  final List<ExceptionHolder> list = [];
  final List<ExceptionHolder> _snackbarWaiting = [];
  final Set<Type> errorSnackbarsShown = {};

  ErrorList();

  // ===  Errors =======
  static void showErrorNow(BuildContext context, Object e,
      [StackTrace? trace]) {
    ExceptionHolder holder =
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current);
    instance.list.add(holder);
    instance._showSnackBar(context, holder);
  }

  static void showError(Object e, [StackTrace? trace]) {
    ExceptionHolder holder =
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current);
    instance.list.add(holder);
    instance._queueSnackBar(holder);
  }

  static void logError(Object e, [StackTrace? trace]) {
    instance.list.add(
        ExceptionHolder(exception: e, stackTrace: trace ?? StackTrace.current));
  }

  static void logWarning(Object warning, [StackTrace? trace]) {
    instance.list.add(ExceptionHolder.warning(warning,
        stackTrace: trace ?? StackTrace.current));
  }

  static void logErrorHolder(ExceptionHolder e) {
    instance.list.add(e);
  }

  // ==== Main Page ====
  Widget page(BuildContext context) {
    return McScaffold(
        source: 'Error',
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Errors:', style: headerFont),
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
            ]));
  }

  // === Snackbar ================

  void _onSnackbarPressed(BuildContext context) {
    context.go('error_page');
  }

  SnackBar _errorSnackBar(BuildContext context, ExceptionHolder exep) {
    String txt = exep.exception.toString();
    String rt = exep.exception.runtimeType.toString();
    if (rt != 'String') {
      txt = '$rt:$txt';
    }
    if (_snackbarWaiting.isNotEmpty) {
      txt += ' (${_snackbarWaiting.length} errors waiting)';
    }
    return SnackBar(
        action: SnackBarAction(
            label: 'View', onPressed: () => _onSnackbarPressed(context)),
        backgroundColor: errorBg,
        content: Text(txt, style: monoFont));
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

  // static ExceptionHolder factory(Object exception, [StackTrace? stackTrace])
  // {
  //   ExceptionHolder e = ExceptionHolder(exception: exception, stackTrace: stackTrace ?? StackTrace.current);
  //   ErrorList.registerErrorHolder(e);
  //   return e;
  // }

  @override
  Widget element(BuildContext context) {
    return ExceptionElement(exception: exception, stackTrace: stackTrace);
  }

  @override
  Widget fallback(BuildContext context) {
    return ExceptionElement(exception: exception, stackTrace: stackTrace);
  }
}

class ExceptionElement extends StatelessWidget {
  final Object exception;
  final Object stackTrace;

  const ExceptionElement(
      {super.key, required this.exception, required this.stackTrace});

  @override
  Widget build(BuildContext context) {
    String type = exception.runtimeType.toString();
    if (type == 'String') {
      type = 'Exception';
    }
    return ExpansionTile(
      // backgroundColor: errorSecondary,
      collapsedBackgroundColor: errorBg,
      // backgroundColor: e,
      iconColor: errorSecondary,
      collapsedIconColor: errorColor,

      leading:
          const Icon(RpgAwesome.player_pain, size: 50, color: Colors.black45),
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: errorColor, width: 5)),
      clipBehavior: Clip.none,
      expandedAlignment: Alignment.topCenter,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(type, style: headerFont.copyWith(color: errorSecondary)),
      subtitle: Text(exception.toString(), style: bodyFont),

      children: [Text('StackTrace:\n$stackTrace', style: monoFont)],
    );
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

class FontException implements Exception {
  final String msg;
  final String? family;
  // final int fileId;
  const FontException(this.msg, {required this.family});
  // const FontException.fromId(this.msg, {required int id}) : this.family = fontFamilyFrom
  @override
  String toString() => 'FontException: $msg ($family)';
}
