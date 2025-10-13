import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/frontend/parts/grand_swatch.dart';

import '../../icons.dart';
import '../../theme/timings.dart';

class LoadNextFillRemaining extends StatelessWidget {
  final VoidCallback onRequestMore;
  const LoadNextFillRemaining({
    required super.key,
    required this.onRequestMore,
  });

  @override
  Widget build(BuildContext context) {
    GrandSwatch primary = GrandSwatch.primaryOf(context);

    return SliverToBoxAdapter(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            //Large so that user can keep scrolling, triggering another notification
            height: 200,
            color: primary.s3,
            alignment: Alignment.center,
            child: Column(
                key: const Key("fillRemCol"),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Continue"),
                  IconButton(
                    onPressed: onRequestMore,
                    icon: Icon(
                      key: const Key("fillRmIcon"),
                      Icons.more_vert_rounded,
                      color: primary.sa,
                      size: 48,
                    ),
                  ),
                  const Text("Scroll to scroll"),
                ])));
  }
}

class EndOfBookFillRemaining extends StatelessWidget {
  const EndOfBookFillRemaining({
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Expand text from center
    GrandSwatch primary = GrandSwatch.primaryOf(context);

    return SliverToBoxAdapter(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            height: 200,
            color: primary.s3,
            alignment: Alignment.center,
            child: Column(
                key: const Key("fillRemCol"),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    key: const Key("fillRmIcon"),
                    RpgAwesome.fedora,
                    color: primary.sa,
                    size: 48,
                  ),
                  const Text('Heh, thanks for reading.'),
                  // const Text('You have Helped your Homeworld'),
                  const Text("Why not share on social media?"),
                  TextButton(
                      onPressed: () => copyText(context, shareURL),
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(1, 5)),
                      ),
                      child: Text(
                        serverDisplayURL,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(decoration: TextDecoration.underline),
                      ))
                ])));
  }
}
