import 'package:flutter/material.dart';

import '../holders/span_holding_code.dart';
import '../widgets/single_child_2d_scroll_view.dart';

bool isTouchDevice(BuildContext context) {
  final platform = Theme.of(context).platform;
  return platform == TargetPlatform.android ||
      platform == TargetPlatform.iOS ||
      platform == TargetPlatform.fuchsia;
}

bool isPointerDevice(BuildContext context) => !isTouchDevice(context);

class ArtWidget extends StatefulWidget {
  // final ArtHolder art;
  final Widget art;
  const ArtWidget({super.key, required this.art});

  @override
  State<ArtWidget> createState() => _ArtWidgetState();
}

class _ArtWidgetState extends State<ArtWidget> {
  Widget get art => widget.art;
  bool contain = true;

  void expand() {
    setState(() {
      contain = true;
    });
  }

  void minimize() {
    setState(() {
      contain = false;
    });
  }

  Key get key => Key('art_$hashCode');

  Widget getArt(BuildContext context) {
    return Hero(
        tag: 'art_art_$hashCode',
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300), child: art));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (contain) {
      return GestureDetector(
          onTap: minimize,
          child: SizedBox(
              width: width,
              height: height,
              child: Center(
                  child: _Frame(
                      key: key,
                      contain: true,
                      child: SizedBox.expand(
                          child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: getArt(context),
                      ))))));
    } else {
      if (isTouchDevice(context)) {
        return SizedBox(
            width: width,
            height: height,
            child: InteractiveViewer(
                minScale: .333,
                maxScale: 1.5,
                // scrollDirection: Axis.horizontal,
                child: SelectableRegion(
                  selectionControls: EmptyTextSelectionControls(),
                  child: GestureDetector(
                      onDoubleTap: expand,
                      child: _Frame(
                          key: key, contain: false, child: getArt(context))),
                )));
      } else {
        return SizedBox(
            width: width,
            height: height,
            child: SingleChildTwoDimensionalScrollView(
                child: Center(
                    child: SelectableRegion(
                        selectionControls: EmptyTextSelectionControls(),
                        child: GestureDetector(
                            onDoubleTap: expand,
                            child: _Frame(
                                key: key,
                                contain: false,
                                child: getArt(context)))))));
      }
    }
  }
}

class _Frame extends StatelessWidget {
  final Widget child;
  final bool contain;

  const _Frame(
      {required super.key, required this.child, required this.contain});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: contain ? const Color(0xffccbbaa) : const Color(0xff776655),
          border: Border.all(
              color:
                  contain ? const Color(0xff776600) : const Color(0xff554400),
              width: 15),
        ),
        child: child);
  }
}

class ArtHolder extends SpanHoldingCode {
  const ArtHolder({required super.spans});
  @override
  Widget element(BuildContext context) {
    return ArtWidget(art: super.renderSpans(context));
  }
}
