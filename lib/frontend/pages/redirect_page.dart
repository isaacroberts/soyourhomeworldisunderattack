import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/pages/loading_page.dart';

class RedirectPage extends StatefulWidget {
  final String redirectTo;
  const RedirectPage({super.key, required this.redirectTo});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  bool hasRedirected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hasRedirected = false;
    Future.delayed(const Duration(seconds: 1), redirect);
  }

  void redirect() {
    if (mounted) {
      dev.log("RDR: ${widget.redirectTo}");
      context.go(widget.redirectTo);
      hasRedirected = true;
    } else {
      dev.log("RDR Not mounted");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasRedirected) {
      return LoadingPage(message: 'Redirecting to ${widget.redirectTo}...');
    } else {
      return TextButton(onPressed: redirect, child: Text(widget.redirectTo));
    }
  }
}
