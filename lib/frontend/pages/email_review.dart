import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold_with_scroll.dart';

import '../parts/noir_colors.dart';

class EmailReviewPage extends StatefulWidget {
  const EmailReviewPage({super.key});

  @override
  State<EmailReviewPage> createState() => _EmailReviewPageState();
}

class _EmailReviewPageState extends State<EmailReviewPage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ScaffoldWithScroll(
        source: 'comment',
        body: Column(
          children: [
            Text(
              'Leave a comment',
              style: textTheme.titleLarge,
            ),
            const Text('Complete a quick puzzlerooni'),
            Puzzlerooni(
              key: const Key('puzzle'),
              onComplete: onPuzzleCompleted,
            )
          ],
        ));
  }

  void onPuzzleCompleted() {}
}

class Puzzlerooni extends StatefulWidget {
  final VoidCallback onComplete;
  const Puzzlerooni({super.key, required this.onComplete});

  @override
  State<Puzzlerooni> createState() => _PuzzlerooniState();
}

class _PuzzlerooniState extends State<Puzzlerooni> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 600,
      color: NoirPrimary.shade7,
      child: grid(context),
    );
  }

  Widget grid(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 50),
        itemBuilder: gridItem);
  }

  Widget gridItem(BuildContext context, int index) {
    return AspectRatio(
        aspectRatio: 1,
        child: FilledButton(
            onPressed: () {}, child: Text((index + 1).toString())));
  }
}
