import 'dart:developer' as dev;


import 'binary_unpacker.dart';

Future<void> main()  async {
print('Hello???');
print('Hello??');
  ChapterLoader chapter = ChapterLoader('../assets/bin/part_2_ThanktheBu.bin');

  await chapter.load();

  print('Apparently loaded');

}
