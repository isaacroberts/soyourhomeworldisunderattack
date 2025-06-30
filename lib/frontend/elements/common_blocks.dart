import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/colors.dart';

import '../base_text_theme.dart';
import '../icons.dart';
import '../styles.dart';

Widget blankHeader(BuildContext context) {
  return const Text('...', style: headerFont);
}

class ColoredIconCard extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final String? extra;
  final Color? color;
  // final String? goLink;

  final VoidCallback? onClick;

  const ColoredIconCard(
      {super.key, this.icon, this.text, this.color, this.extra, this.onClick});

  @override
  Widget build(BuildContext context) {
    if (onClick != null) {
      return _coloredCard(MaterialButton(onPressed: onClick, child: _stack()));
    } else {
      return _coloredCard(_stack());
    }
  }

  Container _coloredCard(Widget child) {
    return Container(
        height: 400,
        alignment: Alignment.center,
        color: color ?? canvasColor,
        child: child);
  }

  Widget _stack() {
    String? text = this.text;
    String? extra = this.extra;
    // dev.log("> ColoredIconCard: Text $text extra $extra");
    if ((text == null) && (extra == null)) {
      return Center(child: StdIcon(icon: icon));
    } else if ((text != null) && (extra != null)) {
      //With column
      return Stack(
        alignment: Alignment.center,
        children: [
          StdIcon(icon: icon),
          Column(children: [
            Text(
              text,
              style: bodyFont,
            ),
            const SizedBox(height: 15),
            Text(
              extra,
              style: bodyFont,
            )
          ])
        ],
      );
    }
    //No column needed
    else if ((text == null) || (extra == null)) {
      return Stack(alignment: Alignment.center, children: [
        StdIcon(icon: icon),
        if (text != null)
          Text(
            text,
            style: bodyFont,
          ),
        if (extra != null)
          Text(
            extra,
            style: bodyFont,
          )
      ]);
    } else {
      return const Text("I don't know how boolean logic works");
    }
  }
}

class StdIcon extends StatelessWidget {
  const StdIcon({
    super.key,
    required this.icon,
  });

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 200, color: Colors.black45);
  }
}

class ComingSoon extends StatelessWidget {
  final String? whatsComing;
  const ComingSoon({super.key, this.whatsComing});

  @override
  Widget build(BuildContext context) {
    return ColoredIconCard(
        icon: RpgAwesome.spinning_sword,
        color: harveyDarkColor,
        text: "Coming' Soon!",
        extra: whatsComing);
  }
}
