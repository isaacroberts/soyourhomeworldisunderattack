import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/ad_human_jacks.dart';

class AdListPage extends StatelessWidget {
  const AdListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const McScaffold(source: 'adlist', child: AdList());
  }
}

class AdList extends StatelessWidget {
  const AdList({super.key});

  Widget? itemBuilder(BuildContext context, int ix) {
    if (ix < HumanJackAdType.values.length) {
      return humanJackAdWidget(HumanJackAdType.values[ix]);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: itemBuilder);
  }
}
