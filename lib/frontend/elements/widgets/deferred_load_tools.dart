import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/pages/loading_page.dart';

import '../../../backend/error_handler.dart';

class DeferredPage extends StatelessWidget {
  final Future Function() loader;
  final Widget Function(BuildContext) builder;

  const DeferredPage(
      {required super.key, required this.loader, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: loader(), builder: futureBuilder);
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot libSnapshot) {
    if (libSnapshot.hasError) {
      ErrorList.logError(libSnapshot.error!, libSnapshot.stackTrace);
      return ErrorList.page(context);
    } else if (libSnapshot.connectionState == ConnectionState.done) {
      return builder(context);
    } else {
      return const LoadingPage(key: Key("LoadPage"), message: 'Loading lib...');
    }
  }
}

class DeferredWidget extends StatelessWidget {
  final Future Function() loader;
  final Widget Function(BuildContext) builder;

  const DeferredWidget(
      {super.key, required this.loader, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: loader(), builder: futureBuilder);
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot libSnapshot) {
    if (libSnapshot.hasError) {
      ErrorList.logError(libSnapshot.error!, libSnapshot.stackTrace);
      return ErrorList.page(context);
    } else if (libSnapshot.connectionState == ConnectionState.done) {
      return builder(context);
    } else {
      return const Center(
          child: TriWizardLoader(
        message: 'Loading lib',
      ));
    }
  }
}

class DeferredSliver extends StatelessWidget {
  final double height;
  final Future Function() loader;
  final Widget Function(BuildContext) builder;

  const DeferredSliver(
      {super.key,
      required this.loader,
      required this.builder,
      this.height = 400});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: loader(), builder: futureBuilder);
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot libSnapshot) {
    if (libSnapshot.hasError) {
      ErrorList.logError(libSnapshot.error!, libSnapshot.stackTrace);
      return ErrorList.page(context);
    } else if (libSnapshot.connectionState == ConnectionState.done) {
      return builder(context);
    } else {
      return SliverToBoxAdapter(
          child: SizedBox(
              height: height,
              child: const Center(
                  child: TriWizardLoader(
                message: 'Loading lib',
              ))));
    }
  }
}
