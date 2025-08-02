import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  void startReview(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'review',
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Leave a review!'),
                          const SizedBox(height: 12),
                          FilledButton(
                            child: const Text('Start'),
                            onPressed: () => startReview(context),
                          )
                        ])))
          ],
        )));
  }
}
