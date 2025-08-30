import '../../../../backend/utils.dart';

class DoingBestTextController {
  static const String defaultText = 'Abcdefghijklmnopqrstuvwxyz.!?';
  String _text;
  String _targetText;
  DoingBestTextController({required String? text})
      : _targetText = text ?? defaultText,
        _text = text ?? defaultText;

  String get text => _text;
  set text(String? set) {
    _targetText = set ?? defaultText;
  }

  bool get matches => _text == _targetText;
  bool get notMatching => _text != _targetText;

  @override
  String toString() {
    return ("(DoingBestText: '$_text'->'$_targetText')");
  }

  void update() {
    if (matches) {
      return;
    }
    if (tryLowers()) {
      return;
    }
    if (text.length < _targetText.length) {
      if (!tryAddChar()) {
        mutateChar();
      }
      return;
    } else if (_text.length > _targetText.length) {
      // _text = _text.substring(1);
      dropChar();
    } else {
      mutateChar();
    }
    return;
    if (_targetText.length > _text.length && tryAddChar()) {
      // addChar();
      // } else if (tryDropChar()) {
      //   } else if (_targetText.length > _text.length) {
      //     addChar();
    } else if (_targetText.length < _text.length) {
      if (!tryDropChar()) {
        mutateChar();
      }
    } else {
      mutateChar();
    }
  }

  bool tryLowers() {
    for (int n = 0; n < _targetText.length && n < _text.length; ++n) {
      if (_text[n] != _targetText[n]) {
        if (_text[n].toLowerCase() == _targetText[n].toLowerCase()) {
          _text =
              _text.substring(0, n) + _targetText[n] + _text.substring(n + 1);
          return true;
        }
      }
    }
    return false;
  }

  bool tryAddChar() {
    for (int n = 0; n < _targetText.length; ++n) {
      if (!_text.contains(_targetText[n])) {
        int putAt = n + missDelta;
        if (putAt > 0 && putAt < _text.length) {
          _text = _text.substring(0, putAt) +
              _targetText[n] +
              _text.substring(putAt);
        } else {
          // _text = _targetText[n] + _text;
          _text = _text + _targetText[n];
        }
        return true;
      }
    }
    return false;
  }

  bool tryDropChar() {
    int start = rNG.nextInt(3);
    int end = rNG.nextInt(_text.length);
    for (int n = start; n < end; ++n) {
      if (!_targetText.contains(_text[n])) {
        _text = _text.substring(0, n) + _text.substring(n + 1);
        return true;
      }
    }
    return false;
  }

  int get missDelta {
    return 0;
    double rand = rNG.nextDouble() - .5;
    // double delta = math.exp(.2 * rand * rand);
    // return delta.round();
    return (rand * 3).round();
  }

  void addChar() {
    for (int n = 0; n < _targetText.length; ++n) {
      if (!_text.contains(_targetText[n])) {
        // if (n < text.length) {
        //   _text = _text.substring(0, n) + _targetText[n] + _text.substring(n);
        // } else {
        _text = _text + _targetText[n];
        // }
        return;
      }
    }
    int randAdd = rNG.nextInt(_targetText.length);
    _text = _text + _targetText[randAdd];
  }

  void dropChar() {
    for (int n = 0; n < _text.length; ++n) {
      if (_targetText.contains(_text[n])) {
        _text = _text.substring(0, n) + _text.substring(n + 1);
        return;
      }
    }
    int randDrop = rNG.nextInt(_text.length);
    _text = _text.substring(0, randDrop) + _text.substring(randDrop + 1);
  }

  void mutateChar() {
    // for (int iStart = 0; iStart < _text.length; ++iStart)
    {
      int iStart = rNG.nextInt(_text.codeUnits.length);
      int targ = iStart + missDelta;
      if (targ < 0) {
        // return;
      } else if (targ >= _targetText.length) {
        // _text = _text.substring(0, _text.length - 1);
        // return;
      } else if (_targetText[targ] != _text[iStart]) {
        _text = _text.substring(0, iStart) +
            _targetText[targ] +
            _text.substring(iStart + 1);
        return;
      }
    }
  }
}

class FunctioningTextController {
  ///So you can turn them off without refactoring
  String _text;
  FunctioningTextController({required String? text}) : _text = text ?? '';
  String get text => _text;
  set text(String? set) {
    _text = set ?? '';
  }

  void update() {}
  bool get matches => true;
  bool get notMatching => false;
}
