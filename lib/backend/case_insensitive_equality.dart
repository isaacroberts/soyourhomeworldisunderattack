// Character constants.
// const int _zero = 0x30;
// const int _upperCaseA = 0x41;
// const int _upperCaseZ = 0x5a;
const int _lowerCaseA = 0x61;
const int _lowerCaseZ = 0x7a;
const int _asciiCaseBit = 0x20;

bool equalsIgnoreAsciiCase(String a, String b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    var aChar = a.codeUnitAt(i);
    var bChar = b.codeUnitAt(i);
    if (aChar == bChar) continue;
    // Quick-check for whether this may be different cases of the same letter.
    if (aChar ^ bChar != _asciiCaseBit) return false;
    // If it's possible, then check if either character is actually an ASCII
    // letter.
    var aCharLowerCase = aChar | _asciiCaseBit;
    if (_lowerCaseA <= aCharLowerCase && aCharLowerCase <= _lowerCaseZ) {
      continue;
    }
    return false;
  }
  return true;
}

bool startMatchesIgnoreAsciiCase(String a, String b) {
  /// Doesn't care which starts with which
  if (a.isEmpty || b.isEmpty) {
    return false;
  }
  for (var i = 0; i < a.length && i < b.length; i++) {
    var aChar = a.codeUnitAt(i);
    var bChar = b.codeUnitAt(i);
    if (aChar == bChar) continue;
    // Quick-check for whether this may be different cases of the same letter.
    if (aChar ^ bChar != _asciiCaseBit) return false;
    // If it's possible, then check if either character is actually an ASCII
    // letter.
    var aCharLowerCase = aChar | _asciiCaseBit;
    if (_lowerCaseA <= aCharLowerCase && aCharLowerCase <= _lowerCaseZ) {
      continue;
    }
    return false;
  }
  return true;
}

bool endMatchesIgnoreAsciiCase(String a, String b) {
  /// Doesn't care which ends with which
  if (a.isEmpty || b.isEmpty) {
    return false;
  }
  for (var reverseIx = 0;
      reverseIx < a.length && reverseIx < b.length;
      reverseIx++) {
    var aChar = a.codeUnitAt(a.length - reverseIx);
    var bChar = b.codeUnitAt(b.length - reverseIx);
    if (aChar == bChar) continue;
    // Quick-check for whether this may be different cases of the same letter.
    if (aChar ^ bChar != _asciiCaseBit) return false;
    // If it's possible, then check if either character is actually an ASCII
    // letter.
    var aCharLowerCase = aChar | _asciiCaseBit;
    if (_lowerCaseA <= aCharLowerCase && aCharLowerCase <= _lowerCaseZ) {
      continue;
    }
    return false;
  }
  return true;
}
