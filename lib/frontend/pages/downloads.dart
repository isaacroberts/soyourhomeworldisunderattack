import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

import '../elements/common_blocks.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  Widget build(BuildContext context) {
    return const McScaffold(source: 'download', child: DownloadWidget());
  }
}

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({super.key});

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  void _clickDownloadScript() {
    context.go('/book.odt/');
  }

  void _clickDownloadWebsite() {
    Navigator.push(context,
        MaterialPageRoute(builder: (c) => const DownloadWebsitePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListView(
      children: [
        ListTile(
          title: const Text('Script'),
          onTap: _clickDownloadScript,
        ),
        ListTile(
          title: const Text("Website"),
          onTap: _clickDownloadWebsite,
        ),
      ],
    ));
  }
}

class DownloadWebsitePage extends StatelessWidget {
  const DownloadWebsitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const McScaffold(source: 'download', child: DownloadWebsiteWidget());
  }
}

class DownloadWebsiteWidget extends StatelessWidget {
  const DownloadWebsiteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(children: [
      Text("I don't know how to do this."),
      // Text("Here's the directory listing"),
      ComingSoon(),
    ]));
  }
}
