import 'book.dart';

class Library {
  /*
      A cache.
   */

  final Map<String, Book> bookCache = {};

  Library();

  void saveBook(Book book) {
    bookCache[book.id] = book;
  }

  bool hasBook(String id) {
    return bookCache.containsKey(id);
  }

  Book? checkoutBook(String id) {
    return bookCache[id];
  }

  Future<List<BookLoader>> availableBooks() async {
    return [BookLoader.mckinsey()];
    //TODO: Put this functionality on server
    /*
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifest = json.decode(manifestContent);
    final bookPaths =
        manifest.keys.where((String key) => key.endsWith('.book')).toList();

    for (int i = 0; i < bookPaths.length; i++) {
      // dev.log("Path: ${bookPaths[i]}");
      bookPaths[i] = bookPaths[i].split('/').last.replaceAll('.book', '');
    }

    List<BookLoader> books = [];
    for (String id in bookPaths) {
      if (id.isNotEmpty) {
        String extLess = id.replaceAll('.book', '');
        books.add(BookLoader(extLess));
      }
    }
    return books;
     */
  }

  void loadInOrder(
      List<BookLoader> books, void Function(String) afterEachLoaded) async {
    for (BookLoader loader in books) {
      if (hasBook(loader.id)) {
        afterEachLoaded(loader.id);
      } else {
        Book? b = await loader.load();
        if (b != null) {
          saveBook(b);
          afterEachLoaded(b.id);
        }
      }
    }
  }

  // static Library instance = Library.fixed();
  static Library? _instance;
  static Library getInstance() {
    _instance ??= Library();
    return _instance!;
  }
}
