import 'package:flutter/material.dart';

///I saw a package for this but I'd rather knock it out
///
///
class ColorTweenSequence extends Animatable<Color?> {
  /// Construct a TweenSequence.
  ///
  /// The [items] parameter must be a list of one or more [TweenSequenceItem]s.
  ///
  /// There's a small cost associated with building a [TweenSequence] so it's
  /// best to reuse one, rather than rebuilding it on every frame, when that's
  /// possible.
  ColorTweenSequence(List<ColorTweenSequenceItem> items)
      : assert(items.isNotEmpty) {
    _items.addAll(items);

    double totalWeight = 0.0;
    for (final ColorTweenSequenceItem item in _items) {
      totalWeight += item.weight;
    }
    assert(totalWeight > 0.0);

    double start = 0.0;
    for (int i = 0; i < _items.length; i += 1) {
      final double end =
          i == _items.length - 1 ? 1.0 : start + _items[i].weight / totalWeight;
      _intervals.add(_Interval(start, end));
      start = end;
    }
  }

  ColorTweenSequence.fromColors(List<Color> colors, {List<double>? weights}) {
    late double totalWeight;
    if (weights != null) {
      assert(weights.length == colors.length - 1);
      totalWeight = 0;
      for (final double w in weights) {
        totalWeight += w;
      }
    } else {
      totalWeight = 1;
    }

    int N = colors.length - 1;
    for (int i = 0; i < N; ++i) {
      double weight = weights?[i] ?? 1.0 / N;
      _items.add(ColorTweenSequenceItem(
          tween: ColorTween(begin: colors[i], end: colors[i + 1]),
          weight: weight));
    }
    double start = 0.0;

    for (int i = 0; i < _items.length; i += 1) {
      final double end =
          i == _items.length - 1 ? 1.0 : start + _items[i].weight / totalWeight;
      _intervals.add(_Interval(start, end));
      start = end;
    }
  }

  final List<ColorTweenSequenceItem> _items = <ColorTweenSequenceItem>[];
  final List<_Interval> _intervals = <_Interval>[];

  Color? _evaluateAt(double t, int index) {
    final ColorTweenSequenceItem element = _items[index];
    final double tInterval = _intervals[index].value(t);
    return element.tween.transform(tInterval);
  }

  @override
  Color? transform(double t) {
    if (t >= 1.0) {
      return _evaluateAt(t, _items.length - 1);
    }
    for (int index = 0; index < _items.length; index++) {
      if (_intervals[index].contains(t)) {
        return _evaluateAt(t, index);
      }
    }
    // Should be unreachable.
    throw StateError(
        'TweenSequence.evaluate() could not find an interval for $t');
  }

  @override
  String toString() => 'TweenSequence(${_items.length} items)';
}

/// A simple holder for one element of a [TweenSequence].
class ColorTweenSequenceItem {
  /// Construct a TweenSequenceItem.
  ///
  /// The [weight] must be greater than 0.0.
  const ColorTweenSequenceItem({required this.tween, required this.weight})
      : assert(weight > 0.0);

  /// Defines the value of the [TweenSequence] for the interval within the
  /// animation's duration indicated by [weight] and this item's position
  /// in the list of items.
  final ColorTween tween;

  /// An arbitrary value that indicates the relative percentage of a
  /// [TweenSequence] animation's duration when [tween] will be used.
  ///
  /// The percentage for an individual item is the item's weight divided by the
  /// sum of all of the items' weights.
  final double weight;
}

class _Interval {
  const _Interval(this.start, this.end) : assert(end > start);

  final double start;
  final double end;

  bool contains(double t) => t >= start && t < end;

  double value(double t) => (t - start) / (end - start);

  @override
  String toString() => '<$start, $end>';
}
