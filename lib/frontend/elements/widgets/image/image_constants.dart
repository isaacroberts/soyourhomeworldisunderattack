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
  Color? get loaderColor => hint2;

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
}
