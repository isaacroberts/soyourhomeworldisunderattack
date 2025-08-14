import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../backend/chapter_holder.dart';

typedef MeasureCallback = void Function(ChapterHolder);

class MeasureSliver extends RenderObjectWidget {
  final ChapterHolder chapter;
  final MeasureCallback onBecomesMain;
  //Bool parameter is atBottom
  final void Function(ChapterHolder, bool, double) onOOB;

  const MeasureSliver(
      {super.key,
      required this.chapter,
      required this.onBecomesMain,
      required this.onOOB});

  @override
  RenderObjectElement createElement() {
    // TODO: implement createElement
    return _MeasureElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMeasureSliver(
        chapter: chapter, onBecomesMain: onBecomesMain, onOOB: onOOB);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    if (renderObject is _RenderMeasureSliver) {
      renderObject.onBecomesMain = onBecomesMain;
      renderObject.onOOB = onOOB;
      renderObject.chapter = chapter;
      super.updateRenderObject(context, renderObject);
    }
  }
}

class _RenderMeasureSliver extends RenderSliver {
  ChapterHolder chapter;
  MeasureCallback onBecomesMain;
  void Function(ChapterHolder, bool, double) onOOB;

  _RenderMeasureSliver(
      {required this.chapter,
      required this.onBecomesMain,
      required this.onOOB});

  @override
  void performLayout() {
    if (constraints.scrollOffset > 10000) {
      //View is too far below
      // WidgetsBinding.instance.addPostFrameCallback(
      //     (d) => onOOB(chapter, true, constraints.scrollOffset));
    }
    if (constraints.precedingScrollExtent > 10000) {
      //View is too far above
      // WidgetsBinding.instance.addPostFrameCallback(
      //     (d) => onOOB(chapter, false, constraints.scrollOffset));
    } else if (constraints.scrollOffset < 100) {
      WidgetsBinding.instance
          .addPostFrameCallback((d) => onBecomesMain(chapter));
    }
    double paintExtent = math.min(24, constraints.remainingPaintExtent);

    geometry = SliverGeometry(
      scrollExtent: 100,
      paintExtent: paintExtent,
      layoutExtent: paintExtent,
      maxPaintExtent: 24,
      crossAxisExtent: constraints.crossAxisExtent,
    );
  }
}

class _MeasureElement extends RenderObjectElement {
  _MeasureElement(super.widget);

  @override
  void insertRenderObjectChild(
      covariant RenderObject child, covariant Object? slot) {
    //Ignore
  }

  @override
  void moveRenderObjectChild(covariant RenderObject child,
      covariant Object? oldSlot, covariant Object? newSlot) {
    //Ignore
  }

  @override
  void removeRenderObjectChild(
      covariant RenderObject child, covariant Object? slot) {
    //Ignore
  }
}
