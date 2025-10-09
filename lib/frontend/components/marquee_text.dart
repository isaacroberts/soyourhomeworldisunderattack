import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ReadersCurve extends Curve {
  const ReadersCurve();
  @override
  double transform(double t) {
    return math.pow(t, 1.25).toDouble();
  }

  @override
  Curve get flipped => const FlippedReadersCurve();
}

class FlippedReadersCurve extends Curve {
  const FlippedReadersCurve();
  @override
  double transform(double t) {
    return math.pow(t, 1 / 1.25).toDouble();
  }

  @override
  Curve get flipped => const ReadersCurve();
}

enum MarqueeRepeat { bounce, wrap, noRepeat }

class MarqueeText extends StatefulWidget {
  /// Switches to a rotating marquee if full length
  final String text;
  final TextStyle style;

  ///Milliseconds per pixel
  /// 20 is slow
  /// 10 is brisk
  /// 2 is comical
  /// 1 is undetectable
  final double scrollTime;

  ///Milliseconds per pixel
  final double? reverseTime;
  final Curve? curve;
  final Curve? reverseCurve;

  final Duration pauseAfterScroll;

  final MarqueeRepeat repeat;

  final Alignment alignment;
  static const Duration _defaultDuration = Duration(milliseconds: 300);
  const MarqueeText(
      {super.key,
      required this.text,
      required this.style,
      this.scrollTime = 10,
      this.repeat = MarqueeRepeat.wrap,
      this.alignment = Alignment.center,
      this.reverseTime,
      this.curve,
      this.reverseCurve,
      this.pauseAfterScroll = _defaultDuration});
  static const Curve _defCurve = ReadersCurve();

  static const Duration _lazyDuration = Duration(seconds: 2);
  const MarqueeText.lazy(
      {super.key,
      required this.text,
      required this.style,
      this.repeat = MarqueeRepeat.noRepeat,
      this.scrollTime = 25,
      this.reverseTime = 10,
      this.curve = _defCurve,
      this.reverseCurve = Curves.linear,
      this.alignment = Alignment.center,
      this.pauseAfterScroll = _lazyDuration});

  double get textScaleFactor => 1;
  double get blankSpace => 5;
  double get startPadding => 0;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  List<Widget> elements = [];
  bool get initted => textWidth > 0;

  double width = 0;
  double textWidth = 0;

  MarqueeRepeat get repeat => widget.repeat;
  bool get wrap => repeat == MarqueeRepeat.wrap;
  bool get bounce => repeat == MarqueeRepeat.bounce;
  double get velocity => widget.scrollTime;
  double get reverseVelocity => widget.reverseTime ?? velocity / 2;

  double get totalOffset => math.max(textWidth + 24 - (wrap ? width : 0), 0);

  Duration get duration =>
      Duration(milliseconds: (totalOffset * velocity).toInt());

  Duration get backDuration =>
      Duration(milliseconds: (totalOffset * reverseVelocity).toInt());

  /// Calculates all necessary values for animating, then starts the animation.
  void _initialize(BuildContext context) {
    // Calculate lengths (amount of pixels that each phase needs).
    textWidth = getTextWidth(context);
  }

  double getTextWidth(BuildContext context) {
    return _getTextWidth(context, widget.text);
  }

  /// Returns the width of the text.
  double _getTextWidth(BuildContext context, String string) {
    final span = TextSpan(text: string, style: widget.style);

    const constraints = BoxConstraints(maxWidth: double.infinity);

    final richTextWidget = Text.rich(
      span,
      style: widget.style,
    ).build(context) as RichText;
    final renderObject = richTextWidget.createRenderObject(context);
    renderObject.layout(constraints);

    final boxes = renderObject.getBoxesForSelection(TextSelection(
      baseOffset: 0,
      extentOffset: TextSpan(text: string).toPlainText().length,
    ));

    return boxes.last.right;
  }

  Widget verseElem(String w) {
    return Align(
        alignment:
            //Must be left
            Alignment(-1, widget.alignment.y),
        child: Text(
          w,
          maxLines: 1,
          style: widget.style,
        ));
  }

  Iterable<String> splitLen(String sentence) sync* {
    for (int n = 0; n < sentence.length; n += 100) {
      yield sentence.substring(n, math.min(n + 100, sentence.length));
    }

    // yield sentence.substring(sentence.length - sentence.length % 100);
  }

  List<Widget> text() {
    List<Widget> widgets = [];

    widgets.add(const SizedBox(
      width: 12,
    ));

    widgets.addAll(splitLen(widget.text).map(verseElem));

    // if (widget.wrap) {
    // widgets.add(SizedBox(
    //   //Extra to make sure loop can complete
    //   width: width,
    // ));
    // }
    widgets.add(const SizedBox(
      width: 12,
    ));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        key: const Key('marqueeLayouter'), builder: layoutBuilder);
  }

  Widget layoutBuilder(BuildContext context, BoxConstraints constraints) {
    double w = constraints.maxWidth;
    assert(w.isFinite && w > 0);
    if (!initted) {
      width = w;
      _initialize(context);
    }

    //Skip creating wordlist
    if (width > textWidth) {
      //Skip allat
      width = textWidth;
      return Align(
          alignment: widget.alignment,
          child: Text(
            widget.text,
            style: widget.style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ));
    } else {
      if (elements.isEmpty) {
        //Create list if missing
        elements = text();
      }

      return MarqueeWidget(
          childWidth: textWidth,
          availableWidth: width,
          scrollDuration: duration,
          repeat: repeat,
          alignment: widget.alignment,
          reverseDuration: backDuration,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve,
          pauseAfterScroll: widget.pauseAfterScroll,
          children: elements);
    }
  }

  Widget stackIfDebug(BuildContext context, {required Widget child}) {
    // return Stack(
    //   children: [widthDebugListView(context), child],
    // );
    return child;
  }
}

