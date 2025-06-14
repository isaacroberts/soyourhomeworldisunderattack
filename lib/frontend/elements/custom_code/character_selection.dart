import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../styles.dart';
import '../holders/textholders.dart';

const List<String> _classes = [
  'Barbarian',
  'Cleric',
  'Rogue',
  'Bard',
];
const List<String> _classLinks = [
  'CallAhead',
  'NickGreenland',
  'Noir',
  'Bard',
];

const List<String> _classDescriptions = [
  "You rush headlong into danger. You fear not for your own safety, but prefer to meet challenges head on.",
  "You go with God in all things.",
  "You prefer to hang back, investigating a problem before engaging.",
  "You like music.",
];

class CharacterSelectionHolder extends Holder {
  @override
  Widget element(BuildContext context) {
    return const CharacterSelection(key: Key("charSelect"));
  }

  @override
  Widget fallback(BuildContext context) {
    return element(context);
  }
}

class CharacterSelection extends StatefulWidget {
  // final List<String> links;
  const CharacterSelection({super.key});

  @override
  State<CharacterSelection> createState() => _CharacterSelectionState();
}

class _CharacterSelectionState extends State<CharacterSelection> {
  String? value;

  void radioClicked(String? val) {
    setState(() {
      value = val;
    });
  }

  void submitted() {
    if (value != null) {
      int ix = _classes.indexOf(value!);

      context.go('/search/${_classLinks[ix]}');
    }
  }

  Widget listTile(BuildContext context, int ix) {
    return RadioListTile(
        toggleable: true,
        selected: value == _classes[ix],
        activeColor: const Color(0xffffffff),
        tileColor: canvasColor,
        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(_classes[ix]),
        subtitle: Text(_classDescriptions[ix]),
        value: _classes[ix],
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
            onPressed: value == null ? null : submitted,
            child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Continue',
                  textAlign: TextAlign.left,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: bookTheme,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            listTile(context, 0),
            listTile(context, 1),
            listTile(context, 2),
            listTile(context, 3),

            // const SizedBox(
            //   height: 15,
            // ),
            submitButton(context),
          ],
        ));
  }
}
