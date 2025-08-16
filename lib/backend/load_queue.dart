import 'dart:async';
import 'dart:developer' as dev;

import 'package:async/async.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';

import 'chapter.dart';
import 'chapter_data.dart';
import 'chapter_info.dart';

class ChapterLoadQueue {
  static ChapterLoadQueue? _instance;

  static ChapterLoadQueue get instance {
    // if (_instance == null) {
    //   _instance = ChapterLoadQueue();
    //   _instance!.initState();
    // }
    return _instance!;
  }

  late final Timer timer;
  static void initState() {
    _instance = ChapterLoadQueue();
    _instance!._initState();
  }

  void _initState() {
    timer = Timer.periodic(const Duration(milliseconds: 30), _loadThread);
  }

  final List<_QueueWrap> _requestedLoads = [];
  _QueueWrap? _currentlyLoading;

  CancelableOperation<ChapterAndStream> requestLoad(Chapter chapter) {
    int ixMatch = _requestedLoads.indexWhere((q) => q.matches(chapter));

    if (ixMatch == -1) {
      dev.log("Queue: + ${chapter.varName}");
      _QueueWrap q = _QueueWrap(chapter: chapter);
      _requestedLoads.add(q);
      return q.completer.operation;
    } else {
      int ix = _requestedLoads.indexWhere((q) => q.matches(chapter));
      return _requestedLoads[ix].completer.operation;
    }
  }

  CancelableOperation<ChapterAndStream> requestUrgentLoad(Chapter chapter) {
    int ixMatch = _requestedLoads.indexWhere((q) => q.matches(chapter));

    if (ixMatch == -1) {
      dev.log("Queue: + ${chapter.varName}");
      _QueueWrap q = _QueueWrap(chapter: chapter);
      _requestedLoads.insert(0, q);
      return q.completer.operation;
    } else {
      int ix = _requestedLoads.indexWhere((q) => q.matches(chapter));
      return _requestedLoads[ix].completer.operation;
    }
  }

  void cancelLoad(Chapter chapter) {
    if (_currentlyLoading?.matches(chapter) ?? false) {
      //Cancel load thread
      _currentlyLoading?.completer.operation.cancel();
    }
    int ixMatch = _requestedLoads.indexWhere((q) => q.matches(chapter));
    if (ixMatch != -1) {
      dev.log("Queue: - ${chapter.varName}");
      _requestedLoads.removeAt(ixMatch);
    }
  }

  void _loadThread(Timer t) {
    //If not currently laoding
    if (_currentlyLoading == null) {
      if (_requestedLoads.isNotEmpty) {
        //If needs a load
        _currentlyLoading = _requestedLoads.removeAt(0);
        dev.log("Queue: loading ${_currentlyLoading?.chapter.varName}");
        _currentlyLoading
            ?.load()
            .then(_loadCompleted, onCancel: loadCancelled, onError: loadError);
      }
    }
  }

  void _loadCompleted(ChapterAndStream s) {
    dev.log("Queue: Done ${s.$1.varName}");
    bool matches = s.$1.id == _currentlyLoading?.id;
    if (matches) {
      // _currentlyLoading?.completer.complete(s);
      _currentlyLoading = null;
    } else {
      ErrorList.logWarning('load was completed that did not match current');
    }
  }

  void loadCancelled() {
    _currentlyLoading = null;
  }

  void loadError(exception, trace) {
    ErrorList.showError(exception, trace);
    _currentlyLoading = null;
  }
}

class _QueueWrap {
  final Chapter chapter;
  final CancelableCompleter<ChapterAndStream> completer;

  _QueueWrap({required this.chapter})
      : completer = CancelableCompleter<ChapterAndStream>();

  @override
  int get hashCode => chapter.id;

  CancelableOperation<ChapterAndStream> load() {
    completer.complete(chapter.load());
    return completer.operation;
  }

  @override
  bool operator ==(Object other) {
    if (other is _QueueWrap) {
      return chapter.id == other.chapter.id;
    } else {
      return false;
    }
  }

  int get id => chapter.id;
  String get varName => chapter.varName;

  bool matches(Object other) {
    if (other is _QueueWrap) {
      return chapter.id == other.chapter.id;
    } else if (other is Chapter) {
      return chapter.id == other.id;
    } else if (other is ChapterData) {
      return chapter.id == other.id;
    } else if (other is ChapterInfo) {
      return chapter.id == other.id;
    } else {
      return false;
    }
  }
}