class MarqueeWidget extends StatefulWidget {
  ///These should be broken up anyway
  final List<Widget> children;
  final double childWidth;
  final double availableWidth;

  final Duration scrollDuration;
  final Duration reverseDuration;

  final Curve? curve;
  final Curve? reverseCurve;

  final Duration pauseAfterScroll;

  final MarqueeRepeat repeat;

  final Alignment alignment;
  const MarqueeWidget(
      {super.key,
      required this.children,
      required this.childWidth,
      required this.availableWidth,
      required this.scrollDuration,
      required this.repeat,
      required this.alignment,
      required this.reverseDuration,
      required this.curve,
      required this.reverseCurve,
      required this.pauseAfterScroll});

  double get textScaleFactor => 1;
  double get blankSpace => 5;
  double get startPadding => 0;

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget>
    with SingleTickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  // final ScrollController controller2 = ScrollController();
  late final Timer timer;
  List<Widget> elements = [];
  @override
  void initState() {
    controller.addListener(wasScrolled);
    startTimer();
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 250), checkScroll);
  }

  bool autoscroll = true;
  void pauseOnRivalScroll() {}
  void wasScrolled() {
    autoscroll = false;
  }

  double width = 0;
  double get textWidth => widget.childWidth;

  MarqueeRepeat get repeat => widget.repeat;
  bool get wrap => repeat == MarqueeRepeat.wrap;
  bool get bounce => repeat == MarqueeRepeat.bounce;

  Curve get curve => widget.curve ?? Curves.ease;
  Curve get reverseCurve => widget.reverseCurve ?? Curves.easeOut;

  double get totalOffset => math.max(textWidth + 24 - (wrap ? width : 0), 0);

  Duration get duration => widget.scrollDuration;

  Duration get backDuration => widget.reverseDuration;

  bool get controllerCanScroll => mounted && controller.positions.isNotEmpty;

  void scrollForward() {
    if (controllerCanScroll) {
      controller.animateTo(totalOffset + 10, duration: duration, curve: curve);
    }
  }

  void scrollBack() {
    if (controllerCanScroll) {
      Duration backDuration = this.backDuration;
      if (wrap || backDuration.inSeconds <= 0) {
        controller.jumpTo(0);
      } else {
        controller.animateTo(0, duration: backDuration, curve: reverseCurve);
      }
    }
  }

  void checkScroll(t) async {
    if (mounted && controller.hasClients && autoscroll) {
      // dev.log("Scroll @: ${controller.offset} / ${totalOffset}");
      Duration duration = this.duration;
      if (totalOffset <= 0 || duration.isNegative) {
        return;
      } else if (controller.offset == 0) {
        // dev.log("Animate forward ($duration) (${widget.velocity}");

        await Future.delayed(widget.pauseAfterScroll);
        scrollForward();
        // controller2.animateTo(totalOffset + 10,
        //     duration: duration, curve: curve);
      } else if (controller.offset >= controller.position.maxScrollExtent) {
        //Animate backwards
        if (repeat == MarqueeRepeat.wrap) {
          //Jump back
          //No pause after scroll
          if (controllerCanScroll) {
            controller.jumpTo(0);
          }
        } else if (repeat == MarqueeRepeat.bounce) {
          //Animate back
          await Future.delayed(widget.pauseAfterScroll);
          scrollBack();
        } else if (repeat == MarqueeRepeat.noRepeat) {
          autoscroll = false;
        }
      }
    }
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: widget.alignment,
        child: stackIfDebug(context,
            child: ListView(
                primary: false,
                shrinkWrap: true,
                controller: controller,
                scrollDirection: Axis.horizontal,
                // physics: const NeverScrollableScrollPhysics(),
                children: widget.children)));
  }

  Widget stackIfDebug(BuildContext context, {required Widget child}) {
    // return Stack(
    //   children: [widthDebugListView(context), child],
    // );
    return child;
  }

// Widget widthDebugListView(BuildContext context) {
//   return ListView(
//     primary: false,
//     controller: controller2,
//     scrollDirection: Axis.horizontal,
//     children: [
//       const SizedBox(
//         width: 12,
//       ),
//       Container(
//         color: Color(0xffffffff),
//         width: textWidth,
//       ),
//       const SizedBox(
//         width: 12,
//       ),
//       SizedBox(
//         width: screenWidth - 50,
//       ),
//       Container(
//         color: const Color(0xff557755),
//         width: 50,
//         child: const Text('1'),
//       ),
//       SizedBox(
//         width: screenWidth - 50,
//       ),
//       Container(
//         color: const Color(0xff557755),
//         width: 50,
//         child: const Text('2'),
//       ),
//       SizedBox(
//         width: screenWidth - 50,
//       ),
//       Container(
//         color: const Color(0xff557755),
//         width: 50,
//         child: const Text('3'),
//       ),
//     ],
//   );
// }
}
