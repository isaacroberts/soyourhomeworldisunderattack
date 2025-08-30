import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/pages/games/ancient_game/drag_grid.dart';
import 'package:soyourhomeworld/frontend/pages/games/ancient_game/text_controller.dart';

import '../../../theme/base_colors.dart';
import 'bg.dart';
import 'constants.dart';

class PeterThielsAncientGame extends StatefulWidget {
  const PeterThielsAncientGame({super.key});

  @override
  State<PeterThielsAncientGame> createState() => _PeterThielsAncientGameState();
}

class _PeterThielsAncientGameState extends State<PeterThielsAncientGame> {
  late final Timer timer;
  int? currentCommand;

  late final DoingBestTextController command;
  late final FunctioningTextController emoji;
  late final DoingBestTextController button;

  bool assembled = false;
  static const int cyclesBeforeCheck = 23;
  int cycles = 0;
  @override
  void initState() {
    command = DoingBestTextController(text: null);
    emoji = FunctioningTextController(text: getEmoji());
    // emoji = DoingBestTextController(text: getEmoji());
    button = DoingBestTextController(text: null);
    timer = Timer.periodic(const Duration(milliseconds: 67), timerCallback);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void timerCallback(t) {
    if (mounted) {
      if (!emoji.matches) {
        setState(() {
          emoji.update();
        });
        return;
      }
      if (!button.matches) {
        setState(() {
          button.update();
        });
        return;
      }

      if (!command.matches) {
        setState(() {
          command.update();
        });
        return;
      }

      if (cycles >= cyclesBeforeCheck) {
        cycles = 0;
        // dev.log("Checking: $currentCommand");
        if (currentCommand == null) {
          setState(() {
            currentCommand = 0;
          });
          command.text = getTargetText();
          emoji.text = getEmoji();
          return;
        } else if (assembled) {
          setState(() {
            currentCommand = (currentCommand ?? 0) + 1;
            assembled = false;
          });
          command.text = getTargetText();
          emoji.text = getEmoji();

          return;
        }
      } else {
        emoji.text = getEmoji();
        if (currentCommand == null) {
          button.text = null;
        } else {
          if (assembled) {
            button.text = 'Good!';
          } else {
            button.text = 'Okay';
          }
        }
      }
      cycles++;

      // command.update();
      // button.update();

      // dev.log("current command: $currentCommand");
      // if (cycles % 2 == 0) {
      //   emoji.update();
      // }
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        key: const Key("ctr"),
        height: 800,
        decoration: BoxDecoration(
            color: Tertiary.shade0, border: Border.all(color: Tertiary.shaded)),
        child: SizedBox.expand(
            child: CustomPaint(
          key: const Key('borderPainter'),
          painter: OutlineSymbologyPainter(text: command.text),
          child: Column(
            key: const Key("Column"),
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 200,
                  child: Text(
                    key: Key('text(${command.text})'),
                    command.text,
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w800,
                        color:
                            command.matches ? Tertiary.shadef : Tertiary.shade8,
                        fontSize: 48),
                  )),
              const DragGrid(),
            ],
          ),
        )));
  }

  void onAssembled() {
    assembled = true;
  }

  bool get canPressButton {
    return (currentCommand != null) && (!assembled) && (command.matches);
  }

  String getEmoji() {
    if (currentCommand == null) {
      return '🔌️';
    }
    if (!command.matches || !button.matches) {
      return '⏳️️️️‍️';
    }
    if (assembled) {
      return '🍔️️';
    }
    return '💡️';
  }

  String getTargetText() {
    if (currentCommand != null) {
      if (currentCommand! >= 0 && currentCommand! < commands.length) {
        return commands[currentCommand!];
      }
    }
    return 'No text.';
  }
}
