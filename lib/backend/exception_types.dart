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
  final String? debugSource;
  // final int fileId;
  const FontException(this.msg,
      {required this.family, required this.debugSource});
  // const FontException.fromId(this.msg, {required int id}) : this.family = fontFamilyFrom
  @override
  String toString() => 'FontException: $msg ($family) (chp $debugSource)';
}
