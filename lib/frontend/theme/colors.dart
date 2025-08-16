import 'package:flutter/material.dart';

class Primary extends MaterialColor {
  static const Color shade0 = Color(0xFF040210);
  //LibreOffice Background
  static const Color shade1 = Color(0xFF060615);
  static const Color shade2 = Color(0xFF0a0a1a);
  //TODO: curve this range
  static const Color shade3 = Color(0xFF110d24);
  static const Color shade4 = Color(0xFF130f36);
  static const Color shade5 = Color(0xFF25164a);
  static const Color shade6 = Color(0xFF321f4f);
  //TODO: These fall off faster than they seem
  static const Color shade7 = Color(0xFF38235c);
  static const Color shade8 = Color(0xFF422369);
  static const Color shade9 = Color(0xFF5a16a1);

  static const Color shadea = Color(0xFF5a36a1);
  static const Color shadeb = Color(0xFF8c56ff);
  static const Color shadec = Color(0xFF9f66ff);
  static const Color shaded = Color(0xFFbb8fff);
  static const Color shadee = Color(0xFFc0a0ff);
  static const Color shadef = Color(0xFFf5efff);
  //as above
  static const Color white = Color(0xFFf5efff);

  const Primary()
      : super(0xFF6c26ff, const {
          50: shade0,
          100: shade1,
          200: shade2,
          300: shade3,
          400: shade4,
          500: shade5,
          600: shade6,
          700: shade7,
          800: shade8,
          900: shade9,
          // 1000: shade9
        });
}

class BrightPrimary extends MaterialColor {
  ///Using the above to provide a MaterialColor
  const BrightPrimary()
      : super(0xFF060615, const {
          50: Primary.shade6,
          100: Primary.shade7,
          200: Primary.shade8,
          300: Primary.shade9,
          400: Primary.shadea,
          500: Primary.shadeb,
          600: Primary.shadec,
          700: Primary.shaded,
          800: Primary.shadee,
          900: Primary.shadef,
          // 1000: shade9
        });
}

class Secondary extends MaterialColor {
  ///Reduced saturation, on- the BG
  static const Color shade0 = Color(0xFF141220);
  static const Color shade1 = Color(0xFF161625);
  static const Color shade2 = Color(0xFF1a1a2a);
  static const Color shade3 = Color(0xFF1f1d30);
  static const Color shade4 = Color(0xFF231f44);
  static const Color shade5 = Color(0xFF352655);
  static const Color shade6 = Color(0xFF422f66);
  static const Color shade7 = Color(0xFF5843aa);
  static const Color shade8 = Color(0xFF6943bb);
  static const Color shade9 = Color(0xFF7a56ff);

  static const Color shadea = Color(0xFF8a66f1);
  static const Color shadeb = Color(0xFF9c66ff);
  static const Color shadec = Color(0xFFaf76ff);
  static const Color shaded = Color(0xFFcb9fff);
  static const Color shadee = Color(0xFFd1c1ff);
  static const Color shadef = Color(0xFFffefff);
  //as above
  static const Color white = Color(0xFFf5efff);

  const Secondary()
      : super(0xFF422f66, const {
          50: shade0,
          100: shade1,
          200: shade2,
          300: shade3,
          400: shade4,
          500: shade5,
          600: shade6,
          700: shade7,
          800: shade8,
          900: shade9,
          // 1000: shade9
        });
}

const Color canvasColor = Primary.shade2;

const Color canvasSlightElevation = Primary.shade3;
const Color canvasFade = Secondary.shadec;
const Color canvasLightGrey = Secondary.shadeb;

const Color onCanvas = Primary.shaded;
const Color canvasDisengage = Secondary.shade0;

class Tertiary extends MaterialColor {
  ///Reduced saturation, on- the BG
  static const Color shade0 = Color(0xff353527);
  //LibreOffice Background
  static const Color shade1 = Color(0xff353527);
  static const Color shade2 = Color(0xff515122);
  static const Color shade3 = Color(0xff515122);
  static const Color shade4 = Color(0xff87882d);
  static const Color shade5 = Color(0xff87882d);
  static const Color shade6 = Color(0xffb8ba47);
  static const Color shade7 = Color(0xffb8ba47);
  static const Color shade8 = Color(0xfffcfd9d);
  static const Color shade9 = Color(0xfffcfd9d);

  static const Color shadea = Color(0xFFf5f6a5);
  static const Color shadeb = Color(0xFFf5f6a5);
  static const Color shadec = Color(0xfffeffdc);
  static const Color shaded = Color(0xfffeffdc);
  static const Color shadee = Color(0xffffffff);
  static const Color shadef = Color(0xffffffff);
  //as above
  static const Color white = Color(0xFFf5efff);

  const Tertiary()
      : super(0xff87882d, const {
          50: shade0,
          100: shade1,
          200: shade2,
          300: shade3,
          400: shade4,
          500: shade5,
          600: shade6,
          700: shade7,
          800: shade8,
          900: shade9,
          // 1000: shade9
        });
}

//Ring of Power  color
const Color planColor = Color(0xffff6811);

// //Change these to PeterThiel
// const errorColor = Color(0xff7b6bff);
// const errorSecondary = Color(0xff5246ff);
// const errorHilite = Color(0xff7627ff);
// const errorBg = Color(0xff443d80);

//Change these to PeterThiel
const errorColor = Color(0xffff6811);
const errorMinor = Color(0xffffb789);

const onError = Color(0xff000000);
const errorBg = Color(0xff250c00);

const MaterialColor primary = Primary();

const Brightness brightness = Brightness.dark;

const String fallbackFamily = "Palatino";
