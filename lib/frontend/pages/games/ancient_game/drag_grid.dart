import 'package:flutter/material.dart';

import '../../../theme/base_colors.dart';
import 'constants.dart';

class StageIcon extends StatelessWidget {
  final String? id;

  const StageIcon({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    bool real = id != null;

    return SizedBox(
        width: 120,
        height: 120,
        child: Material(
            color: Colors.black,
            type: MaterialType.card,
            elevation: 5,
            shadowColor: Colors.black,
            // border: real ? Border.all(color: Tertiary.shade5, width: 3) : null,
            borderRadius: BorderRadius.circular(15),
            // alignment: Alignment.center,
            child: real
                ? Center(
                    child: Text(id!,
                        style:
                            const TextStyle(fontFamily: 'Rubik', fontSize: 60)),
                  )
                : null));
  }
}

class StageIconShadow extends StatelessWidget {
  const StageIconShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Tertiary.shade0, blurRadius: 20, spreadRadius: -5)
        ]),
        child: SizedBox(width: 120, height: 120));
  }
}

class DragItem extends StatefulWidget {
  final String id;
  const DragItem({super.key, required this.id});

  @override
  State<DragItem> createState() => _DragItemState();
}

class _DragItemState extends State<DragItem> {
  String get id => widget.id;
  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: StageIcon(id: id),
      childWhenDragging: const StageIconShadow(),
      child: StageIcon(id: id),
    );
  }
}

class DragGrid extends StatefulWidget {
  const DragGrid({super.key});

  @override
  State<DragGrid> createState() => _DragGridState();
}

class _DragGridState extends State<DragGrid> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DragItem(id: stage[0]),
        const SizedBox(
          width: 30,
        ),
        DragItem(id: stage[1])
      ],
    );
  }
}
