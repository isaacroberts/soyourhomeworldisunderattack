import 'package:flutter/material.dart';

class EmptyChapterWidget extends StatelessWidget {
  const EmptyChapterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        Text("No chapter :("),
        CircularProgressIndicator(),
        Icon(
          Icons.hourglass_empty,
          size: 100,
          color: Colors.white,
        )
      ],
    ));
  }
}
