typedef ChapterKey = int;

//TODO: Move into ChapterHolder
class ChapterInfo {
  /// Stores the information read from headers
  final ChapterKey id;
  final String displayName;
  final String filename;
  final String varName;
  final bool isPart;
  final bool hidePart;
  final int? next;

  const ChapterInfo(
      {required this.id,
      required this.varName,
      required this.displayName,
      required this.filename,
      required this.next,
      required this.isPart,
      required this.hidePart});

// ChapterInfo.blank()
//     : id = 0,
//       varName = 'blank',
//       displayName = '-',
//       filename = '',
//       next = null;
}
