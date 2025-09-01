import 'package:soyourhomeworld/backend/error_handler.dart';
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

  static ChapterInfo fromJson(int index, var data) {
    ///Read from JSON instead of binary
    /*
    {"ix": 0, "var": "Title", "display": "Title", "part": "0", "filename": "SoYourHomeworld/part_0_Title.bin", "next": 1}
     */
    String? varName = data['var'];
    //Must have varname
    assert(varName != null, 'Varname missing in index @ chapter $index');
    String display = data['display'] ?? 'Chapter';
    int part = data['partId'];
    //Validate partId
    if (part < 0 || part >= PartId.values.length) {
      ErrorList.logError(
          ChapterFormatException('Invalid partId: $part', debugId: varName));
      part = 0;
    }
    //^ = part; v = hidden part; 0 = not part
    String partSign = data['isPart'] ?? '0';
    bool hidePart = partSign == 'v';
    bool isPart = partSign == '^' || hidePart;

    String? filename = data['filename'];
    //Missing filename will cause an error later
    assert(filename != null,
        "Missing filename in index @ chapter: $index ($varName)");
    int? next = data['next'];
    // var nextS = data['next'];
    //nextS might be empty, in which case next should be null
    // int? next = int.tryParse(nextS);
    return ChapterInfo(
        id: index,
        varName: varName!,
        displayName: display,
        filename: filename!,
        next: next,
        partId: PartId.values[part],
        isPart: isPart,
        hidePart: hidePart);
  }

// ChapterInfo.blank()
//     : id = 0,
//       varName = 'blank',
//       displayName = '-',
//       filename = '',
//       next = null;
}
