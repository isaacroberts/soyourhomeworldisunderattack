import 'dart:developer' as dev;

import 'case_insensitive_equality.dart';
import 'chapter.dart';

bool chapterMatchesSearchTerm(Chapter chapter, String searchTerm,
    {bool permissive = true, bool desperate = false}) {
  if (chapterMatchesSearchTermDirect(chapter, searchTerm)) {
    return true;
  }
  assert(!desperate || permissive, "Desperation implies permissivity");
  if (permissive) {
    if (chapterMatchesSearchTermPermissive(chapter, searchTerm)) {
      return true;
    }
  }
  if (desperate) {
    if (chapterMatchesSearchTermDesperate(chapter, searchTerm)) {
      return true;
    }
  }
  return false;
}

bool chapterMatchesSearchTermDirect(Chapter chapter, String searchTerm) {
  if (equalsIgnoreAsciiCase(chapter.varName, searchTerm)) {
    //return 100%
    return true;
  }
  return false;
}

bool chapterMatchesSearchTermPermissive(Chapter chapter, String searchTerm) {
  ///Assume matchesSearchTermDirect was already called
  //TODO: A ranking might be smarter

  if (equalsIgnoreAsciiCase(chapter.displayName, searchTerm)) {
    //return 90%
    return true;
  }
  String? headerText = chapter.data?.header?.text;
  if (headerText != null && headerText.isNotEmpty) {
    if (equalsIgnoreAsciiCase(headerText, searchTerm)) {
      return true;
    }
  }
  return false;
}

bool chapterMatchesSearchTermDesperate(Chapter chapter, String searchTerm) {
  String displayName = chapter.displayName.toLowerCase();
  String varName = chapter.varName.toLowerCase();

  if (displayName.contains(searchTerm)) {
    //Return match %
    return true;
  }
  if (searchTerm.contains(displayName)) {
    return true;
  }
  if (varName.contains(searchTerm)) {
    return true;
  }
  if (searchTerm.contains(varName)) {
    return true;
  }
  String? headerText = chapter.data?.header?.text;
  headerText = headerText?.toLowerCase();
  if (headerText != null && headerText.isNotEmpty) {
    if (headerText.contains(searchTerm)) {
      return true;
    }
    if (searchTerm.contains(headerText)) {
      return true;
    }
  }

  return false;
}

void printChapterSearchTerms(Chapter chapter, String missedTerm) {
  dev.log('=/= "$missedTerm"');
  dev.log('"${chapter.varName}"');
  dev.log('"${chapter.displayName}"');
  String? headerText = chapter.data?.header?.text;
  dev.log(headerText ?? 'null');
}
