import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../../base_text_theme.dart';
import '../holders/span_holding_code.dart';

class QuicktimeEvent extends SpanHoldingCode {
  final String press;
  final String tooSlow;
  final Color buttonColor;

  //5 sizes, with 5 as the largest. Currently all buttons are rendered as size 5.
  final int size;

  static QuicktimeEvent unpack(List<TextHolder> spans) {
    String text = 'Press!';
    String tooSlow = 'Too Slow!';
    return QuicktimeEvent(
        spans: spans,
        buttonColor: Colors.green,
        size: 5,
        press: text,
        tooSlow: tooSlow);
  }

  const QuicktimeEvent(
      {required super.spans,
      required this.buttonColor,
      this.size = 5,
      required this.press,
      required this.tooSlow});

  @override
  Widget element(BuildContext context) {
    return QuicktimeEventWidget(holder: this);
  }
}

class QuicktimeEventWidget extends StatefulWidget {
  final QuicktimeEvent holder;

  const QuicktimeEventWidget({super.key, required this.holder});

  @override
  State<QuicktimeEventWidget> createState() => _QuicktimeEventWidgetState();
}

class _QuicktimeEventWidgetState extends State<QuicktimeEventWidget> {
  late final Timer _timer;

  int secondsRemaining = 0;
  bool canPress = true;

  @override
  void initState() {
    canPress = true;

    secondsRemaining = 31;

    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
  }

  void _timerCallback(timer) {
    if (secondsRemaining > 0) {
      setState(() {
        secondsRemaining -= 1;
      });
    } else {
      setState(() {
        canPress = false;
      });
    }
  }

  Widget timerCountdown(BuildContext context) {
    return Center(
        child: Text(
      secondsRemaining.toString(),
      style: bodyFont.copyWith(
          fontSize: 36, fontWeight: FontWeight.w800, color: canvasColor),
    ));
  }

  Widget textButton(BuildContext context) {
    return TextButton(
        key: const Key('QTE_Tb'),
        onPressed: _click,
        child: Text(widget.holder.press,
            style:
                bodyFont.copyWith(fontWeight: FontWeight.w500, fontSize: 24)));
  }

  Color greyedOut(Color lightVers) {
    double l = lightVers.computeLuminance();
    int il = (l * 255).round();
    return Color.fromARGB(255, il, il, il);
  }

  Widget wrappedTextButton(BuildContext context) {
    Color color = widget.holder.buttonColor;
    return Container(
        color: canPress ? color : greyedOut(color),
        child: FractionallySizedBox(
            widthFactor: 1,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 48 + 15),
                child: Column(children: [
                  timerCountdown(context),
                  // Would love this to be tied to the height of the button
                  const SizedBox(
                    height: 48,
                  ),
                  textButton(context)
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int n = 0; n < widget.holder.spans.length; n++) {
      children.add(widget.holder.spans[n].element(context));
    }
    children.add(wrappedTextButton(context));
    return Column(
      children: children,
    );
  }

  void _click() {}
}
