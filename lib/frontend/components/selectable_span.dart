import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../elements/holders/span_holders.dart';

class SelectableSpan extends StatelessWidget {
  final List<FragOfText> spans;
  final TextAlign align;

  const SelectableSpan({super.key, required this.spans, required this.align});

  Widget spanItself(BuildContext context) {
    return SelectableText.rich(
      TextSpan(children: [
        for (int n = 0; n < spans.length; ++n) spans[n].span(context),
      ]),
      textAlign: align,
    );
  }

  @override
  Widget build(BuildContext context) {
    return spanItself(context);
    //I'm not using this correctly
    // return SelectionContainer(
    //     delegate: SelectAllOrNoneContainerDelegate(),
    //     child: spanItself(context));
  }
}

class SpanSelectionDelegate extends MultiSelectableSelectionContainerDelegate {
  @override
  void ensureChildUpdated(Selectable selectable) {
    // TODO: implement ensureChildUpdated
  }
}

class SelectAllOrNoneContainerDelegate
    extends MultiSelectableSelectionContainerDelegate {
  Offset? _adjustedStartEdge;
  Offset? _adjustedEndEdge;
  bool _isSelected = false;

  // This method is called when newly added selectable is in the current
  // selected range.
  @override
  void ensureChildUpdated(Selectable selectable) {
    if (_isSelected) {
      dispatchSelectionEventToChild(
          selectable, const SelectAllSelectionEvent());
    }
  }

  @override
  SelectionResult handleSelectWord(SelectWordSelectionEvent event) {
    // Treat select word as select all.
    return handleSelectAll(const SelectAllSelectionEvent());
  }

  @override
  SelectionResult handleSelectionEdgeUpdate(SelectionEdgeUpdateEvent event) {
    final Rect containerRect =
        Rect.fromLTWH(0, 0, containerSize.width, containerSize.height);
    final Matrix4 globalToLocal = getTransformTo(null)..invert();
    final Offset localOffset =
        MatrixUtils.transformPoint(globalToLocal, event.globalPosition);
    final Offset adjustOffset =
        SelectionUtils.adjustDragOffset(containerRect, localOffset);
    if (event.type == SelectionEventType.startEdgeUpdate) {
      _adjustedStartEdge = adjustOffset;
    } else {
      _adjustedEndEdge = adjustOffset;
    }
    // Select all content if the selection rect intercepts with the rect.
    if (_adjustedStartEdge != null && _adjustedEndEdge != null) {
      final Rect selectionRect =
          Rect.fromPoints(_adjustedStartEdge!, _adjustedEndEdge!);
      if (!selectionRect.intersect(containerRect).isEmpty) {
        handleSelectAll(const SelectAllSelectionEvent());
      } else {
        super.handleClearSelection(const ClearSelectionEvent());
      }
    } else {
      super.handleClearSelection(const ClearSelectionEvent());
    }
    return SelectionUtils.getResultBasedOnRect(containerRect, localOffset);
  }

  @override
  SelectionResult handleClearSelection(ClearSelectionEvent event) {
    _adjustedStartEdge = null;
    _adjustedEndEdge = null;
    _isSelected = false;
    return super.handleClearSelection(event);
  }

  @override
  SelectionResult handleSelectAll(SelectAllSelectionEvent event) {
    _isSelected = true;
    return super.handleSelectAll(event);
  }
}
