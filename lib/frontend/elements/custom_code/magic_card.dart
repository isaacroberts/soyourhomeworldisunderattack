import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/binary_utils/code_params.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

import '../holders/holder_base.dart';

enum ManaColor {
  //WUBRG
  white,
  blue,
  black,
  red,
  green;

  String get char {
    switch (this) {
      case ManaColor.white:
        return 'W';
      case ManaColor.blue:
        return 'U';
      case ManaColor.black:
        return 'B';
      case ManaColor.red:
        return 'R';
      case ManaColor.green:
        return 'G';
    }
  }

  Color get color {
    switch (this) {
      case ManaColor.white:
        return const Color(0xffeae0d1);
      case ManaColor.blue:
        return const Color(0xff0d2985);
      case ManaColor.black:
        return const Color(0xff112233);
      case ManaColor.red:
        return const Color(0xffec1f1f);
      case ManaColor.green:
        return const Color(0xff0b6713);
    }
  }

  IconData get iconData {
    switch (this) {
      case ManaColor.white:
        return RpgAwesome.sickle;
      case ManaColor.blue:
        return RpgAwesome.droplet;
      case ManaColor.black:
        return RpgAwesome.skull;
      case ManaColor.red:
        return RpgAwesome.candle_fire;
      case ManaColor.green:
        return RpgAwesome.zigzag_leaf;
    }
  }

  Widget buildPip(BuildContext context) {
    Color color = this.color;
    return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle),
        child: Icon(
          iconData,
          color: Colors.white,
        ));
  }
}

enum MtgCardback {
  artifact,
  white,
  blue,
  black,
  red,
  green,
  wu,
  wb,
  wr,
  wg,
  ub,
  ur,
  ug,
  br,
  bg,
  rg,
  tricolor,
  error
}

//TODO: Defer
MtgCardback monoCardbacks(ManaColor pip) {
  switch (pip) {
    case ManaColor.white:
      return MtgCardback.white;
    case ManaColor.blue:
      return MtgCardback.blue;
    case ManaColor.black:
      return MtgCardback.black;
    case ManaColor.red:
      return MtgCardback.red;
    case ManaColor.green:
      return MtgCardback.green;
  }
}

//TODO: Defer
MtgCardback dualCardBacks(ManaColor pip1, ManaColor pip2) {
  if (pip1 == pip2) {
    //Mono
    return monoCardbacks(pip1);
  }
  //TODO: Check polarity
  if (pip1.index > pip2.index) {
    //Swap so I don't have to type back-directions
    (pip1, pip2) = (pip2, pip1);
  }
  switch (pip1) {
    case ManaColor.white:
      switch (pip2) {
        case ManaColor.blue:
          return MtgCardback.wu;
        case ManaColor.black:
          return MtgCardback.wb;
        case ManaColor.red:
          return MtgCardback.wr;
        case ManaColor.green:
        default:
          return MtgCardback.wg;
      }
    case ManaColor.blue:
      switch (pip2) {
        case ManaColor.black:
          return MtgCardback.ub;
        case ManaColor.red:
          return MtgCardback.ur;
        case ManaColor.green:
        default:
          return MtgCardback.ug;
      }
    case ManaColor.black:
      switch (pip2) {
        case ManaColor.red:
          return MtgCardback.br;
        case ManaColor.green:
        default:
          return MtgCardback.bg;
      }
    case ManaColor.red:
      return MtgCardback.rg;

    default:
      return MtgCardback.error;
  }
}

//TODO: Defer
MtgCardback getCardBack(List<ManaColor> pips) {
  switch (pips.length) {
    case 0:
      return MtgCardback.artifact;
    case 1:
      //monos
      return monoCardbacks(pips[0]);
    case 2:
    //Duals
    default:
      return MtgCardback.tricolor;
  }
}

class ManaCost {
  final int uc;
  final List<ManaColor> pips;
  int get total => pips.length;
  bool get isColorless => pips.isEmpty;
  Set<ManaColor> get totalColors => pips.toSet();
  // bool get isDualColor =>

  const ManaCost({required this.uc, required this.pips});

  factory ManaCost.fromString(String text) {
    return ManaCost.monocolor(uc: 1, color: ManaColor.green);
  }

  ManaCost.monocolor({required this.uc, required ManaColor color})
      : pips = [color];

  @override
  String toString() {
    return "$uc ${pips.map((p) => p.char)}";
  }
}

///There is exactly one MtG card in the book
class MtgCardHolder extends JsonCodeHolder {
  MtgCardHolder({required super.params})
      : cost = ManaCost.fromString(params.dict['Cost']);

  final ManaCost cost;
  String get name => data['Name'];
  String get typeline => data['Type'];
  String get rulesText => data['Rules'];
  String get flavorText => data['Flavor'];

  //Example
  MtgCardHolder.example()
      : cost = ManaCost.monocolor(uc: 1, color: ManaColor.green),
        super(
            params: const CodeParams.dict({
          'Name': 'Bear',
          'Type': 'Animal - Bear',
          'Rules': '[>]: Attack',
          'Flavor': 'Rawwrr'
        }));
  @override
  Widget sliver(BuildContext context) {
    return SliverConstrainedCrossAxis(
        maxExtent: 360 + 12 * 2,
        sliver: SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            sliver: SliverToBoxAdapter(child: element(context))));
  }

  @override
  Widget element(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Color(0xff351c0c),
            // border: Border.all(color: Color(0xff000000)),
            borderRadius: BorderRadius.circular(7.5)),
        child: Container(
          width: 360,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color(0xff2c3f6a),
              // border: BoxBorder.all(
              //   color: Color(0xff385baa),
              // ),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              topLine(context),
              const SizedBox(height: 12),
              image(),
              //Includes padding
              typelineWidget(context),
              _CardText(rulesText: rulesText, flavorText: flavorText)
            ],
          ),
        ));
  }

  Widget topLine(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0x22000000),
          border: Border.all(color: Color(0x44000000)),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        height: 24 + 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [Text(name), Text(cost.toString())],
        ));
  }

  Container image() {
    return Container(
      height: 148,
      decoration: BoxDecoration(
          color: Color(0x80000000),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0x80000000))),
    );
  }

  Widget typelineWidget(BuildContext context) {
    return SizedBox(
        height: 36,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child:
                Align(alignment: Alignment.centerLeft, child: Text(typeline))));
  }

  @override
  String toText() {
    return "[[$name ($cost) \n|\n$rulesText\n|\n$flavorText\n\t]]";
  }
}

class _CardText extends StatelessWidget {
  final String rulesText;
  final String flavorText;
  const _CardText(
      {super.key, required this.rulesText, required this.flavorText});

  @override
  Widget build(BuildContext context) {
    TextStyle body = Theme.of(context).textTheme.bodyMedium ?? TextStyle();
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0x44000000),
            border: Border.all(color: const Color(0x44000000)),
            borderRadius: BorderRadius.circular(6)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: Enters should be double-enter
              Text(rulesText),
              SizedBox(height: 12),
              Text(
                flavorText,
                style: body.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ));
  }
}
