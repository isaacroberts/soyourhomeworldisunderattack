import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import '../frontend/elements/custom_code/custom_code_router.dart';
import '../frontend/elements/holders/textholders.dart';
import 'binary_utils/binary.dart';
import 'binary_utils/buffer_ptr.dart';
import 'chapter.dart';
import 'error_handler.dart';
import 'live_text_holder.dart';

const bool printVerbose = false;

class ChapterParser {
//Modified in-place
  final String debugId;

  // int index = -1;
  // String id = 'ERR';
  // String? audioUrl;
  BufferPtr ptr;

  ChapterParser({required this.debugId, required this.ptr});

  Future<Chapter> parseChapter({required String filename}) async {
    dev.log("Parsing $filename (parse)");
    if (!ptr.hasMore()) {
      throw ChapterFormatException("Empty BufferPtr sent to parsePtr",
          debugId: debugId);
    }
    ChapterInfo info = await parseHeader(filename: filename);
    Stream<Holder> spans = parseBody();
    return Chapter.fromChapterInfoAndStream(info, spans);
  }

  Future<Chapter> parseWithExistingChapterInfo(ChapterInfo info,
      {required bool handleErrors}) async {
    dev.log("Parsing ${info.varName} (fromExisting)");
    if (!ptr.hasMore()) {
      throw ChapterFormatException("Empty BufferPtr sent to parsePtr",
          debugId: debugId);
    }
    skipToHeaderSeparator();
    Stream<Holder> spans;
    if (handleErrors) {
      spans = parseBodyAndCatchErrors();
    } else {
      spans = parseBody();
    }
    return Chapter.fromChapterInfoAndStream(info, spans);
  }

  Future<ChapterInfo?> parseBookHeader(int index) async {
    // if (!ptr.consumeIf('(')) {
    //   return null;
    // }
    ptr.assertConsume('(', debugId: '?');

    int? index = ptr.consumeTypedInt()!;
    ptr.assertConsume('=', debugId: 'Chapter$index');
    // bin += pack_text(chapter.span.id)
    String? varName = ptr.consumeText();
    if (varName == null) {
      return null;
    }
    // bin += ':'
    ptr.assertConsume(':', debugId: varName);
    // ptr += pack_text(chapter.span.display_name)
    String? displayName = ptr.consumeText();
    // ptr += '@'
    ptr.assertConsume('@', debugId: varName);
    // ptr += pack_text(chapter.span.filename())
    String? filename = ptr.consumeText();
    if (filename == null) {
      return null;
    }
    ptr.assertConsume('>', debugId: varName);
    int? nextId = ptr.consumeTypedInt();

    // ptr += '*'
    ptr.assertConsume('*', debugId: varName);
    // ptr += pack_untyped_uint(file_size)
    int filesize = ptr.consumeUint32();
    // ptr += ')'
    ptr.assertConsume(')', debugId: varName);
    // ptr += ';'
    ptr.assertConsume(';', debugId: varName);

    return ChapterInfo(
        id: index,
        displayName: displayName ?? '[$varName]',
        filename: filename,
        varName: varName,
        next: nextId);
  }

  Future<ChapterInfo> parseHeader({required String filename}) async {
    ptr.assertConsume('\$', debugId: debugId);
    int index = ptr.consumeInt32();
    ptr.warnConsume('=', consumeOnMiss: true);
    String id = ptr.consumeText()!;
    ptr.warnConsume('/', consumeOnMiss: true);
    String? display = ptr.consumeText();
    ptr.warnConsume('/', consumeOnMiss: true);
    //Some chapters have audio
    String? audioUrl;
    if (ptr.getChar() == '_') {
      audioUrl = null;
      ptr.consume(1);
    } else {
      audioUrl = ptr.consumeUrl();
    }
    ptr.assertConsume('/', debugId: debugId);
    skipToHeaderSeparator();
    if (printVerbose) {
      dev.log('/Read header $debugId');
    }
    return ChapterInfo(
        id: index,
        varName: id,
        displayName: display ?? '_$id',
        filename: filename,
        next: null);
  }

  void skipToHeaderSeparator() {
    const String endHeaderToken = 'zoinks&';
    // consume Z first. If not, continue eating ampersands.
    bool finished = false;
    while (!finished && ptr.hasMore()) {
      ptr.consumeUntil(Codes.AMPERSAND);
      finished = ptr.consumeIfAsciiString(endHeaderToken);
    }
    ptr.consumeIf(Codes.NEWLINE);
  }

