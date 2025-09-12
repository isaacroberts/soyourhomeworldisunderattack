import 'dart:developer' as dev;

import 'package:flutter/material.dart';
//Delayed loaders
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ballot_screen.dart'
    deferred as ballot_screen_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/character_selection.dart'
    deferred as character_selection_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/columns_holder.dart'
    deferred as columns_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/facebook_post.dart'
    deferred as facebook_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/goto_button.dart'
    deferred as goto_button_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/shirts.dart'
    deferred as shirts_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/sign.dart'
    deferred as signs_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/tweet.dart'
    deferred as tweet_lib;
import 'package:soyourhomeworld/frontend/elements/special_widgets/ad_human_jacks.dart'
    deferred as human_jacks_lib;
import 'package:soyourhomeworld/frontend/elements/special_widgets/andy_thumbnail.dart'
    deferred as andy_thumbnail_lib;
//TODO: Remove
import 'package:soyourhomeworld/frontend/icons.dart';
//TODO: Defer
import 'package:soyourhomeworld/frontend/image/image_holder.dart'
    deferred as image_lib;
import 'package:soyourhomeworld/frontend/pages/title/title.dart'
    deferred as title_lib;

import '../../../backend/binary_utils/buffer_ptr.dart';
import '../../../backend/binary_utils/code_params.dart';
import '../holders/future_holder.dart';
import '../holders/holder_base.dart';
import '../holders/span_holding_code.dart';
import '../holders/textholders.dart';
import 'ad_widget.dart' deferred as ad_widget_lib;
import 'art.dart' deferred as art_lib;
import 'elven_chorus.dart' deferred as elven_chorus_lib;
import 'misc_code_elements.dart' deferred as misc_code_lib;

// ========= Routers =============

//This will in the future need to hold a FutureHolder
FutureHolder instantiateCodeTag(String cls, CodeParams params) {
  Future<Holder> holder = _instantiateCodeTag(cls, params);
  return FutureHolder(holder);
}

Future<Holder> _instantiateCodeTag(String cls, CodeParams params) async {
  if (cls == 'COPSTING') {
    return const HiddenTextElement();
  } else if (cls == 'ICON') {
    int? iconIndex = int.tryParse(params.main ?? '0');
    await misc_code_lib.loadLibrary();
    return misc_code_lib.IconHolder(iconIndex ?? RpgAwesome.errorIconIndex);
  } else if (cls == 'IMAGE') {
    String? url = params.main;
    double? aspectRatio = params.readDouble('aspectRatio');
    List<Color>? colorHints = params.colorList('colorHint');
    String? credit = params['credit'];
    credit ??= '(Credit lost)';
    await image_lib.loadLibrary();
    return image_lib.ImageHolder.fromList(
        url: url,
        aspectRatio: aspectRatio,
        colorHints: colorHints,
        credit: credit);
  } else if (cls == 'ELVENCHORUS' || cls == 'ELVENCHOIR') {
    // dev.log("Elven Chorus");
    int? speed = params.readInt('Speed');
    await elven_chorus_lib.loadLibrary();
    return elven_chorus_lib.ElvenChorusHolder(speed: speed);
  } else if (cls == "CUSTOMGOTO") {
    String? link = params.readLink('link');
    await goto_button_lib.loadLibrary();
    return goto_button_lib.GotoButtonHolder(link: link, spans: []);
  } else {
    dev.log("Missed CodeTag '$cls'");
  }
  return UnhandledCodeElement(cls, 'CodeTag');
}

FutureHolder instantiateCodeBlock(
    String cls, CodeParams params, List<Holder> spans) {
  //This needs to load the code's library
  Future<Holder> future = _instantiateCodeBlock(cls, params, spans);
  //Return the element immediately
  return FutureHolder(future);
}

Future<Holder> _instantiateCodeBlock(
    String cls, CodeParams params, List<Holder> spans) async {
  dev.log("Cls: $cls");

  //TODO: Sort alphabetically
  if (cls == 'ART') {
    await art_lib.loadLibrary();
    return art_lib.ArtHolder(spans: spans);
  } else if (cls == 'FACEBOOK') {
    await facebook_lib.loadLibrary();
    return facebook_lib.FacebookHolder(spans);
  } else if (cls == 'SHIRT' || cls == 'PRINTEXACTSHIRT') {
    await shirts_lib.loadLibrary();
    //TODO: Convert params to an object
    double? width = params.readDouble('width');
    double? height = params.readDouble('height');

    return shirts_lib.Shirt(spans: spans, width: width, height: height);
  } else if (cls == 'CHAPTERSHIRT') {
    await shirts_lib.loadLibrary();
    double width = 800;
    double height = 1000;
    return shirts_lib.Shirt(spans: spans, width: width, height: height);
  } else if (cls == 'BUMPERSTICKER') {
    await shirts_lib.loadLibrary();
    double? width = params.readDouble('width');
    double? height = params.readDouble('height');

    return shirts_lib.BumperSticker(spans: spans, width: width, height: height);
  } else if (cls == 'TWEET') {
    await tweet_lib.loadLibrary();
    return tweet_lib.TweetHolder(spans);
  } else if (cls == 'SIGN') {
    await signs_lib.loadLibrary();
    return signs_lib.Sign(spans: spans);
  } else if (cls == 'BG') {
    String? bg = params.main;
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
    bool hasExtra = params.readBool('extra') ?? false;
    bool enabled = params.readBool('on') ?? true;

    // List<String> links = readLinks(params, 'links') ?? [];
    await ballot_screen_lib.loadLibrary();
    return ballot_screen_lib.BallotHolder(
        isExtended: hasExtra, enabled: enabled);
  } else if (cls == "GOTOBUTTON") {
    String? link = params.readLink('main');
    bool? isChapter = params.readBool('IsChapter') ?? true;
    dev.log("Goto: $link $isChapter; \n\tparams = $params");
    await goto_button_lib.loadLibrary();

    return goto_button_lib.GotoButtonHolder(
        link: link, spans: spans, isChapter: isChapter);
  } else if (cls == 'CHARACTERSELECTIONSCREEN') {
    await character_selection_lib.loadLibrary();
    return character_selection_lib.CharacterSelectionHolder();
  } else if (cls == 'FLATEARTHANDYTHUMBNAIL') {
    String? link = params.readLink('link');
    await andy_thumbnail_lib.loadLibrary();
    return andy_thumbnail_lib.AndyThumbnailHolder(spans: spans, link: link);
  } else {
    dev.log("Missed CodeBlock '$cls'");
    return UnhandledSpanHoldingCode(clsname: cls, spans: spans);
  }
}

FutureHolder parseParsedBlock(String cls, CodeParams params, BufferPtr bin) {
  Future<Holder> holder = _parseParsedBlock(cls, params, bin);
  return FutureHolder(holder);
}

Future<Holder> _parseParsedBlock(
    String cls, CodeParams params, BufferPtr bin) async {
  dev.log("ParsedBlock: $cls");
  if (cls == 'COLUMNS') {
    // return UnhandledCodeElement(cls, "Columns");
    await columns_lib.loadLibrary();
    return columns_lib.Columns.parse(bin);
  } else if (cls == 'SIGNCOLUMNS') {
    await columns_lib.loadLibrary();
    return columns_lib.Sign2Cols.parse(bin);
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
  String toText() {
    return '[CodeElementNotFound: $classname]';
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
