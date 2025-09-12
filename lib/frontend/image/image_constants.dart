import 'dart:ui';

const double standardImageWidth = 600;
const double standardImageHeight = 400;
//standardImageAspectRatio = 1.5
const double standardImageAspectRatio =
    standardImageWidth / standardImageHeight;
//TODO: Figure out a reasonable value based on my 2000x image sizes
const double standardImageByteSize = 10000;

class ColorHint {
  final Color? hint0, hint1, hint2;
  ColorHint.constructed(
      {required Color? bg, required Color? outline, required Color? onBg})
      : hint0 = bg,
        hint1 = outline,
        hint2 = onBg;

  ColorHint.fromList(List<Color?> colors)
      : hint0 = colors.elementAtOrNull(0),
        hint1 = colors.elementAtOrNull(1),
        hint2 = colors.elementAtOrNull(2);

  Color? get bgColor => hint0;
  Color? get outlineColor => hint1;
  Color? get foreColor => hint2;

  bool get hasAny {
    return hint0 != null || hint1 != null || hint1 != null;
  }

  bool get hasAll {
    return hint0 != null && hint1 != null && hint1 != null;
  }

  String hex(Color? c) {
    if (c == null) {
      return '_';
    }
    return c.toARGB32().toRadixString(16);
  }

  @override
  String toString() {
    return "ColorHint: [ b ${hex(hint0)} o ${hex(hint1)} f ${hex(hint2)}]";
  }

  @override
  bool operator ==(Object other) {
    if (other is ColorHint) {
      return hint0 == other.hint0 &&
          hint1 == other.hint1 &&
          hint2 == other.hint2;
    }
    return false;
  }

  @override
  int get hashCode {
    //TODO: This is a little odd
    return (hint0?.toARGB32() ?? 0) * 0x100000000 +
        (hint1?.toARGB32() ?? 0) * 0x10000 +
        (hint2?.toARGB32() ?? 0);
  }
}