  Stream<Holder> parseBody() async* {
    while (ptr.hasMore()) {
      yield readOneHolder();
    }
  }

  Stream<Holder> parseBodyAndCatchErrors() async* {
    int errorCt = 0;
    while (ptr.hasMore()) {
      try {
        yield readOneHolder();
      } catch (excep, trace) {
        //Add element
        dev.log(excep.toString(), stackTrace: trace);
        yield ExceptionHolder(exception: excep, stackTrace: trace);
        //Max retries
        if (errorCt >= 3) {
          return;
        }
        errorCt++;
        //Skip to next semicolon
        skipBrokenHolder();
      }
    }
  }

  Iterable<Holder> parseHolders() sync* {
    while (ptr.hasMore()) {
      yield readOneHolder();
    }
  }

  Holder readOneHolder() {
    /*
Elements:
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

    LiveTextHolder liveHolder = LiveTextHolder();

    while (ptr.hasMore()) {
      int val = ptr.consumeUint8();
      String char = String.fromCharCode(val);
      if (printVerbose) {
        dev.log("Read char '$char' (${ptr.start})");
      }
      if (val == 0) {
        // \0
        if (ptr.hasMore()) {
          throw ChapterFormatException("Null terminator in middle of binary",
              debugId: debugId);
        }
      } else if (val == Codes.NEWLINE.code) {
        //Skip newline character
        // ErrorList.registerWarning('Newline in chapter binary (id=$debugId');
      } else if (val == Codes.SEMICOLON.code) {
        if (printVerbose) {
          dev.log('Instantiate holder ${liveHolder.text}');
        }
        return liveHolder.instantiate();
      } else if (val == Codes.LBRACE.code) {
        // { String
        liveHolder.text = ptr.consumeText(leadingQuoteAlreadyParsed: true)!;

        if (printVerbose) {
          dev.log("Read string ${liveHolder.text}");
        }
      } else if (val == Codes.LPAREN.code) {
        // ( Beginning of font or parameters
        // TODO: Give parameter list to LiveTextHolder
        // BufferPtr fontData =
        //     ptr.consumeUntil(Codes.RPAREN.code, includeChar: true);
        ptr = liveHolder.font.parseDecorations(ptr);
      } else if (char == 'H') {
        String? text = ptr.consumeText();
        if (text == null) {
          throw ChapterFormatException("No text in header", debugId: debugId);
        }
        liveHolder.text = text;
        ptr = liveHolder.parseFont(ptr);
        ptr.assertConsume(Codes.SEMICOLON, debugId: debugId);
        return liveHolder.instantiateHeader();
      } else if (char == 'S') {
        return parseMultiSpan();
      } else if (char == 'N') {
        // N: Newline element
        // TODO: Check current LiveHolder text to make sure it's empty
        // TODO: Change newline to untyped float
        double height = ptr.consumeFloat32();

        if (printVerbose) {
          dev.log('Newline height = $height');
        }
        if (height > 2000) {
          handleStaticWarning(
              'Oversized newline in chapter $debugId binary $height (pos=${ptr.start}');
          height = 2000;
        }
        //Consume ;
        ptr.consume(1);
        return NewlineElement(height: height);
      } else if (char == 'b') {
        return parseColoredBoxHolder();
      } else if (char == 'P') {
        String? typechar = ptr.consumeTypedChar();
        if (typechar != null) {
          //TODO: Use the type

          if (printVerbose) {
            dev.log('Pagebreak type = $typechar');
          }
          return const PageBreakOfText();
        }
      } else if (char == 'C') {
        var holder = getCustomCodeElement(
          CodeElementType.codeBlock,
        );
        ptr.assertConsume(Codes.SEMICOLON, debugId: debugId);
        return holder;
      } else if (char == 'T') {
        var holder = getCustomCodeElement(
          CodeElementType.codeTag,
        );
        ptr.assertConsume(Codes.SEMICOLON, debugId: debugId);
        return holder;
      } else if (char == 'D') {
        var holder = getCustomCodeElement(
          CodeElementType.parsedCodeElement,
        );
        ptr.assertConsume(Codes.SEMICOLON, debugId: debugId);
        return holder;
      } else if (')}]>'.contains(char)) {
        //)}]>
        // dev.log('Unmatched close value $char');
        throw ChapterFormatException(
            "Unmatched paren $char in chapter binary (pos=${ptr.start})",
            debugId: debugId);
      } else {
        // dev.log('Please handle $char');
        throw ChapterFormatException(
            "Unhandled char $char (code=$val pos=${ptr.start}) in chapter binary",
            debugId: debugId);
      }
    }
    ErrorList.logError(ChapterFormatException(
        'Unterminated TextHolder (pos=${ptr.start}; liveHolder=$liveHolder)',
        debugId: debugId));
    return liveHolder.instantiate();
  }

  void skipBrokenHolder() {
    ptr.consumeUntil(';');
  }

  SpanOfText parseMultiSpan() {
    LiveSpanOfText span = LiveSpanOfText();

    //Read tab/align
    if (ptr.consumeIf('(')) {
      //is this still being used?
      // int length =
      ptr.consumeInt32();
      //tab:i
      span.tabs = ptr.consumeUint8();
      //align: c
      span.align = stringToAlign(ptr.consumeChar());

      // )
      if (ptr.consumeIf(')')) {
      } else {
        String foundChar = ptr.getChar();
        throw ChapterFormatException(
            "Unmatched ( in ChapterFormat Span element; (found '$foundChar instead')",
            debugId: debugId);
        // ptr.grabUntil(Codes.RPAREN.code);
      }
    }
    //Read elements
    if (ptr.consumeIf('[')) {
      int braceLen = ptr.consumeUint32();
      ptr.assertConsume('.', debugId: debugId);
      BufferPtr subPtr = ptr.subset(0, braceLen);
      ptr.consume(braceLen);
      ptr.assertConsume(']', debugId: debugId);

      if (printVerbose) {
        dev.log('Running list (${ptr.getChar()} ${ptr.start})');
      }
      while (subPtr.hasMore() && !subPtr.consumeIf(']')) {
        //Adds frag to span
        var holder = parseSpanFragment(span, ptr: subPtr);

        if (holder != null) {
          span.lines.add(holder);
        }
      }

      // if (printVerbose) {
      //   dev.log('Finished with span fragments: ${subPtr.getChar()} ${subPtr.start}');
      // }
    } else {
      throw ChapterFormatException(
          "No list in span. char=${ptr.getChar()} pos=${ptr.start}",
          debugId: debugId);
    }
    return span.convert();
  }

  // ================ Spans ===========================

  FragOfText? parseSpanFragment(LiveSpanOfText span, {BufferPtr? ptr}) {
    //TODO: Return codes would be nice for this
    ptr ??= this.ptr;
    if (printVerbose) {
      dev.log('Frag time!');
    }
    LiveFragment frag = LiveFragment();
    while (ptr.hasMore()) {
      if (printVerbose) {
        dev.log('Parsing span fragment ${ptr.getChar()} ${ptr.start}');
      }
      if (ptr.consumeIf('b')) {
        return parseFragColoredBox();
      } else if (ptr.consumeIf('{')) {
        // dev.log('Fragging!');
        BufferPtr textBin = ptr.consumeUntil(Codes.RBRACE.code);
        frag.text = utf8.decode(textBin.toIntList());

        if (printVerbose) {
          dev.log("Read frag ${frag.text}");
        }
      } else if (ptr.consumeIf('(')) {
        BufferPtr fontData =
            ptr.consumeUntil(Codes.RPAREN.code, includeChar: true);
        frag.font.parseFragFont(fontData);
      } else if (ptr.consumeIf(';')) {
        return frag;
      } else if (ptr.getChar() == ']') {
        //TODO: Not sure what to do about this
        throw UnimplementedError(
            '"Not sure what to do about this" - ending bracket in span fragment');
        // return (ptr);
      } else {
        throw ChapterFormatException(
            "Unhandled char in FragOfText ${ptr.getChar()} ${ptr.start}",
            debugId: 'frag?');
      }
    }
    return null;
  }

  ColoredBoxHolder parseColoredBoxHolder() {
    double width = ptr.consumeFloat32();
    double height = ptr.consumeFloat32();
    Color? color = ptr.consumeColor(throwOnFail: true);
    color ??= Colors.transparent;
    return ColoredBoxHolder(width: width, height: height, color: color);
  }

  ColoredBoxFrag parseFragColoredBox() {
    double width = ptr.consumeFloat32();
    double height = ptr.consumeFloat32();
    Color? color = ptr.consumeColor(throwOnFail: true);
    color ??= Colors.transparent;
    return ColoredBoxFrag(width: width, height: height, color: color);
  }

  // ================== Custom Code =======================

  Holder getCustomCodeElement(CodeElementType type) {
    //Parameters

    //TODO: Above needs to slice out the element.
    //TODO: No longer return the BufferPtr
    //TODO: Check callers to see if Holder doesn't have to return
    String cls = ptr.readUntil(Codes.COLON.code);

    // double check
    cls = cls.toUpperCase();

    // dev.log("Get code Element cls = '$cls'");
    // dev.log("Ptr: ${ptr.asString(10)}");
    List<String> params = [];
    if (ptr.consumeIf(Codes.LGATOR)) {
      String parmS = ptr.readUntil(Codes.RGATOR);
      params = parmS.split(',');
    }
    for (int n = 0; n < params.length; ++n) {
      // Remove {}
      if (params[n].length > 2) {
        params[n] = params[n].substring(1, params[n].length - 1);
      } else {
        params[n] = '';
      }
    }

    // dev.log("Params = $params");
    //Body

    if (type == CodeElementType.codeTag) {
      //Nothing, right?
      return instantiateCodeTag(cls, params);
    } else if (type == CodeElementType.codeBlock) {
      //Parse Spans

      bool wrkd = ptr.consumeIf(Codes.LSQR);
      if (!wrkd) {
        throw ChapterFormatException(
            'Missing open LBRK in CodeBlock (char = "${ptr.getChar()}" pos=${ptr.start})',
            debugId: debugId);
      }
      int binLen = ptr.consumeUint32();
      ptr.assertConsume('.', debugId: debugId);

      //Scope for memory
      BufferPtr secondPtr = ptr.subset(0, binLen);
      ptr.consume(binLen);
      ptr.assertConsume(']', debugId: debugId);

      // Open a Second ChapterParser.
      ChapterParser subParser = ChapterParser(debugId: debugId, ptr: secondPtr);
      //This technically could send a stream
      List<Holder> spans = subParser.parseHolders().toList(growable: false);

      return instantiateCodeBlock(cls, params, spans);
      //Instantiate
    } else if (type == CodeElementType.parsedCodeElement) {
      bool wrkd = ptr.consumeIf(Codes.LBRACE);
      if (!wrkd) {
        throw ChapterFormatException(
            'Missing open LBRK in CodeBlock (char = "${ptr.getChar()}" pos=${ptr.start})',
            debugId: debugId);
      }
      int binLen = ptr.consumeUint32();
      ptr.assertConsume('.', debugId: debugId);

      //Scope for memory
      BufferPtr secondPtr = ptr.subset(0, binLen);
      ptr.consume(binLen);

      dev.log('parsedBlock _akljdflsdjf)');
      ptr.assertConsume(Codes.RBRACE, debugId: debugId);
      dev.log('parsedBlock _ S_)DI F_)');
      return parseParsedBlock(cls, params, secondPtr);
    } else {
      throw const DeveloperException("Update CodeElementTypes if ladder");
    }
  }

  // ============== Errors ==========================

  void addAndRegisterError(Object excep, [StackTrace? trace]) {
    dev.log('Exception: $excep');
    trace ??= StackTrace.current;

    dev.log(trace.toString());
    ExceptionHolder errorElem =
        ExceptionHolder(exception: excep, stackTrace: trace);
    ErrorList.logErrorHolder(errorElem);
  }

  void handleWarning(Object excep, [StackTrace? trace]) {
    trace ??= StackTrace.current;
    dev.log('Warning: $excep');
    dev.log(trace.toString());

    ExceptionHolder errorElem =
        ExceptionHolder.warning(excep, stackTrace: trace);

    ErrorList.logErrorHolder(errorElem);
  }

  static void handleStaticWarning(Object excep, [StackTrace? trace]) {
    trace ??= StackTrace.current;
    dev.log('Warning: $excep');
    dev.log(trace.toString());

    ExceptionHolder errorElem =
        ExceptionHolder.warning(excep, stackTrace: trace);

    ErrorList.logErrorHolder(errorElem);
  }
}
