import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/colors.dart';
import '../../theme/text_theme.dart';
import '../holders/holder_base.dart';

const List<String> _candidates = [
  'Human Jack',
  'Anarchist Affinity Group (Christian Jones, Eric Green, Sophie Lichterman, Devonte Washington, Vashra Bhattacharyal, Tristen Pensicola)',
  'Bugs Bunny',
  'Grok AI',
  'Pot Hol',
];
const List<String> _candidateLinks = [
  'HumanJack',
  'AnarchistsWin',
  'TransgenderRabbit',
  'AIWinsElection',
  'PotHol',
];

class BallotHolder extends Holder {
  final bool isExtended;
  final bool enabled;
  // final List<String> links;
  const BallotHolder({required this.isExtended, required this.enabled});

  @override
  Widget element(BuildContext context) {
    return BallotScreen(key: const Key("charSelect"), holder: this);
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }

  @override
  String toText() {
    return '[Ballot code element]';
  }
}

class BallotScreen extends StatefulWidget {
  final BallotHolder holder;
  const BallotScreen({super.key, required this.holder});

  @override
  State<BallotScreen> createState() => _BallotScreenState();
}

class _BallotScreenState extends State<BallotScreen> {
  String? value;

  void radioClicked(String? val) {
    setState(() {
      value = val;
    });
  }

  void submitted() {
    if (value != null) {
      int ix = _candidates.indexOf(value!);

      context.go('/search/${_candidateLinks[ix]}');
    }
  }

  Widget listTile(BuildContext context, int ix) {
    return RadioListTile(
        toggleable: true,
        selected: value == _candidates[ix],
        activeColor: const Color(0xffffffff),
        tileColor: canvasColor,
        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(_candidates[ix]),
        value: _candidates[ix],
        groupValue: value,
        onChanged: radioClicked);
  }

  Widget submitButton(BuildContext context) {
    return Padding(
        // to align with RadioButtons
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            onPressed:
                (widget.holder.enabled && value != null) ? submitted : null,
            child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Vote',
                  textAlign: TextAlign.left,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int n = 0;
        n < (widget.holder.isExtended ? _candidates.length : 2);
        n++) {
      widgets.add(listTile(context, n));
    }
    widgets.add(submitButton(context));

    return Theme(
        data: bookTheme,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ));
  }
}
