import 'dart:developer' as dev;

import 'package:flutter/material.dart';
//My code
import 'package:soyourhomeworld/backend/error_handler.dart';
//Delayed loaders
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ballot_screen.dart'
    deferred as ballot_screen_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/character_selection.dart'
    deferred as character_selection_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/goto_button.dart'
    deferred as goto_button_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/shirts.dart'
    deferred as shirts_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/title.dart'
    deferred as title_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/tweet.dart'
    deferred as tweet_lib;
import 'package:soyourhomeworld/frontend/elements/widgets/ad_human_jacks.dart'
    deferred as human_jacks_lib;
import 'package:soyourhomeworld/frontend/elements/widgets/andy_thumbnail.dart'
    deferred as andy_thumbnail_lib;
//TODO: Remove
import 'package:soyourhomeworld/frontend/icons.dart';

import '../../../backend/binary_utils/buffer_ptr.dart';
import '../holders/future_holder.dart';
import '../holders/holder_base.dart';
import '../holders/span_holding_code.dart';
import '../holders/textholders.dart';
import 'ad_widget.dart' deferred as ad_widget_lib;
import 'misc_code_elements.dart' deferred as misc_code_lib;

// ========= Routers =============

//This will in the future need to hold a FutureHolder
FutureHolder instantiateCodeTag(String cls, List<String> params) {
  Future<Holder> holder = _instantiateCodeTag(cls, params);
  return FutureHolder(holder);
}

Future<Holder> _instantiateCodeTag(String cls, List<String> params) async {
  if (cls == 'COPSTING') {
    return const HiddenTextElement();
  } else if (cls == 'ICON') {
    int? iconIndex = int.tryParse(params[0]);
    await misc_code_lib.loadLibrary();
    return misc_code_lib.IconHolder(
        iconIndex ?? RpgAwesome.errorIconIndex, params.sublist(1));
  } else {
    dev.log("Missed CodeTag '$cls'");
  }
  return UnhandledCodeElement(cls, 'CodeTag');
}

double? readDoubleParam(List<String> params, String key) {
  String? p = readParam(params, key);
  if (p != null) {
    double? d = double.tryParse(p);
    if (d == null) {
      ErrorList.showError(BookCodeException('Failed to read double param: $p'));
    }
    return null;
  } else {
    return null;
  }
}

String? readParam(List<String> params, String key) {
  for (String line in params) {
    if (line.startsWith(key)) {
      line = line.substring(key.length);
      line = line.trimLeft();
      if (line.startsWith('=')) {
        line = line.substring(1);
      }
      line = line.trimLeft();
      return line;
    }
  }
  return null;
}

bool? readBool(List<String> params, String key) {
  String? bs = readParam(params, key);
  if (bs == '1') {
    return true;
  } else if (bs == '0') {
    return false;
  }
  return null;
}

List<String>? readLinks(List<String> params, String key) {
  String? links = readParam(params, 'links');
  return links?.split(',');
}

Map<String, String> stripKnownParams(List<String> params) {
  if (params.isEmpty) {
    return {};
  } else {
    Map<String, String> map = {};
    for (String param in params) {
      param = param.trim();
      String cmp = param.toLowerCase();
      if (cmp.startsWith('link=')) {
        param = param.substring(5);
        map['Link'] = param;
      } else if (cmp.startsWith('color=')) {
        param = param.substring(6);
        map['Color'] = param;
      }
    }
    return map;
  }
}

FutureHolder instantiateCodeBlock(
    String cls, List<String> params, List<Holder> spans) {
  //This needs to load the code's library
  Future<Holder> future = _instantiateCodeBlock(cls, params, spans);
  //Return the element immediately
  return FutureHolder(future);
}

