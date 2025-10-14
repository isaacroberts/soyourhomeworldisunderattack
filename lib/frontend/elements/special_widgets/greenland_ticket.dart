import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<Color> ticketPalette = [
  Color(0xff5d4fa1),
  Color(0xffb0bbff),
  Color(0xffd5e0ff),
  Color(0xff544077),
  Color(0xff99f7ff),
  Color(0xffaa99ff),
  Color(0xffffaacc),
];
const Color borderColor = Color(0xff361f5e);

ElementType randomElementType({required math.Random rng}) {
  return ElementType.values[rng.nextInt(ElementType.values.length)];
}

enum ElementType {
  rect,
  divider,

  letter,
  icon,
  text,
  ;

  double get width {
    switch (this) {
      case ElementType.rect:
        return 400;
      case ElementType.divider:
        return 400;
      case ElementType.text:
        return 200;
      case ElementType.letter:
        return 30;
      case ElementType.icon:
        return 75;
    }
  }

  double get height {
    switch (this) {
      case ElementType.rect:
        return 100;
      case ElementType.divider:
        return 10;
      case ElementType.text:
        return 50;
      case ElementType.letter:
        return 50;
      case ElementType.icon:
        return 75;
    }
  }

  bool get collides {
    switch (this) {
      case ElementType.rect:
        return false;
      case ElementType.letter:
      case ElementType.divider:
      case ElementType.icon:
      case ElementType.text:
        return true;
    }
  }
}

class GreenlandObject extends ChangeNotifier {
  ElementType _type = ElementType.rect;
  dynamic _data;
  int color = 2;

  Offset offset;

  @override
  String toString() {
    return '$type $color';
  }

  GreenlandObject.randomize({required math.Random rng, required this.offset})
      : _type = randomElementType(rng: rng),
        color = 1 + rng.nextInt(ticketPalette.length - 1);

  ElementType get type => _type;
  Rect get rect => Rect.fromLTWH(offset.dx, offset.dy, type.width, type.height);

  set type(t) {
    //TODO: Finish
    _type = t;
    notifyListeners();
    throw UnimplementedError();
  }

  get data => _data;
  set data(var s) {
    _data = s;
    notifyListeners();
  }
}

class GreenlandTicket {
  final double width;
  final double height;
  final int seed;

  List<GreenlandObject> objects = [];
  math.Random rng;

  GreenlandTicket.standard({this.seed = 0})
      : width = 800,
        height = 400,
        rng = math.Random(seed);
  GreenlandTicket.phone({this.seed = 0})
      : width = 400,
        height = 400,
        rng = math.Random(seed);

  operator [](int ix) => objects[ix];

  // Internals

  double rx([double headroom = 0]) =>
      15 + rng.nextDouble() * (width - 30 - headroom);
  double ry([double headroom = 0]) =>
      15 + rng.nextDouble() * (height - 30 - headroom);

  void randomize() {
    baseGeneration();
    for (GreenlandObject obj in objects) {
      obj.offset = Offset(rx(obj.type.width), ry(obj.type.height));
    }
  }

  bool meetsGuidelines() {
    if (hasAnyCollisions()) {
      dev.log("Collision");
      return false;
    }
    for (int a = 0; a < objects.length; ++a) {
      Rect rect = objects[a].rect;

      if (rect.left < 15 ||
          rect.top < 15 ||
          rect.right > width - 15 ||
          rect.bottom > height - 15) {
        dev.log("Item $a OOB: $rect");
        return false;
      }
    }
    dev.log("Great work!");
    return true;
  }

  bool hasAnyCollisions() {
    for (int a = 0; a < objects.length; ++a) {
      if (objects[a].type.collides) {
        Rect arect = objects[a].rect;
        for (int r = a + 1; r < objects.length; ++r) {
          if (objects[r].type.collides) {
            if (arect.overlaps(objects[r].rect)) {
              // dev.log("${objects[r]} collides ${objects[a]}");
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  bool hasCollisions(GreenlandObject obj, [int originN = 0]) {
    Rect rect = obj.rect;
    for (int r = 0; r < originN; ++r) {
      if (objects[r].type.collides) {
        if (objects[r] != obj) {
          if (objects[r].rect.overlaps(rect)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void baseGeneration() {
    int elementCt = 7;
    objects.clear();

    while (objects.length < elementCt) {
      GreenlandObject obj =
          GreenlandObject.randomize(rng: rng, offset: Offset.zero);
      objects.add(obj);
    }
  }

  void stylize() {
    baseGeneration();

    double randFrac() {
      int num = 1 + rng.nextInt(3);
      return (1 + rng.nextInt(num)) / num;
    }

    double rfx() => randFrac() * (width - 30) + 15;
    double rfy() => randFrac() * (height - 30) + 15;

    //Pick graphic design guidelines
    List<double> xs = List.generate(1 + rng.nextInt(2), (i) => rfx());
    List<double> ys = List.generate(2 + rng.nextInt(5), (i) => rfy());

    xs.insert(0, 15);
    ys.insert(0, 15);

    //Pick from guidelines
    double lrx() => xs[rng.nextInt(xs.length)];
    double lry() => ys[rng.nextInt(ys.length)];

    for (int n = 0; n < objects.length; ++n) {
      //Avoid colliding
      objects[n].offset = const Offset(-1000, -1000);
    }

    for (int n = 0; n < objects.length; ++n) {
      GreenlandObject obj = objects[n];

      bool allowed = false;
      int fails = 0;

      while (!allowed && fails < 200) {
        //Check OOB
        double x = lrx();
        double y = lry();
        //Rectify
        if (x + obj.type.width + 30 > width) {
          x = width - obj.type.width - 15;
        }
        while (y + obj.type.height + 30 > height) {
          y = lry();
        }
        allowed = true;

        obj.offset = Offset(x, y);

        //Check collisions
        if (hasCollisions(obj, n)) {
          allowed = false;
        }
        fails++;
      }
    }
  }
}
