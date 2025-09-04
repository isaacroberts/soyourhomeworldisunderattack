import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/pages/title/title_copy.dart';
import 'package:soyourhomeworld/frontend/theme/base_colors.dart';

import 'fire_painter.dart';

class FlameWidget extends StatefulWidget {
  final double width;
  final double height;
  const FlameWidget({
    required super.key,
    required this.width,
    required this.height,
  });

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController fireAnimationController;

  late final Timer flameTimer;
  int flameCt = 4;
  bool done = false;

  bool get fireShowing =>
      //Start
      buttonShowing
      //End
      &&
      !done;

  //This will require finessing
  ///Whether the button is ready to show
  bool get buttonShowing =>
      fireAnimationController.value >
      //This must correspond to the earth animation
      5 / 60;
  @override
  void initState() {
    super.initState();

    fireAnimationController = AnimationController(
        vsync: this,
        debugLabel: 'FireAnim',
        animationBehavior: AnimationBehavior.normal);
    fireAnimationController.animateTo(1, duration: const Duration(seconds: 60));

    flameTimer = Timer.periodic(const Duration(seconds: 2), timerCallback);
  }

  void timerCallback(Timer t) {
    if (mounted) {
      addFlame();
    }
  }

  void addFlame() {
    if (mounted) {
      if (fireShowing) {
        if (flameCt < 10) {
          setState(() {
            flameCt += 1;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    fireAnimationController.dispose();
    flameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: AnimatedBuilder(
                key: const Key("TitleAnimBuilder"),
                animation: fireAnimationController,
                builder: builder)));
  }

  void firePressed() {
    if (flameCt > 0) {
      if (flameCt > 10) {
        setState(() {
          flameCt = 10;
        });
      } else {
        setState(() {
          flameCt -= 1;
        });
      }
    } else {
      setState(() {
        done = true;
      });
    }
  }

  Widget builder(BuildContext builder, Widget? previous) {
    // dev.log("Builder: ${animationController.value}");
    Size size = Size(widget.width, widget.height);
    late final Widget? button;
    button = null;
    // if (buttonShowing) {
    //   button = FireButton(
    //     key: const Key("fireButton"),
    //     onPressed: firePressed,
    //     isDone: done,
    //   );
    // } else {
    //   button = const SizedBox(height: 48);
    // }
    Widget child = widget.width < 600
        ? TitleTextPhone(
            key: const Key('TitlePhone}'), size: size, child: button)
        : TitleTextWide(key: const Key('TitleWide'), size: size, child: button);

    return CustomPaint(
        key: const Key("TitlePainter"),
        isComplex: false,
        size: Size(widget.width, widget.height),
        willChange: fireShowing,
        painter: fireShowing
            ? FirePainter(anim: fireAnimationController.value, flameCt: flameCt)
            : null,
        child: child);
  }
}

class FireButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isDone;
  const FireButton(
      {required super.key, required this.onPressed, required this.isDone});

  @override
  State<FireButton> createState() => _FireButtonState();
}

class _FireButtonState extends State<FireButton> {
  ///No longer blinking
  bool orange = false;

  void continueOn() {
    context.go('/scroll/1');
  }

  @override
  void initState() {
    super.initState();

    // Future.delayed(const Duration(milliseconds: 500), toggle);
  }

  void toggle() {
    if (mounted) {
      setState(() {
        orange = !orange;
      });
      Future.delayed(const Duration(milliseconds: 500), toggle);
    }
  }

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (widget.isDone) {
      child = FilledButton(
          key: const Key('continueon'),
          onPressed: continueOn,
          child: const Text('Continue'));
    } else {
      child = const Text(key: Key('buttontext'), 'wtf put it out');
      if (orange) {
        ButtonStyle? style = Theme.of(context).filledButtonTheme.style;
        style ??= const ButtonStyle();
        child = FilledButton(
            style: style.copyWith(
                backgroundColor: const WidgetStatePropertyAll(planColor),
                foregroundColor: const WidgetStatePropertyAll(Colors.white)),
            key: const Key('putitout_o'),
            onPressed: widget.onPressed,
            child: child);
      } else {
        child = FilledButton(
            key: const Key('putitout_n'),
            onPressed: widget.onPressed,
            child: child);
      }
    }
    child = SizedBox(key: const Key('sizer'), height: 48, child: child);
    return child;
  }
}
