import 'package:soyourhomeworld/backend/part_id.dart';

typedef ChapterKey = int;

//TODO: Move into ChapterHolder
class ChapterInfo {
  /// Stores the information read from headers
  final ChapterKey id;
  final String displayName;
  final String filename;
  final String varName;
  final PartId partId;
  final bool isPart;
  final bool hidePart;
  final int? next;

  const ChapterInfo(
      {required this.id,
      required this.varName,
      required this.displayName,
      required this.filename,
      required this.next,
      //TODO: This is intentionally Blocking value
      required PartId partId,
      // required this.partId,
      required this.isPart,
      required this.hidePart})
      : partId = PartId.noir;

// ChapterInfo.blank()
//     : id = 0,
//       varName = 'blank',
//       displayName = '-',
//       filename = '',
//       next = null;
}