Future<Holder> _instantiateCodeBlock(
    String cls, List<String> params, List<Holder> spans) async {
  Map<String, String> knownParams = stripKnownParams(params);

  dev.log("Cls: $cls");

  if (cls == 'Art') {
    await misc_code_lib.loadLibrary();
    return misc_code_lib.ArtHolder(spans: spans);
  } else if (cls == 'SHIRT') {
    await shirts_lib.loadLibrary();
    //TODO: Convert params to an object
    double? width = readDoubleParam(params, 'width');
    double? height = readDoubleParam(params, 'width');

    return shirts_lib.Shirt(spans: spans, width: width, height: height);
  } else if (cls == 'BUMPERSTICKER') {
    await shirts_lib.loadLibrary();
    double? width = readDoubleParam(params, 'width');
    double? height = readDoubleParam(params, 'width');

    return shirts_lib.BumperSticker(spans: spans, width: width, height: height);
  } else if (cls == 'TWEET') {
    await tweet_lib.loadLibrary();
    return tweet_lib.TweetHolder(spans);
  } else if (cls == 'SIGN') {
    await misc_code_lib.loadLibrary();
    return misc_code_lib.Sign(spans: spans);
  } else if (cls == 'BG') {
    String? bg = params.isNotEmpty ? params[0] : null;
    await misc_code_lib.loadLibrary();
    return misc_code_lib.BGCodeElement.fromString(bg, spans: spans);
  } else if (cls == 'TICKET') {
    await misc_code_lib.loadLibrary();
    return misc_code_lib.Ticket(spans: spans);
  } else if (cls == 'POLLSCREEN') {
    await misc_code_lib.loadLibrary();
    return misc_code_lib.PollScreen(spans: spans);
  } else if (cls == 'AD') {
    await human_jacks_lib.loadLibrary();
    return human_jacks_lib.HumanJackAdHolder.random();
  } else if (cls == 'TITLE') {
    //No needed spans
    await title_lib.loadLibrary();
    return title_lib.TitleHolder();
  } else if (cls == 'FULLBGAD') {
    // String? sc = readParam(params, 'color');
    //TODO: Parse colors
    await ad_widget_lib.loadLibrary();
    return ad_widget_lib.AdElementHolder(spans: spans, color: null);
  } else if (cls == 'BALLOT') {
    bool hasExtra = readBool(params, 'extra') ?? false;
    // List<String> links = readLinks(params, 'links') ?? [];
    await ballot_screen_lib.loadLibrary();
    return ballot_screen_lib.BallotHolder(isExtended: hasExtra);
  } else if (cls == "GOTOBUTTON") {
    String? link;
    if (params.isNotEmpty) {
      link = params[0];
    }
    bool? isChapter = readBool(params, 'IsChapter') ?? true;
    dev.log("Goto: $link $isChapter; \n\tparams = $params");
    await goto_button_lib.loadLibrary();
    return goto_button_lib.GotoButtonHolder(
        link: link, spans: spans, isChapter: isChapter);
  } else if (cls == 'CHARACTERSELECTIONSCREEN') {
    await character_selection_lib.loadLibrary();
    return character_selection_lib.CharacterSelectionHolder();
  } else if (cls == 'FLATEARTHANDYTHUMBNAIL') {
    String? link = knownParams['Link'];
    await andy_thumbnail_lib.loadLibrary();
    return andy_thumbnail_lib.AndyThumbnailHolder(spans: spans, link: link);
  } else {
    dev.log("Missed CodeBlock '$cls'");
    return UnhandledSpanHoldingCode(clsname: cls, spans: spans);
  }
}

FutureHolder parseParsedBlock(String cls, List<String> params, BufferPtr bin) {
  Future<Holder> holder = _parseParsedBlock(cls, params, bin);
  return FutureHolder(holder);
}

Future<Holder> _parseParsedBlock(
    String cls, List<String> params, BufferPtr bin) async {
  dev.log("ParsedBlock: $cls");
  if (cls == 'COLUMNS') {
    // return UnhandledCodeElement(cls, "Columns");
    await misc_code_lib.loadLibrary();
    return misc_code_lib.Columns.parse(bin);
  } else if (cls == 'SIGNCOLUMNS') {
    await misc_code_lib.loadLibrary();
    return misc_code_lib.Sign2Cols.parse(bin);
  } else {
    dev.log("Missed ParsedBlock '$cls'");
  }
  return UnhandledCodeElement(cls, 'ParsedBlock');
}

enum CodeElementType {
  parsedCodeElement,
  codeBlock,
  codeTag,
}

class UnhandledCodeElement extends Holder {
  final String classname;
  final String category;

  const UnhandledCodeElement(this.classname, this.category);

  @override
  Widget element(BuildContext context) {
    return ColoredIconCard(
      icon: Icons.construction,
      text: classname.toLowerCase(),
      extra: "[Needs code element: $classname ($category)]",
    );
  }

  @override
  Widget fallback(BuildContext context) {
    return ColoredIconCard(
      icon: Icons.local_fire_department,
      text: classname.toLowerCase(),
      extra: "[Needs code element: $classname ($category)*]",
    );
  }
}
