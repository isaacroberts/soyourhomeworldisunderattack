import 'package:shared_preferences/shared_preferences.dart';

class BookmarkSaver {
  static BookmarkSaver instance = BookmarkSaver();

  int? currentChapter;
  int? uuid;

  BookmarkSaver();

  Future<int> startupLoad() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentChapter = prefs.getInt('bookmark') ?? 0;
    uuid = prefs.getInt('session_id');
    //-1 = null
    if (uuid == -1) {
      //Null value
      uuid = null;
    }
    return currentChapter!;
  }

  void save() async {
    if (currentChapter != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('bookmark', currentChapter!);
      prefs.setInt('session_id', uuid ?? -1);
    }
  }
}
