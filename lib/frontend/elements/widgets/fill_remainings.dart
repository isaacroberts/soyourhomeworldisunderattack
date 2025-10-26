import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/server.dart';

import '../../icons.dart';
import '../../parts/part.dart';
import '../../theme/timings.dart';

class LoadNextFillRemaining extends StatelessWidget {
  final VoidCallback onRequestMore;
  final Part part;
  const LoadNextFillRemaining({
    required super.key,
    required this.onRequestMore,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            //Large so that user can keep scrolling, triggering another notification
            height: 200,
            color: part.primary.s3,
            alignment: Alignment.center,
            child: Column(
                key: const Key("fillRemCol"),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TODO: Text style
                  const Text("Continue"),
                  IconButton(
                    onPressed: onRequestMore,
                    icon: Icon(
                      key: const Key("fillRmIcon"),
                      Icons.more_vert_rounded,
                      color: part.primary.sa,
                      size: 48,
                    ),
                  ),
                  const Text("Click or scroll"),
                ])));
  }
}

class EndOfBookFillRemaining extends StatelessWidget {
  const EndOfBookFillRemaining({
    required super.key,
    required this.part,
  });

  final Part part;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        key: const Key("FillRemaining"),
        child: Container(
            key: const Key("fillRemCt"),
            height: 200,
            color: part.primary.s3,
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
                    color: part.primary.sa,
                    size: 48,
                  ),
                  //TODO: Text style (appFont)
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
