import 'dart:developer' as dev;

import 'binary_unpacker.dart';

Future<void> main() async {
  dev.log('Hello???');
  dev.log('Hello??');
  ChapterLoader chapter = ChapterLoader('../assets/bin/part_2_ThanktheBu.bin');

  chapter.load();
}
