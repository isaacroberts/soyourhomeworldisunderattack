import 'dart:developer' as dev;

import 'package:flutter/material.dart';
//Delayed loaders
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ballot_screen.dart'
    deferred as ballot_screen_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/facebook_post.dart'
    deferred as facebook_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/goto_button.dart'
    deferred as goto_button_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/notif_text.dart'
    deferred as notif_text_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/raised_spans.dart'
    deferred as raised_span_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/shirts.dart'
    deferred as shirts_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/sign.dart'
    deferred as signs_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/source_citation.dart'
    deferred as source_cite_lib;
import 'package:soyourhomeworld/frontend/elements/custom_code/tweet.dart'
    deferred as tweet_lib;
import 'package:soyourhomeworld/frontend/elements/special_widgets/ad_human_jacks.dart'
    deferred as human_jacks_lib;
import 'package:soyourhomeworld/frontend/elements/special_widgets/andy_thumbnail.dart'
    deferred as andy_thumbnail_lib;
import 'package:soyourhomeworld/frontend/image/image_holder.dart'
    deferred as image_lib;
import 'package:soyourhomeworld/frontend/image/profile_image.dart'
    deferred as profile_image_lib;
import 'package:soyourhomeworld/frontend/pages/title/title.dart'
    deferred as title_lib;

import '../../../backend/binary_utils/code_params.dart';
import '../holders/future_holder.dart';
import '../holders/holder_base.dart';
import '../holders/span_holding_code.dart';
import 'ad_widget.dart' deferred as ad_widget_lib;
import 'art.dart' deferred as art_lib;
import 'elven_chorus.dart' deferred as elven_chorus_lib;
import 'google_search.dart' deferred as google;
import 'misc_code_elements.dart' deferred as misc_code_lib;

// ========= Routers =============

//This will in the future need to hold a FutureHolder
FutureHolder instantiateCodeTag(String cls, CodeParams params) {
  Future<Holder> holder = _instantiateCodeTag(cls, params);
  return FutureHolder(holder);
}

Future<Holder> _instantiateCodeTag(String cls, CodeParams params) async {
  if (cls == 'SOURCE') {
    await source_cite_lib.loadLibrary();
    String? link = params.main ?? params.readLink('Link');
    return source_cite_lib.SourceCitationHolder(link: link, params: params);
  } else if (cls == 'ICON') {
    int? iconIndex = int.tryParse(params.main ?? '0');
    await misc_code_lib.loadLibrary();
    return misc_code_lib.IconHolder(iconIndex ??
        // RpgAwesome.errorIconIndex = 30
        30);
  } else if (cls == 'IMAGE') {
    await image_lib.loadLibrary();
    return image_lib.StdImageHolder(params);
  } else if (cls == 'PROFILEIMAGE') {
    await profile_image_lib.loadLibrary();
    return profile_image_lib.ProfileImageHolder.fromParams(params);
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
    return facebook_lib.FacebookHolder(spans, params);
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
  } else if (cls == 'NOTIFICATION') {
    await notif_text_lib.loadLibrary();
    return notif_text_lib.NotificationTextHolder.fromSpans(
        data: params, spans: spans);
  } else if (cls == 'YOUTUBE') {
    await raised_span_lib.loadLibrary();
    return raised_span_lib.YoutubeTranscriptHolder(spans: spans);
  } else if (cls == 'SPLATBOOK') {
    await raised_span_lib.loadLibrary();
    return raised_span_lib.DnDSplatHolder(spans: spans);
  } else if (cls == 'MTGCARD') {
    await raised_span_lib.loadLibrary();
    return raised_span_lib.MtgCardHolder(spans: spans);
  } else if (cls == 'ID') {
    await raised_span_lib.loadLibrary();
    return raised_span_lib.LicenseHolder(spans: spans);
  } else if (cls == 'ARTICLE') {
    await raised_span_lib.loadLibrary();
    return raised_span_lib.ArticleHolder(spans: spans);
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
  } else if (cls == 'GOOGLE') {
    await google.loadLibrary();
    // params.print();
    String term = spans.map((s) => s.toText()).join();
    return google.GoogleSearchHolder(term: term);
  } else if (cls == "GOTOBUTTON") {
    String? link = params.readLink('main');
    bool? isChapter = params.readBool('IsChapter') ?? true;
    dev.log("Goto: $link $isChapter; \n\tparams = $params");
    await goto_button_lib.loadLibrary();

    return goto_button_lib.GotoButtonHolder(
        link: link, spans: spans, isChapter: isChapter);
  } else if (cls == 'FLATEARTHANDYTHUMBNAIL') {
    String? link = params.readLink('link');
    await andy_thumbnail_lib.loadLibrary();
    return andy_thumbnail_lib.AndyThumbnailHolder(spans: spans, link: link);
  } else {
    dev.log("Missed CodeBlock '$cls'");
    return UnhandledSpanHoldingCode(clsname: cls, spans: spans);
  }
}

enum CodeElementType {
  parsedCodeElement,
  codeBlock,
  codeTag,
}

class UnhandledCodeElement extends CodeHolder {
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
}
