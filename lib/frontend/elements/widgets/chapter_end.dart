import 'package:flutter/material.dart';

import '../../icons.dart';

class ChapterEnd extends StatelessWidget {
  const ChapterEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 25, bottom: 100),
        child: Center(
          child: Icon(
            RpgAwesome.burning_meteor,
            size: 50,
            color: Color(0x77ffffff),
          ),
        ));
  }
}
