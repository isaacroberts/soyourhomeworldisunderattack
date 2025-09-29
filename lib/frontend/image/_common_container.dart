import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'image_holder.dart';

class CommonImageContainer extends StatefulWidget {
  // final Widget child;
  final StdImageHolder holder;
  //Build child element, with expanded state
  final Widget Function(BuildContext, bool expanded) childBuilder;

  const CommonImageContainer(
      {required super.key,
      // required this.child,
      required this.holder,
      required this.childBuilder});

  @override
  State<StatefulWidget> createState() => _CommonImageContainerState();
}

class _CommonImageContainerState extends State<CommonImageContainer> {
  StdImageHolder get holder => widget.holder;
  Color? get bgColor => holder.bgColor;

  bool _hovered = false;
  bool _expanded = false;

  bool get allowExpand => (widget.holder.aspectRatio ?? .9) < 1;
  @override
  Widget build(BuildContext context) {
    //Get expanded
    Widget child = widget.childBuilder(context, expanded);

    Color? outlineColor = holder.outlineColor;
    //TODO: Move this up
    outlineColor ??= Colors.black;

    child = Material(
        key: const Key('img_mat'),
        color: bgColor,
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: outlineColor,
              width: 2,
              strokeAlign: BorderSide.strokeAlignCenter),
        ),
        elevation: 5,
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
        child: child);

    // child = Padding(
    //     padding: const EdgeInsets.all(15),
    //     key: const Key('outl2'),
    //     child: child);
    if (kDebugMode) {
      //For debugging the damn if ladder
      child = Tooltip(
          key: const Key('dev_ttp'),
          message: 'AspectRatio: ${holder.aspectRatio}; Expanded=$expanded',
          child: child);
    }

    child = InkWell(
        key: const Key("Inkwell"),
        onHover: (b) => hovered = b,
        onTap: toggleExpanded,
        child: child);

    // if (hovered) {
    child = Column(
        key: const Key('credit_col'),
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          child,
          //TODO: Replace with image credit
          Text(
            key: const Key('credit'),
            hovered ? holder.credit : '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(
            height: 12,
          ),
        ]);
    // } else {
    //   double bottomPad =
    //       Theme.of(context).textTheme.labelMedium?.fontSize ?? 12;
    //   bottomPad *= Theme.of(context).textTheme.labelMedium?.height ?? 1;
    //   child = Padding(
    //       key: const Key('credit_space_replacer'),
    //       padding: EdgeInsets.only(bottom: bottomPad + 12),
    //       child: child);
    // }
    return child;
  }

  bool get hovered => _hovered;
  bool get expanded => _expanded;

  set hovered(bool s) {
    if (mounted) {
      if (s != _hovered) {
        setState(() {
          _hovered = s;
        });
      }
    }
  }

  set expanded(bool s) {
    if (mounted && allowExpand) {
      if (s != _expanded) {
        setState(() {
          _expanded = s;
        });
      }
    }
  }

  void toggleExpanded() {
    if (mounted && allowExpand) {
      setState(() {
        _expanded = !_expanded;
      });
    }
  }
}

class CommonImageSliverContainer extends StatefulWidget {
  // final Widget child;
  final StdImageHolder holder;
  //Build child element, with expanded state
  final Widget Function(BuildContext, bool expanded) childBuilder;

  const CommonImageSliverContainer(
      {required super.key, required this.holder, required this.childBuilder});

  @override
  State<StatefulWidget> createState() => _CommonImageSliverContainerState();
}

class _CommonImageSliverContainerState
    extends State<CommonImageSliverContainer> {
  StdImageHolder get holder => widget.holder;
  Color? get bgColor => holder.bgColor;

  bool _hovered = false;
  bool _expanded = false;

  bool get allowExpand => (widget.holder.aspectRatio ?? .9) < 1;
  @override
  Widget build(BuildContext context) {
    //Get expanded
    //TODO: Will this be a sliver?
    Widget sliver = widget.childBuilder(context, expanded);

    Color? outlineColor = holder.outlineColor;
    outlineColor ??= Colors.black;

    //
    // sliver = Material(
    //     key: const Key('img_mat'),
    //     color: bgColor,
    //     //TODO: Add glassier overlay
    //     type: MaterialType.transparency,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //       side: BorderSide(
    //           color: outlineColor,
    //           width: 2,
    //           strokeAlign: BorderSide.strokeAlignCenter),
    //     ),
    //     elevation: 5,
    //     borderOnForeground: true,
    //     clipBehavior: Clip.antiAlias,
    //     child: sliver);

    // child = Padding(
    //     padding: const EdgeInsets.all(15),
    //     key: const Key('outl2'),
    //     child: child);
    if (kDebugMode) {
      //For debugging the damn if ladder
      sliver = Tooltip(
          key: const Key('dev_ttp'),
          message: 'AspectRatio: ${holder.aspectRatio}; Expanded=$expanded',
          child: sliver);
    }

    sliver = InkWell(
        key: const Key("Inkwell"),
        onHover: (b) => hovered = b,
        onTap: toggleExpanded,
        child: sliver);

    // if (hovered) {
    sliver = SliverMainAxisGroup(key: const Key('credit_col'), slivers: [
      sliver,
      //TODO: Replace with image credit
      SliverToBoxAdapter(
          key: const Key('ImgCredit'),
          child: Text(
            key: const Key('credit'),
            hovered ? holder.credit : '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          )),
      const SliverPadding(padding: EdgeInsets.only(bottom: 12)),
    ]);
    // } else {
    //   double bottomPad =
    //       Theme.of(context).textTheme.labelMedium?.fontSize ?? 12;
    //   bottomPad *= Theme.of(context).textTheme.labelMedium?.height ?? 1;
    //   child = Padding(
    //       key: const Key('credit_space_replacer'),
    //       padding: EdgeInsets.only(bottom: bottomPad + 12),
    //       child: child);
    // }
    return sliver;
  }

  bool get hovered => _hovered;
  bool get expanded => _expanded;

  set hovered(bool s) {
    if (mounted) {
      if (s != _hovered) {
        setState(() {
          _hovered = s;
        });
      }
    }
  }

  set expanded(bool s) {
    if (mounted && allowExpand) {
      if (s != _expanded) {
        setState(() {
          _expanded = s;
        });
      }
    }
  }

  void toggleExpanded() {
    if (mounted && allowExpand) {
      setState(() {
        _expanded = !_expanded;
      });
    }
  }
}
