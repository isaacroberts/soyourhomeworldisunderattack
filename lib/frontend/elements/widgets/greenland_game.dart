import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

import '../../../backend/utils.dart';

class GreenlandGamePage extends StatelessWidget {
  const GreenlandGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const McScaffold(
        source: 'ticketstogreenland', child: GreenlandGame());
  }
}

class GreenlandGame extends StatefulWidget {
  const GreenlandGame({super.key});

  @override
  State<GreenlandGame> createState() => _GreenlandGameState();
}

const List<String> warnings = [
  "Imagine spinning a bottle to point at a random star in the sky.",
  "Like getting struck by lightning.",
  "Like picking your street number on excel.",
  "If you work hard, you can get there.",
  "It’s sort of down to politics who gets a ticket.",
  "Families and such.",
  "Did you buy one?",
  "What can you offer Peter Thiel?",
  'Which we are.'
];

class _GreenlandGameState extends State<GreenlandGame> {
  int curWarning = 0;
  bool won = false;

  @override
  void initState() {
    super.initState();
    won = false;
    curWarning = 0;
  }

  bool lastWarning() {
    return curWarning == warnings.length - 1;
  }

  void onHit() {
    setState(() {
      won = true;
    });
  }

  void onMissed() {
    setState(() {
      curWarning += 1;
    });
  }

  void goHome() {
    if (mounted) {
      context.go('/search/wontickets');
    }
  }

  void reset() {
    setState(() {
      curWarning = 0;
      won = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (won) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 48,
          ),
          const Text(
            'Only high IQ geniuses like us are getting to Greenland.',
            style: bodyFont,
          ),
          const SizedBox(
              height: 240,
              child: Text(
                "Here's your ticket",
                style: bodyFont,
              )),
          FilledButton.tonal(
            onPressed: goHome,
            child: const Text(
              "Take",
              style: bodyFont,
            ),
          ),
          FilledButton.tonal(
            onPressed: reset,
            child: const Text(
              "Reset",
              style: bodyFont,
            ),
          )
        ],
      ));
    }
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
            width: 600,
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                const Text(
                  'Only the lucky few will get a Greenland ticket.',
                  style: bodyFont,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "Odds:",
                  style: boldBodyFont,
                ),
                const SizedBox(
                  height: 24,
                ),
                ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 240),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          warnings[curWarning],
                          maxLines: 5,
                          style: bodyFont,
                        ))),
                const SizedBox(height: 12),
                SizedBox(
                    height: 400,
                    child: _SlotAndButton(
                        onMissed: onMissed,
                        onHit: onHit,
                        warningLevel: curWarning))
              ],
            ))));
  }
}

class _SlotAndButton extends StatefulWidget {
  final int warningLevel;
  final VoidCallback onMissed;
  final VoidCallback onHit;
  const _SlotAndButton(
      {super.key,
      required this.onMissed,
      required this.onHit,
      required this.warningLevel});

  @override
  State<_SlotAndButton> createState() => _SlotAndButtonState();
}

class _SlotAndButtonState extends State<_SlotAndButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  bool rolling = false;
  bool goingToWin = false;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
    printOdds();
  }

  int get curWarning => widget.warningLevel;

  num getOdds() {
    int attemptsRemaining = warnings.length - curWarning - 2;
    num odds = math.pow(10, -(attemptsRemaining * attemptsRemaining) * .05);
    return odds;
  }

  void printOdds() {
    dev.log("Level: ${warnings.length - curWarning}");
    dev.log("Odds: ${getOdds()}");
  }

  void tryLuck() {
    if (mounted) {
      bool willWin = roll();
      dev.log("Odds: ${getOdds()}. win=$willWin");
      setState(() {
        goingToWin = willWin;
        rolling = true;
      });
      Future.delayed(const Duration(seconds: _SlotMachine.seconds), afterRoll);
    }
  }

  bool roll() {
    if (curWarning >= warnings.length - 1) {
      //The last should be 100%
      return true;
    }
    num odds = getOdds();
    return (RNG.nextDouble() < odds);
  }

  void afterRoll() {
    if (goingToWin) {
      widget.onHit();
    } else {
      widget.onMissed();
    }
    setState(() {
      rolling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SlotMachine(
          goingToWin: goingToWin,
          warningLevel: curWarning,
        ),
        FilledButton.tonal(
            onPressed: rolling ? null : tryLuck,
            child: const Text("Try your luck"))
      ],
    );
  }
}

class _SlotMachine extends StatefulWidget {
  final int warningLevel;
  final bool goingToWin;
  const _SlotMachine(
      {super.key, required this.warningLevel, required this.goingToWin});

  static const int seconds = 3;

  @override
  State<_SlotMachine> createState() => _SlotMachineState();
}

class _SlotMachineState extends State<_SlotMachine>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.reset();
    controller.animateTo(1,
        duration: const Duration(seconds: _SlotMachine.seconds));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: animation, builder: builder);
  }

  Widget builder(BuildContext context, Widget? previous) {
    return _SlotRow(
        animationValue: animation.value, goingToWin: widget.goingToWin);
  }
}

class _SlotRow extends StatelessWidget {
  // final Animation animation;
  final double animationValue;
  final bool goingToWin;
  const _SlotRow(
      {super.key, required this.animationValue, required this.goingToWin});

  String randInt() {
    return RNG.nextInt(9).toString();
  }

  @override
  Widget build(BuildContext context) {
    double value = animationValue;
    // Animation<Offset> offset = Tween<Offset>(Offset(0, 2000), Offset(0,0)).animate(animation);
    return Row(children: [
      Transform.translate(
          offset: Offset(0, 1 * value),
          child: Text(goingToWin ? '7' : randInt())),
      Transform.translate(
          offset: Offset(0, -1 * value),
          child: Text(goingToWin ? '7' : randInt())),
      Transform.translate(
          offset: Offset(0, 1.5 * value),
          child: Text(goingToWin ? '7' : randInt())),
    ]);
  }
}
