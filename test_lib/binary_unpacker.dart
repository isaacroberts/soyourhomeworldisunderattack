import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';

import 'live_text_holder.dart';
import 'text_data_structures.dart';

import 'chapter_data.dart';
import 'generated/index.dart';

enum QuoteLevels { text, params, list }

enum Codes {
  LPAREN(40),
  RPAREN(41),
  DQUOTE(34),
// #(35),
  DOLLARSIGN(36),
// %(37),
  AMPERSAND(38),
  APOSTROPHE(39),
  STAR(42),
  PLUS(43),
  COMMA(44),
  DASH(45),
  DOT(46),
  FWDSLASH(47),
  DIGIT0(48),
  COLON(58),
  SEMICOLON(59),
  LGATOR(60),
  EQ(61),
  RGATOR(62),
  QUESTIONMARK(63),
  ATSIGN(64),

  //Letters
  CAPITALA(65),


  NChar(78),

  //Syms
  LSQR(91),
  BACKSLASH(92),
  RSQR(93),
  CARAT(94),
// _(95),
// `(96),
  LOWERA(97),
  LBRACE(123),
  BAR(124),
  RBRACE(125),
  TILDE(126),


  ;

  final int code;
  const Codes(this.code);

}

String CHR(int x) {
  return String.fromCharCode(x);
}

class BufferPtr {
  int start = 0;
  int length = 0;
  final ByteBuffer buffer;
  late ByteData region;
  BufferPtr(this.buffer, {this.start = 0, int? length}) {
    print('New BufferPtr: Start $start len $length buffer ${buffer.lengthInBytes}');
    region = buffer.asByteData(start, length);
    this.length = length ?? buffer.lengthInBytes;
    print('\t New region: ${region} ${region.offsetInBytes}');
  }

  void update() {
    region = buffer.asByteData(start, length);
  }

  String toStr() {
  return "[$start-${start+length} / ${buffer.lengthInBytes}]";
  }

  bool hasMore() {
    return length > 0;
  }

  int get lengthInBytes => length;

  BufferPtr subset(int offset, int len) {
    return BufferPtr(buffer, start: start + offset, length: len);
  }

  int getUint8([int offset = 0]) {

    return region.getUint8(offset);
  }

  int getInt32([int offset = 0]) {
    return region.getInt32(offset);
  }

  int getInt64([int offset = 0]) {
    return region.getInt64(offset);
  }

  double getFloat32([int offset = 0]) {
    return region.getFloat32(offset);
  }

  Uint8List toIntList() {
    return buffer.asUint8List(start, length);
  }

  void consume(int amt) {
    start += amt;
    length -= amt;
    update();
  }

  BufferPtr grabTokens(int amt) {
    var s = subset(start, amt);
    start += amt;
    length -= amt;
    update();
    return s;
  }

  BufferPtr grabUntil(int charCode) {
  print("I'm grabbing. ${toStr()}");
  print('Region: ${region} ${region.offsetInBytes}');

    int i = 0;
    print('Buffer grabbing: ${toIntList()}');

    while (i < length) {
      int d = getUint8(i);
      print('Grabbin over: $d');// ${CHR(d)}');
      if (d == charCode) {
        print('Char code $d ${charCode} ${CHR(charCode)} matched at $i (${i+start})');
        print('Subset: $start - ${start+i}');
        var s = subset(0, i);
        start += i+1;
        length -= i+1;
        update();
        print ("Done!");
        return s;
        // return buffer.asByteData(i0, i);
      }
      else {
      //print('Ignore $d ${charCode} at $i (${i+start})');

      }
      i++;
    }
    print('Missed char code ${charCode} on ${toIntList()} ($start $length)');

    start = length;
    length = 0;
    update();
    throw ("Run out of buffer on grabUntil");
    return subset(0, region.lengthInBytes);
  }
}

class ChapterLoader {
  final int number=69;
  String filename;


  LoadStatus _loadStatus = LoadStatus.unloaded;

  HeaderOfText? header;
  List<TextHolder> lines = [];
  EndOfChapterText? endWidget;

  double loadPct = 0;
  int loadPos = 0;

  //TODO: Figure out how to make this private
  ChapterLoader(this.filename);

  LoadStatus get loadStatus => _loadStatus;
  bool get loaded => _loadStatus == LoadStatus.loaded;
  bool get loading => _loadStatus == LoadStatus.loading;

  /*
  Loaders
   */

  LoadStatus load() {
    print('loadin!!g');

    _loadStatus = LoadStatus.loading;
    readFile();

    if (lines.isEmpty) {
      return LoadStatus.error;
    }

    header ??= const HeaderOfText('Header');

    if (lines.last is EndOfChapterText) {
      endWidget = lines.last as EndOfChapterText;
    } else {
      print('Empty chapter ender');
      endWidget = EndOfChapterText(number);
    }
    _loadStatus = LoadStatus.loaded;
    print('Loaded successfully');
    return LoadStatus.loaded;
  }

