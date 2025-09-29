import 'dart:async';
import 'dart:core';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/icons.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

import '../../../backend/utils.dart';
import 'greenland_ticket.dart';

/*


[Hello developer. It’s me, developer.

The game should be a forgery game.
Drag to place rounded rectangles, drag numbers, etcetera.

Copying off a ticket.

 */

class GreenlandGamePage extends StatelessWidget {
  const GreenlandGamePage({required super.key});

  void submit() {}

  @override
  Widget build(BuildContext context) {
    return const McScaffold(
        source: 'ticketstogreenland',
        child: GreenlandGame(
          key: Key('greenland_game'),
        ));
  }
}

class GreenlandGame extends StatefulWidget {
  const GreenlandGame({super.key});

  @override
  State<GreenlandGame> createState() => _GreenlandGameState();
}

class _GreenlandGameState extends State<GreenlandGame> {
  bool submittable = false;
  int seed = 0;
  late final Timer timer;

  late GreenlandTicket ticket;
  late GreenlandTicket reference;

  @override
  void initState() {
    seed = _newSeed();
    ticket = GreenlandTicket.standard(seed: seed);
    reference = GreenlandTicket.standard(seed: seed);
    ticket.randomize();
    reference.stylize();
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), checkValidity);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  int _newSeed() => rNG.nextInt(1 + 30000000);

  void checkValidity(t) {
    if (mounted) {
      bool valid = ticket.meetsGuidelines();
      if (valid != submittable) {
        setState(() {
          submittable = valid;
        });
      }
    }
  }

  void submit() {
    if (mounted && submittable) {
      context.go('/search/wontickets');
    }
  }

  void reroll() {
    if (mounted) {
      setState(() {
        seed = _newSeed();
        ticket = GreenlandTicket.standard(seed: seed);
        reference = GreenlandTicket.standard(seed: seed);
        ticket.randomize();
        reference.stylize();
        dev.log('Seed $seed');
      });
    }
  }

  Widget submitButton(BuildContext context) {
    return FilledButton(
        onPressed: submittable ? submit : null,
        child: const Text(
          'Submit',
        ));
  }

  Widget seedButton(BuildContext context) {
    return FilledButton(onPressed: reroll, child: const Text('Randomize'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
            child: FittedBox(
                child: Column(
          children: [
            _SingleTicket(
              key: Key('Mod_$seed'),
              modifiable: true,
              ticket: ticket,
            ),
            const SizedBox(
              height: 25,
            ),
            _SingleTicket(
              key: Key('TicketReference_$seed'),
              modifiable: false,
              ticket: reference,
            )
          ],
        ))),
        // buttonPlacement(seedButton(context), 1),
        buttonPlacement(seedButton(context), 1),
        buttonPlacement(submitButton(context), 0),
      ],
    );
  }

  Widget buttonPlacement(Widget child, int n) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding:
                EdgeInsets.only(right: 16, bottom: 86 + 16 + (16 + 52.0) * n),
            child: SizedBox(width: 104, height: 52, child: child)));
  }
}

class _SingleTicket extends StatefulWidget {
  final bool modifiable;
  final GreenlandTicket ticket;
  const _SingleTicket(
      {super.key, required this.modifiable, required this.ticket});

  @override
  State<_SingleTicket> createState() => _SingleTicketState();
}

class _SingleTicketState extends State<_SingleTicket> {
  // late final GreenlandTicket ticket;
  GreenlandTicket get ticket => widget.ticket;
  @override
  void initState() {
    // ticket = GreenlandTicket.standard(seed: widget.seed);
    // if (widget.modifiable) {
    //   ticket.randomize();
    // } else {
    //   ticket.stylize();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    //Put in elements in type order

    for (ElementType type in ElementType.values) {
      //First type first
      for (int n = 0; n < ticket.objects.length; ++n) {
        if (ticket.objects[n].type == type) {
          children.add(DraggableTicket(
            key: Key('DrgTicket$n'),
            object: ticket.objects[n],
            modifiable: widget.modifiable,
          ));
        }
      }
    }

    return Center(
        child: Container(
            color: ticketPalette[0],
            width: 800,
            height: 400,
            alignment: Alignment.center,
            child: Stack(
              fit: StackFit.expand,
              children: children,
            )));
  }
}

class DraggableTicket extends StatefulWidget {
  final bool modifiable;
  final GreenlandObject object;

  const DraggableTicket({
    super.key,
    required this.object,
    required this.modifiable,
  });

  @override
  State<StatefulWidget> createState() {
    return _DraggableTicketState();
  }
}

class _DraggableTicketState extends State<DraggableTicket> {
  // late Offset _position;

  Widget _visElement(BuildContext context, GreenlandObject object) {
    return _TicketElement(
        object: object, key: Key("element${object.hashCode}"));
  }

  bool get modifiable => widget.modifiable;
  Offset get position => widget.object.offset;
  GreenlandObject get object => widget.object;

  set position(Offset set) {
    if (position != set) {
      setState(() {
        widget.object.offset = set;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!modifiable) {
      return Positioned(
          left: position.dx,
          top: position.dy,
          child: _visElement(context, object));
    }
    return AnimatedPositioned(
        key: Key('ticket_elemAnimPos_${object.hashCode}'),
        left: position.dx,
        top: position.dy,
        duration: const Duration(milliseconds: 30),
        child: Draggable(
            maxSimultaneousDrags: 1,
            dragAnchorStrategy: childDragAnchorStrategy,
            onDragUpdate: (details) {
              position = position + details.delta;
            },
            // onDragEnd: (d) => onDragEnd(d, card),
            childWhenDragging: _visElement(context, object),
            feedback: const SizedBox.shrink(),
            // feedback: CardHole(),
            child: _visElement(context, object)));
  }
}

class _TicketElement extends StatelessWidget {
  final GreenlandObject object;
  const _TicketElement({super.key, required this.object});

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    if (object.type == ElementType.rect) {
      return Container(
        decoration: BoxDecoration(
          color: ticketPalette[object.color],
          border: Border.all(color: borderColor),
        ),
        alignment: Alignment.center,
        width: 400,
        height: 100,
      );
    } else if (object.type == ElementType.divider) {
      return SizedBox(
          height: 50,
          child: Center(
              child: Container(
            decoration: const BoxDecoration(
              color: borderColor,
            ),
            alignment: Alignment.center,
            width: 400,
            height: 5,
          )));
    } else if (object.type == ElementType.icon) {
      Color iconColor = ticketPalette[0];
      return Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
            color: ticketPalette[object.color],
            border: Border.all(color: borderColor),
            shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(
          RpgAwesome.anchor,
          size: 50,
          color: iconColor,
        ),
      );
    } else if (object.type == ElementType.letter) {
      return Container(
        decoration: BoxDecoration(
          color: ticketPalette[0],
          border: Border.all(color: borderColor),
        ),
        // width: 30,
        // height: 50,
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        alignment: Alignment.bottomCenter,
        child: Text("T",
            style: bodyFont.copyWith(
                color: ticketPalette[2], height: 1.2, fontSize: 48)),
      );
    } else if (object.type == ElementType.text) {
      return Container(
        decoration: BoxDecoration(
          color: ticketPalette[3],
          border: Border.all(color: borderColor),
        ),
        // width: 30,
        // height: 50,
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        alignment: Alignment.bottomCenter,
        child: Text("Testimoney Element Concept",
            style: bodyFont.copyWith(
                color: ticketPalette[2], height: 1.2, fontSize: 24)),
      );
    }
    assert(false);
    return const Placeholder();
  }
}
