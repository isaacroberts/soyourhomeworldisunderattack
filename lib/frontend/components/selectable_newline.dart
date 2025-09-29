import 'package:flutter/material.dart';

class SelectableNewline extends StatelessWidget {
  final double height;

  const SelectableNewline({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

/*
class SelectableNewline extends SingleChildRenderObjectWidget {
  // Newlines that select properly when box-dragged.
  /// Otherwise, selections come out as one long string of text.
  final double height;

  const SelectableNewline({super.key, required this.height});

  @override
  SingleChildRenderObjectElement createElement() {
    return _SelectableNewlineElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    Color? color = Theme.of(context).textSelectionTheme.selectionColor;
    var renderObject =
        SelectableNewlineState(height: height, selectionColor: color);

    renderObject.registrar = registrar;
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    if (renderObject is SelectableNewlineState) {
      if (height != renderObject.height) {
        renderObject.height = height;
        renderObject.markNeedsLayout();
      }
      Color? color = Theme.of(context).textSelectionTheme.selectionColor;
      if (color != renderObject.selectionColor) {
        renderObject.selectionColor = color;
        renderObject.markNeedsPaint();
      }
    }
    super.updateRenderObject(context, renderObject);
  }
}

class _SelectableNewlineElement extends SingleChildRenderObjectElement {
  _SelectableNewlineElement(super.widget);

  @override
  void insertRenderObjectChild(
      SelectableNewlineState child, covariant Object? slot) {

    SelectionRegistrar? registrar = SelectionContainer.maybeOf(this.);

    renderObject.registrar = SelectionContainer.maybeOf(context);
    // TODO: implement insertRenderObjectChild
    super.insertRenderObjectChild(child, slot);
  }
}

class SelectableNewlineState extends RenderBox
    with Selectable, SelectionRegistrant {
  /// Newlines that select properly when box-dragged.
  /// Otherwise, selections come out as one long string of text.
  /// TODO: This needs to store the selectionHandles.
  /// Some shit like that.
  /// It was simply too complicated to be worth it.
  double height;
  bool _selected = false;
  Color? selectionColor;

  SelectableNewlineState({required this.height, required this.selectionColor});

  bool get selected => _selected;
  set selected(bool set) {
    if (set != _selected) {
      _selected = set;
      notifyListeners();
    }
  }

  static const double width = 6;
  @override

  // TODO: implement size
  Size get size => Size(width, height);

  // @override
  // SelectionGeometry value;

  @override
  SelectionGeometry get value {
    if (selected) {
      //TODO: The uncollapsed is wrong; it needs to know whether the selection is butting the edge
      return const SelectionGeometry(
          status: SelectionStatus.uncollapsed, hasContent: true);
    } else {
      return const SelectionGeometry(
          status: SelectionStatus.none, hasContent: true);
    }
  }

  @override
  List<Rect> get boundingBoxes => [Rect.fromLTWH(0, 0, width, height)];

  @override
  // TODO: implement paintBounds
  Rect get paintBounds => Rect.fromLTWH(0, 0, width, height);

  @override
  int get contentLength => 1;

  @override
  SelectionResult dispatchSelectionEvent(SelectionEvent event) {
    if (event.type != SelectionEventType.clear) {
      dev.log("Dispatch selection: ${event.type}");
    }
    switch (event.type) {
      case SelectionEventType.startEdgeUpdate:
//WHo me?
        SelectionEdgeUpdateEvent edgeEvent = event as SelectionEdgeUpdateEvent;
        selected = true;
        // value.startSelectionPoint = event.globalPosition;
        if (edgeEvent.granularity == TextGranularity.document) {
          return SelectionResult.previous;
        } else {
          return SelectionResult.end;
        }
      case SelectionEventType.endEdgeUpdate:
        SelectionEdgeUpdateEvent edgeEvent = event as SelectionEdgeUpdateEvent;
        selected = true;
        if (edgeEvent.granularity == TextGranularity.document) {
          return SelectionResult.next;
        } else {
          return SelectionResult.end;
        }
      case SelectionEventType.clear:
        selected = false;
        return SelectionResult.none;
      case SelectionEventType.selectAll:
        selected = true;
        return SelectionResult.none;
      case SelectionEventType.selectWord:
        selected = true;
        //Newlines are not part of words
        return SelectionResult.end;
      case SelectionEventType.selectParagraph:
        selected = true;
        return SelectionResult.end;
      case SelectionEventType.granularlyExtendSelection:
        if (event is GranularlyExtendSelectionEvent) {
          switch (event.granularity) {
            case TextGranularity.character:
            case TextGranularity.word:
            case TextGranularity.paragraph:
            case TextGranularity.line:
              //Newline consumes all of the above
              selected = true;
              return SelectionResult.end;
            case TextGranularity.document:
              selected = true;
              if (event.forward) {
                return SelectionResult.next;
              } else {
                return SelectionResult.previous;
              }
          }
        } else {
          return SelectionResult.none;
        }

      case SelectionEventType.directionallyExtendSelection:
        DirectionallyExtendSelectionEvent e =
            event as DirectionallyExtendSelectionEvent;
        selected = true;
        if (e.dx <= 1) {
          return SelectionResult.end;
        }
        if (e.direction == SelectionExtendDirection.forward) {
          return SelectionResult.next;
        } else {
          return SelectionResult.end;
        }
    }
  }

  @override
  SelectedContent? getSelectedContent() {
    if (selected) {
      return const SelectedContent(plainText: '\n');
    } else {
      return null;
    }
  }

  @override
  SelectedContentRange? getSelection() {
    if (selected) {
      return const SelectedContentRange(startOffset: 0, endOffset: 1);
    }
    return null;
  }

  @override
  Matrix4 getTransformTo(RenderObject? ancestor) {
    //TODO: I DONT KNOW SHIT ABOUT MATRICES
    return Matrix4.identity();
  }

  LayerLink? _startHandleLayerLink;
  LayerLink? _endHandleLayerLink;

  @override
  void pushHandleLayers(LayerLink? startHandle, LayerLink? endHandle) {
    if (_startHandleLayerLink != startHandle) {
      _startHandleLayerLink = startHandle;
      markNeedsPaint();
    }
    if (_endHandleLayerLink != endHandle) {
      _endHandleLayerLink = endHandle;
      markNeedsPaint();
    }
  }

  final List<VoidCallback> listeners = [];

  void notifyListeners() {
    ///I'm assuming I need this because it had mandatory overrides for addlisteners
    for (VoidCallback listener in listeners) {
      listener();
    }
  }

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  @override
  void debugAssertDoesMeetConstraints() {
    // TODO: implement debugAssertDoesMeetConstraints
  }

  @override
  void paint(PaintingContext context, Offset imageOffset) {
    if (_startHandleLayerLink != null && value.startSelectionPoint != null) {
      context.pushLayer(
        LeaderLayer(
          link: _startHandleLayerLink!,
          offset: imageOffset + value.startSelectionPoint!.localPosition,
        ),
        (PaintingContext context, Offset offset) {},
        Offset.zero,
      );
    }
    if (_endHandleLayerLink != null && value.endSelectionPoint != null) {
      context.pushLayer(
        LeaderLayer(
          link: _endHandleLayerLink!,
          offset: imageOffset + value.endSelectionPoint!.localPosition,
        ),
        (PaintingContext context, Offset offset) {},
        Offset.zero,
      );
    }

    if (selected) {
      final Paint selectionPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = selectionColor ?? Colors.black;
      context.canvas.drawRect(paintBounds.shift(imageOffset), selectionPaint);
    } else {
      final Paint selectionPaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = const Color(0x2affffff);
      context.canvas.drawRect(paintBounds.shift(imageOffset), selectionPaint);
    }
  }

  @override
  void performLayout() {
    size = Size(width, height);
  }

  @override
  void performResize() {
    size = Size(width, height);
  }

  @override
  Rect get semanticBounds => Rect.fromLTWH(0, 0, width, height);

  @override
  double computeMinIntrinsicWidth(double height) {
    return 0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return width;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return height;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return height;
  }

  @override
  bool get hasSize => true;

  @override
  bool get sizedByParent => false;
}
*/
