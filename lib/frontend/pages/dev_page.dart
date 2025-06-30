// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/ad_list.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/andy_thumbnail.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/greenland_game.dart';

class DevPage extends StatelessWidget {
  final GoRouterState routerState;
  const DevPage({super.key, required this.routerState});

  @override
  Widget build(BuildContext context) {
    if (routerState.pathParameters.isNotEmpty) {}

    return const AndyThumbnailHolder(spans: []).element(context);
    return const GreenlandGamePage();
    return const AdList();
  }
}
