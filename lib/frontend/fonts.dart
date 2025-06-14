// const double fontScale = 2;

/*
Supposedly this is how to get variable weight fonts to work. 

FontWeight.values
  .map(
    (weight) => Text(
      'This text has weight $weight',
      style: TextStyle(
        fontVariations: [
          FontVariation(
              'wght', ((weight.index + 1) * 100).toDouble())
        ],
      ),
    ),
  )
  .toList(), 


*/

// const TextStyle bodyFont = TextStyle(
//     fontFamily: 'Palatino', fontSize: 12 * fontScale, color: textColor);
//
// // const TextStyle quoteFont = TextStyle(
// //     fontFamily: 'Palatino', fontSize: 12 * fontScale, color: quoteColor);
//
// const TextStyle bodyItalicFont = TextStyle(
//   fontFamily: 'Palatino',
//   fontSize: 12 * fontScale,
//   fontStyle: FontStyle.italic,
//   color: textColor,
// );
//
// const TextStyle bodyBoldFont = TextStyle(
//     fontFamily: 'Palatino',
//     fontSize: 12 * fontScale,
//     fontWeight: FontWeight.w700,
//     color: textColor);
//
// const TextStyle bodyBoldItalicFont = TextStyle(
//     fontFamily: 'Palatino',
//     fontSize: 12 * fontScale,
//     fontStyle: FontStyle.italic,
//     fontWeight: FontWeight.w700,
//     color: textColor);
//
// TextStyle titleFont = GoogleFonts.rubik(
//     fontSize: 42 * fontScale,
//     fontWeight: FontWeight.w700,
//     fontStyle: FontStyle.italic,
//     color: Colors.white);
//
// TextStyle headerFont = GoogleFonts.bebasNeue(
//     fontSize: 20 * fontScale, fontWeight: FontWeight.w700, color: Colors.white);
//
// TextStyle subtitleFont = GoogleFonts.rubik(
//     fontSize: 28 * fontScale, fontWeight: FontWeight.w500, color: Colors.white);
//
// TextStyle docuFont =
//     GoogleFonts.courierPrime(fontSize: 12 * fontScale, color: emphColor);
//
// TextStyle monoFont() =>
//     GoogleFonts.courierPrime(fontSize: 12 * fontScale, color: textColor);
//
// TextStyle monoQuoteFont() => GoogleFonts.courierPrime(
//     fontSize: 12 * fontScale, color: const Color(0xff87ce25));
//
// TextStyle monoBgFont =
//     GoogleFonts.courierPrime(fontSize: 12 * fontScale, color: fadeColor);
//
// TextStyle symbolFont =
//     GoogleFonts.notoSans(fontSize: 12 * fontScale, color: textColor);
//
// TextStyle nullFont =
//     GoogleFonts.comicNeue(fontSize: 24 * fontScale, color: Colors.red);
//
// const TextStyle staffFont = TextStyle(
//     fontFamily: 'Papyrus', fontSize: 14 * fontScale, color: Color(0xff5863c9));
// //0xff44dd66
// TextStyle authorFont =
//     GoogleFonts.notoSans(fontSize: 12 * fontScale, color: textColor);
