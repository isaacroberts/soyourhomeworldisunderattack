import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'book.dart';
import 'chapter.dart';

//
// class SpiderBell extends Notifier {
//   @override
//   build() {
//     throw UnimplementedError();
//   }
//
// }

/*
    TODO: The GoRouter navigational parameter is a suggestion for the ChapterSpider.

    Maybe sometimes you haven't earned it.
     
 */

class ChapterSpider with ChangeNotifier {
  // static ChapterSpider instance = ChapterSpider();

  Book book;

  Chapter? previous;
  Chapter? current;
  Chapter? next;

  double? previousHeight;
  double? currentHeight;
  double? nextHeight;

  int currentIndex = 0;

  int currentChapterMinimum = 0;

  late final Timer _timer;

  ChapterSpider({required this.book, ChapterKey startChp = 0}) {
    _timer = Timer.periodic(const Duration(milliseconds: 60), _pollLoading);
    initFirst(startChp);
  }

  void initFirst(ChapterKey startChp) async {
    current = await book.getAndLoadChapter(startChp);
    notifyListeners();
  }

  bool canGoUp() {
    return true;
  }

  bool canGoDown() {
    return true;
  }

  bool goUp() {
    //Go up/back/-
    if (!canGoUp()) {
      return false;
    }
    _destroyPrevious();
    currentIndex--;
    previous = current;
    current = next;
    next = null;
    previousHeight = currentHeight;
    currentHeight = nextHeight;
    nextHeight = null;

    _fetchNext();
    //The spider needs to ring her bell.
    notifyListeners();
    //Return whether it can go up
    return true;
  }

  bool goDown() {
    //Go down/next/+
    if (!canGoDown()) {
      return false;
    }
    _destroyNext();
    currentIndex++;
    next = current;
    current = previous;
    previous = null;
    nextHeight = currentHeight;
    currentHeight = previousHeight;
    previousHeight = null;
    _fetchPrevious();
    //The spider needs to ring her bell.
    notifyListeners();
    //Returns whether it can go down
    return true;
  }

  void _destroyPrevious() {
    previous = null;
    previousHeight = null;
  }

  void _destroyNext() {
    next = null;
    nextHeight = null;
  }

  void _fetchCurrent() async {
    current = await book.getAndLoadChapter(currentIndex);
  }

  void _fetchNext() async {
    //Change Chapter.factory to give it weird paths
    //TODO: book.getNextChapter
    int? id = current?.nextId;
    if (id != null) {
      next = await book.getAndLoadChapter(id);
    }
  }

  void _fetchPrevious() async {
    if (currentIndex > 0) {
      previous = await book.getAndLoadChapter(currentIndex - 1);
    } else {
      previous = null;
    }
  }

  void _pollLoading(timer) {
    //Move this to an async function

    //Address current chapter
    Chapter? current = this.current;
    if (current == null) {
      // TODO: Decide behavior
      _fetchCurrent();
    } else if (current.notYetLoaded) {
      //Load current chapter
      dev.log('SPIDER BROKEN');
      // current.load().then(_currentChapterLoaded);
    } else if (current.loading) {
      //Wait for current to load
      return;
    } else {
      // dev.log('Check next');
      //Address next chapter
      Chapter? next = this.next;
      if (next == null) {
        _fetchNext();
      } else if (next.notYetLoaded) {
        dev.log('SPIDER BROKEN (next)');
        // next.load().then(_nextChapterLoaded);
      } else if (next.loading) {
        return;
      } else {
        //Address previous chapter
        Chapter? previous = this.previous;
        if (previous == null) {
          _fetchPrevious();
        } else if (previous.notYetLoaded) {
          dev.log('SPIDER BROKEN (prev)');
          // previous.load();
        }
      }
    }
  }
}