    void readFile() async {
      print('start read');
      String path = filename;
      print('path = $path');
      File f = File(path);

      parseData(f.readAsBytesSync());

      print(' File ${f.path} ${f.length()}');

      for (var line in lines) {
      print("Line: ${line.runtimeType} ${line.totext()}");
      }


    }

  FutureOr<LoadStatus> parseData(Uint8List list) async {

    lines = [];

    lines.insert(0, const BodyTextElement("Yuck Fou"));
    print('parsing ${list.length}');

    int i = 0;

    ByteBuffer buff = list.buffer;
    BufferPtr ptr = BufferPtr(buff);

    // bytes.getInt8(byteOffset)

    String str = '';

    LiveTextHolder liveHolder = LiveTextHolder();
    /*
      Can be:
        R - implicit - regular
          ( TA&font)
        T - code tag
          ( -> ??
        C - Code span
        N - newline
          x (
        P - pagebreak
          x (
        S - MultiSpan
        ( ta )
    */
    String elemType;

    while (ptr.hasMore()) {
      int val = ptr.getUint8();
      ptr.consume(1);

      String char = String.fromCharCode(val);
      print("Symbol: $i $val $char");

      if (val == 10) {
        print('Mystery 10 char');
      }
      // ;
      else if (val == Codes.SEMICOLON.code) {
        print('Element finished');
        print(liveHolder.text);
          TextHolder holder = liveHolder.convert();
          lines.add(holder);
          liveHolder = LiveTextHolder();
      }
      // {
      else if (val == Codes.LBRACE.code) {
        print('Ptr: ${ptr.toStr()}');

        BufferPtr textBin = ptr.grabUntil(Codes.RBRACE.code);
        print('Grabbed string');
        Uint8List list = textBin.toIntList();
        print('List: $list');
        print('Text Region: ${textBin.toStr()}');
        print('Main ptr: ${ptr.toStr()}');
        //for (int ix in list) {
        //  print("$ix : ");
        //  String char = String.fromCharCode(ix);
        //  print("   = $char");
        //}
        print('Done');

        liveHolder.text = utf8.decode(textBin.toIntList(), allowMalformed:true);
        print("String ${liveHolder.text}");

      }
      // (
      else if (val == Codes.LPAREN.code) {
        /*
        Consume entire () set and assume it's properly formed
        TODO: Send results of () reader to a function that matches param amounts to different types of
           objects,

            instaniateObject(tabs, align, font?, color? hilite?)
              -> if ladder
        */

        BufferPtr fontData = ptr.grabUntil(Codes.RPAREN.code);
        liveHolder.parseFont(fontData);

        } else if (val == Codes.NChar.code) {

        ptr.consume(1);
        double height = ptr.getFloat32();
        print('Newline height = $height');
        ptr.consume(4);
        lines.add(BlankOfText(height: height));

      } else if ('}])'.contains(char)) {
      print('');
        print('ERROR Unmatched close value $char');
        print('');
        //assert(false);

        return LoadStatus.error;
      } else {
        print('Please handle $char $val');
        return LoadStatus.error;
      }
      i += 1;
      // i = data.length;
    }

    print("Extracted string: $str");

    return LoadStatus.loaded;
  }

  //File reader

  void onFileReadError(object, StackTrace trace) {
    print("FILE read ERROR");
    throw trace;
    // trace.toString()
  }

  void onFileReadDone() {
    print('File read done.');
  }

  int get length => lines.length;

  TextHolder? operator [](int ix) {
    // if (ix == 0) {
    //   return header;
    // }
    // // ix -= 1;
    if (ix < lines.length) {
      return lines[ix];
      // }
      // else if (ix == lines.length) {
      //   return endWidget;
    } else {
      return null;
    }
  }

  //Utility

}

/*
-- struct values --
? = bool
B = short unsigned int
i = int
I = unsigned int
q = long int
f = float
c = char
x = none

-- custom --
{ = string
K = key (4s)
H = hex = BBBB

*/

(dynamic, int) unpackValue(BufferPtr data) {
  // Data is arbitrarily long
  String typechar = String.fromCharCode(data.getUint8(0));

  switch (typechar) {
    case '?':
      return (data.getUint8(1) != 0, 2);
    case 'B':
      return (data.getUint8(1), 2);
    case 'i':
      return (data.getInt32(1), 5);
    case 'q':
      return (data.getInt64(1), 9);
    case 'f':
      return (data.getFloat32(1), 5);
    case 'c':
      int v = data.getUint8(1);
      return (String.fromCharCode(v), 2);
    case '{':
      int i = 1;
      while (i < data.lengthInBytes) {
        if (data.getUint8(i) == Codes.RBRACE.code) {
          return ("FUCK", i + 1);
        }
        i++;
      }
    // TODO: Improve this
    // String s = ;

    case 'H':
      int a = data.getUint8(1);
      int r = data.getUint8(2);
      int g = data.getUint8(3);
      int b = data.getUint8(4);
      int hex = (a >> 24) + (r >> 16) + (g >> 8) + b;
      return (hex, 5);
    case 'x':
      // TODO: Check that this consumes one extra bit
      return (null, 2);
  }
  return (null, 1);
}
