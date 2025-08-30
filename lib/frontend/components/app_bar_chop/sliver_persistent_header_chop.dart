import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const bool pinned = true;
const bool floating = true;

/// Delegate for configuring a [SliverPersistentHeaderChop].
abstract class SliverPersistentHeaderChopDelegate {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const SliverPersistentHeaderChopDelegate();

  /// The widget to place inside the [SliverPersistentHeaderChop].
  ///
  /// The `context` is the [BuildContext] of the sliver.
  ///
  /// The `shrinkOffset` is a distance from [maxExtent] towards [minExtent]
  /// representing the current amount by which the sliver has been shrunk. When
  /// the `shrinkOffset` is zero, the contents will be rendered with a dimension
  /// of [maxExtent] in the main axis. When `shrinkOffset` equals the difference
  /// between [maxExtent] and [minExtent] (a positive number), the contents will
  /// be rendered with a dimension of [minExtent] in the main axis. The
  /// `shrinkOffset` will always be a positive number in that range.
  ///
  /// The `overlapsContent` argument is true if subsequent slivers (if any) will
  /// be rendered beneath this one, and false if the sliver will not have any
  /// contents below it. Typically this is used to decide whether to draw a
  /// shadow to simulate the sliver being above the contents below it. Typically
  /// this is true when `shrinkOffset` is at its greatest value and false
  /// otherwise, but that is not guaranteed. See [NestedScrollView] for an
  /// example of a case where `overlapsContent`'s value can be unrelated to
  /// `shrinkOffset`.
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent);

  /// The smallest size to allow the header to reach, when it shrinks at the
  /// start of the viewport.
  ///
  /// This must return a value equal to or less than [maxExtent].
  ///
  /// This value should not change over the lifetime of the delegate. It should
  /// be based entirely on the constructor arguments passed to the delegate. See
  /// [shouldRebuild], which must return true if a new delegate would return a
  /// different value.
  double get minExtent;

  /// The size of the header when it is not shrinking at the top of the
  /// viewport.
  ///
  /// This must return a value equal to or greater than [minExtent].
  ///
  /// This value should not change over the lifetime of the delegate. It should
  /// be based entirely on the constructor arguments passed to the delegate. See
  /// [shouldRebuild], which must return true if a new delegate would return a
  /// different value.
  double get maxExtent;

  /// A [TickerProvider] to use when animating the header's size changes.
  ///
  /// Must not be null if the persistent header is a floating header, and
  /// [snapConfiguration] or [showOnScreenConfiguration] is not null.
  TickerProvider? get vsync => null;

  /// Specifies how floating headers should animate in and out of view.
  ///
  /// If the value of this property is null, then floating headers will
  /// not animate into place.
  ///
  /// This is only used for floating headers (those with
  /// [SliverPersistentHeaderChop.floating] set to true).
  ///
  /// Defaults to null.
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  /// Specifies an [AsyncCallback] and offset for execution.
  ///
  /// If the value of this property is null, then callback will not be
  /// triggered.
  ///
  /// This is only used for stretching headers (those with
  /// [SliverAppBar.stretch] set to true).
  ///
  /// Defaults to null.
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  /// Specifies how floating headers and pinned headers should behave in
  /// response to [RenderObject.showOnScreen] calls.
  ///
  /// Defaults to null.
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  /// Whether this delegate is meaningfully different from the old delegate.
  ///
  /// If this returns false, then the header might not be rebuilt, even though
  /// the instance of the delegate changed.
  ///
  /// This must return true if `oldDelegate` and this object would return
  /// different values for [minExtent], [maxExtent], [snapConfiguration], or
  /// would return a meaningfully different widget tree from [build] for the
  /// same arguments.
  bool shouldRebuild(covariant SliverPersistentHeaderChopDelegate oldDelegate);
}

/// A sliver whose size varies when the sliver is scrolled to the edge
/// of the viewport opposite the sliver's [GrowthDirection].
///
/// In the normal case of a [CustomScrollView] with no centered sliver, this
/// sliver will vary its size when scrolled to the leading edge of the viewport.
///
/// This is the layout primitive that [SliverAppBar] uses for its
/// shrinking/growing effect.
///
/// _To learn more about slivers, see [CustomScrollView.slivers]._
class SliverPersistentHeaderChop extends StatelessWidget {
  /// Creates a sliver that varies its size when it is scrolled to the start of
  /// a viewport.
  const SliverPersistentHeaderChop({
    super.key,
    required this.delegate,
  });

