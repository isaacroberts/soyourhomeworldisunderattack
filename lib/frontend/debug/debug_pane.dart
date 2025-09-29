import 'package:flutter/material.dart';

import '../elements/holders/holder_base.dart';
import 'debug_pane_rows.dart';

///Entry point
///TODO: Create deferred entry point 
void showHolderInspectorDialog(BuildContext context, Holder holder,
    {int nestLevel = 0}) {
  Navigator.push(
      context, HolderDebugDialog(holder: holder, nestLevel: nestLevel));
}

///Charts of info on holder
///Very ugly, very user-unfriendly
///Very inefficient
class HolderDebugDialog extends PopupRoute {
  final Holder holder;
  final int nestLevel;

  HolderDebugDialog({required this.holder, required this.nestLevel}) : super();

  @override
  Color get barrierColor => const Color(0x00000000);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Barrier';

  @override
  bool get opaque => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // var offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
    //     .animate(animation);
    return Align(
        alignment: Alignment(1 - nestLevel * .1, 0 + nestLevel * .1),
        child: FractionallySizedBox(
            widthFactor: .75,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: HolderDebugPane(holder: holder))));
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}

///Entry point for DebugPane
class HolderDebugPane extends StatefulWidget {
  final Holder holder;
  const HolderDebugPane({super.key, required this.holder});

  @override
  State<HolderDebugPane> createState() => _HolderDebugPaneState();
}

class _HolderDebugPaneState extends State<HolderDebugPane> {
  @override
  Widget build(BuildContext context) {
    String type = widget.holder.runtimeType.toString();
//Opens in new Dialog
    return Dialog(
        shape: const RoundedRectangleBorder(),
        backgroundColor: debugPaneBg,
        child: Container(
            width: 580,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: const Color(0xff111111),
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            // padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 0),
            child: SizedBox(
                width: 600,
                // height: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          type,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )),
                    Expanded(child: HolderDebugPaneContent(widget.holder))
                  ],
                ))));
  }
}
