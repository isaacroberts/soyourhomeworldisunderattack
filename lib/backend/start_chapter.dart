import 'book.dart';
import 'chapter.dart';

///Convenience classes for moving tree out of scroller
const defaultStartChapter = NoStartChapter();

abstract class StartChapter {
  const StartChapter();
  Future<Chapter?> getStart(Book book);
}

class SearchedStartChapter extends StartChapter {
  final String term;
  const SearchedStartChapter(this.term);
  @override
  Future<Chapter?> getStart(Book book) async {
    return book.findChapterBySearchTerm(term);
  }
}

class IntStartChapter extends StartChapter {
  final int id;
  const IntStartChapter(this.id);
  @override
  Future<Chapter?> getStart(Book book) async {
    return book.chapters[id];
  }
}

class NoStartChapter extends StartChapter {
  const NoStartChapter();
  @override
  Future<Chapter?> getStart(Book book) async {
    //TODO: Check cache for last chapter read

    return book.chapters[0];
  }
}