  /// Configuration for the sliver's layout.
  ///
  /// The delegate provides the following information:
  ///
  ///  * The minimum and maximum dimensions of the sliver.
  ///
  ///  * The builder for generating the widgets of the sliver.
  ///
  ///  * The instructions for snapping the scroll offset, if [floating] is true.
  final SliverPersistentHeaderChopDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return _SliverFloatingPinnedPersistentHeader(delegate: delegate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SliverPersistentHeaderChopDelegate>(
        'delegate', delegate));
    final List<String> flags = <String>['pinned', 'floating'];
    properties.add(IterableProperty<String>('mode', flags));
  }
}

class _FloatingHeader extends StatefulWidget {
  const _FloatingHeader({required this.child});

  final Widget child;

  @override
  _FloatingHeaderState createState() => _FloatingHeaderState();
}

// A wrapper for the widget created by _SliverPersistentHeaderChopElement that
// starts and stops the floating app bar's snap-into-view or snap-out-of-view
// animation. It also informs the float when pointer scrolling by updating the
// last known ScrollDirection when scrolling began.
class _FloatingHeaderState extends State<_FloatingHeader> {
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_position != null) {
      _position!.isScrollingNotifier.removeListener(_isScrollingListener);
    }
    _position = Scrollable.maybeOf(context)?.position;
    if (_position != null) {
      _position!.isScrollingNotifier.addListener(_isScrollingListener);
    }
  }

  @override
  void dispose() {
    if (_position != null) {
      _position!.isScrollingNotifier.removeListener(_isScrollingListener);
    }
    super.dispose();
  }

  RenderSliverFloatingPersistentHeader? _headerRenderer() {
    return context
        .findAncestorRenderObjectOfType<RenderSliverFloatingPersistentHeader>();
  }

  void _isScrollingListener() {
    assert(_position != null);

    // When a scroll stops, then maybe snap the app bar into view.
    // Similarly, when a scroll starts, then maybe stop the snap animation.
    // Update the scrolling direction as well for pointer scrolling updates.
    final RenderSliverFloatingPersistentHeader? header = _headerRenderer();
    if (_position!.isScrollingNotifier.value) {
      header?.updateScrollStartDirection(_position!.userScrollDirection);
      // Only SliverAppBars support snapping, headers will not snap.
      header?.maybeStopSnapAnimation(_position!.userScrollDirection);
    } else {
      // Only SliverAppBars support snapping, headers will not snap.
      header?.maybeStartSnapAnimation(_position!.userScrollDirection);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _SliverPersistentHeaderChopElement extends RenderObjectElement {
  _SliverPersistentHeaderChopElement(
    _SliverPersistentHeaderChopRenderObjectWidget super.widget, {
    this.floating = false,
  });

  final bool floating;

  @override
  _RenderSliverPersistentHeaderChopForWidgetsMixin get renderObject =>
      super.renderObject as _RenderSliverPersistentHeaderChopForWidgetsMixin;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    renderObject._element = this;
  }

  @override
  void unmount() {
    renderObject._element = null;
    super.unmount();
  }

  @override
  void update(_SliverPersistentHeaderChopRenderObjectWidget newWidget) {
    final _SliverPersistentHeaderChopRenderObjectWidget oldWidget =
        widget as _SliverPersistentHeaderChopRenderObjectWidget;
    super.update(newWidget);
    final SliverPersistentHeaderChopDelegate newDelegate = newWidget.delegate;
    final SliverPersistentHeaderChopDelegate oldDelegate = oldWidget.delegate;
    if (newDelegate != oldDelegate &&
        (newDelegate.runtimeType != oldDelegate.runtimeType ||
            newDelegate.shouldRebuild(oldDelegate))) {
      final _RenderSliverPersistentHeaderChopForWidgetsMixin renderObject =
          this.renderObject;
      _updateChild(newDelegate, renderObject.lastShrinkOffset,
          renderObject.lastOverlapsContent);
      renderObject.triggerRebuild();
    }
  }

  @override
  void performRebuild() {
    super.performRebuild();
    renderObject.triggerRebuild();
  }

  Element? child;

  void _updateChild(
    SliverPersistentHeaderChopDelegate delegate,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final Widget newWidget =
        delegate.build(this, shrinkOffset, overlapsContent);
    child = updateChild(
        child, floating ? _FloatingHeader(child: newWidget) : newWidget, null);
  }

  void _build(double shrinkOffset, bool overlapsContent) {
    owner!.buildScope(this, () {
      final _SliverPersistentHeaderChopRenderObjectWidget
          sliverPersistentHeaderRenderObjectWidget =
          widget as _SliverPersistentHeaderChopRenderObjectWidget;
      _updateChild(
        sliverPersistentHeaderRenderObjectWidget.delegate,
        shrinkOffset,
        overlapsContent,
      );
    });
  }

  @override
  void forgetChild(Element child) {
    assert(child == this.child);
    this.child = null;
    super.forgetChild(child);
  }

  @override
  void insertRenderObjectChild(covariant RenderBox child, Object? slot) {
    assert(renderObject.debugValidateChild(child));
    renderObject.child = child;
  }

  @override
  void moveRenderObjectChild(
      covariant RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(covariant RenderObject child, Object? slot) {
    renderObject.child = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (child != null) {
      visitor(child!);
    }
  }
}

//TODO: Combine with child class
abstract class _SliverPersistentHeaderChopRenderObjectWidget
    extends RenderObjectWidget {
  const _SliverPersistentHeaderChopRenderObjectWidget({required this.delegate});

  final SliverPersistentHeaderChopDelegate delegate;

  @override
  _SliverPersistentHeaderChopElement createElement() =>
      _SliverPersistentHeaderChopElement(this, floating: floating);

  @override
  _RenderSliverPersistentHeaderChopForWidgetsMixin createRenderObject(
      BuildContext context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DiagnosticsProperty<SliverPersistentHeaderChopDelegate>(
        'delegate', delegate));
  }
}

mixin _RenderSliverPersistentHeaderChopForWidgetsMixin
    on RenderSliverPersistentHeader {
  _SliverPersistentHeaderChopElement? _element;

  @override
  double get minExtent =>
      (_element!.widget as _SliverPersistentHeaderChopRenderObjectWidget)
          .delegate
          .minExtent;

  @override
  double get maxExtent =>
      (_element!.widget as _SliverPersistentHeaderChopRenderObjectWidget)
          .delegate
          .maxExtent;

  @override
  void updateChild(double shrinkOffset, bool overlapsContent) {
    assert(_element != null);
    _element!._build(shrinkOffset, overlapsContent);
  }

  @protected
  void triggerRebuild() {
    markNeedsLayout();
  }
}

class _RenderSliverFloatingPinnedPersistentHeaderForWidgets
    extends RenderSliverFloatingPinnedPersistentHeader
    with _RenderSliverPersistentHeaderChopForWidgetsMixin {
  _RenderSliverFloatingPinnedPersistentHeaderForWidgets({
    required super.vsync,
    super.snapConfiguration,
    super.stretchConfiguration,
    super.showOnScreenConfiguration,
  });
}

class _SliverFloatingPinnedPersistentHeader
    extends _SliverPersistentHeaderChopRenderObjectWidget {
  const _SliverFloatingPinnedPersistentHeader({required super.delegate});

  @override
  _RenderSliverPersistentHeaderChopForWidgetsMixin createRenderObject(
      BuildContext context) {
    return _RenderSliverFloatingPinnedPersistentHeaderForWidgets(
      vsync: delegate.vsync,
      snapConfiguration: delegate.snapConfiguration,
      stretchConfiguration: delegate.stretchConfiguration,
      showOnScreenConfiguration: delegate.showOnScreenConfiguration,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderSliverFloatingPinnedPersistentHeaderForWidgets renderObject,
  ) {
    renderObject.vsync = delegate.vsync;
    renderObject.snapConfiguration = delegate.snapConfiguration;
    renderObject.stretchConfiguration = delegate.stretchConfiguration;
    renderObject.showOnScreenConfiguration = delegate.showOnScreenConfiguration;
  }
}
