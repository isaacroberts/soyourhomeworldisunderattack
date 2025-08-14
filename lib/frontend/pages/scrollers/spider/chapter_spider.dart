import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/spider_utils.dart';

import '../../../../backend/book.dart';
import '../../../../backend/chapter_holder.dart';
import '../../../../backend/chapter_info.dart';

const String spiderSign = '::]';

class ChapterSpider with ChangeNotifier {
  // static ChapterSpider instance = ChapterSpider();

  final Book book;

  ChapterHolder? previous;
  ChapterHolder? current;
  ChapterHolder? next;

  double? previousHeight;
  double? currentHeight;
  double? nextHeight;

  int currentIndex = 0;

  int currentChapterMinimum = 0;

  int get chapterMax => book.chapterAmt;

  late final Timer _timer;

  ChapterSpider({required this.book, ChapterKey startChp = 0}) {
    _timer = Timer.periodic(const Duration(milliseconds: 60), _pollLoading);
    initFirst(startChp);
  }

  void initFirst(ChapterKey startChp) async {
    current = book.chapters[startChp];
    // current = Chapter.fascistFactory(startChp);
    // next = Chapter.factory(1);
    notifyListeners();
    await current?.load();
    notifyListeners();
  }

  //Tools for layout functions

  void reportHeight(SpiderPos pos, double height) {
    if (pos == SpiderPos.previous) {
      previousHeight = height;
    } else if (pos == SpiderPos.current) {
      currentHeight = height;
    } else if (pos == SpiderPos.next) {
      nextHeight = height;
    } else {
      throw Exception('Height of SpiderPos.dead was reported to ChapterSpider');
    }
  }

  Future<bool> goUp() async {
    //Go up/previous/-
    if (currentIndex <= currentChapterMinimum) {
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

  Future<bool> goDown() async {
    //Go down/next/+
    if (currentIndex >= chapterMax - 1) {
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

  void _fetchCurrent() {
    current = book.chapters[currentIndex];
  }

  void _fetchNext() {
    //Change Chapter.factory to give it weird paths
    //TODO: book.getNextChapter
    next = book.chapters[currentIndex + 1];
  }

  void _fetchPrevious() {
    if (currentIndex > 0) {
      //Change Chapter.factory to give it weird paths
      //TODO: book.getPreviousChapter
      previous = book.chapters[currentIndex - 1];
    } else {
      previous = null;
    }
  }

  void _currentChapterLoaded(_) {
    notifyListeners();
  }

  void _nextChapterLoaded(_) {
    notifyListeners();
  }

  void _previousChapterLoaded(_) {
    notifyListeners();
  }

  void _pollLoading(timer) async {
    //Check current chapter
    ChapterHolder? current = this.current;
    if (current == null) {
      dev.log("$spiderSign Fetch chapter $currentIndex");
      // TODO: Decide behavior
      _fetchCurrent();
    } else if (current.needsLoad) {
      //Load current chapter
      dev.log('$spiderSign Current load $currentIndex');
      current.load().then(_currentChapterLoaded);
    } else if (current.loading) {
      //Wait for current to load
      dev.log("$spiderSign Waiting on current");
      return;
    } else {
      //If all done, Check next chapter
      //Store next for async
      ChapterHolder? next = this.next;
      //Get next chapter
      if (next == null) {
        dev.log("$spiderSign Fetch next");
        _fetchNext();
      } else if (next.needsLoad) {
        dev.log('$spiderSign Load next');
        next.load().then(_nextChapterLoaded);
      } else if (next.loading) {
        dev.log("$spiderSign Waiting on next");

        return;
      } else {
        //If all done, check previous chapters
        //Store for async
        ChapterHolder? previous = this.previous;
        //Get previous chapter
        if (previous == null) {
          dev.log("$spiderSign Fetch previous");
          _fetchPrevious();
        } else if (previous.needsLoad) {
          dev.log("$spiderSign Load previous");
          previous.load().then(_previousChapterLoaded);
        } else if (previous.loading) {
          dev.log("$spiderSign Waiting on previous");
        } else {
          dev.log('$spiderSign done');
        }
      }
    }
  }
}
