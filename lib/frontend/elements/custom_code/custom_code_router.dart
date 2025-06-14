import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/common_blocks.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/ballot_screen.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/character_selection.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/goto_button.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/shirts.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/title.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/tweet.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/ad_human_jacks.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/andy_thumbnail.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

import '../../../backend/binary_utils/buffer_ptr.dart';
import '../holders/textholders.dart';
import 'ad_widget.dart';
import 'code_holders.dart';
import 'misc_code_elements.dart';

export 'timed_audio.dart';

class IconHolder extends Holder {
  late final IconData icon;
  IconHolder(String icon, List<String> params) {
    this.icon = RpgAwesome.getName(icon) ?? RpgAwesome.random();
  }

  @override
  Widget element(BuildContext context) {
    return Icon(icon, size: 30, color: const Color(0x80000000));
  }

  @override
  Widget fallback(BuildContext context) {
    //Add a box so user knows there's supposed to be something there
    return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0x44000000), width: 2)),

        //And then try to display it anyway
        child: element(context));
  }
}

// ========= Routers =============

Holder instantiateCodeTag(String cls, List<String> params) {
  if (cls == 'COPSTING') {
    return const HiddenTextElement();
  } else if (cls == 'ICON') {
    return IconHolder(params[0], params.sublist(1));
  } else {
    dev.log("Missed CodeTag '$cls'");
  }
  return UnhandledCodeElement(cls, 'CodeTag');
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

Holder instantiateCodeBlock(
    String cls, List<String> params, List<Holder> spans) {
  Map<String, String> knownParams = stripKnownParams(params);

  dev.log("Cls: $cls");

  if (cls == 'Art') {
    return ArtHolder(spans: spans);
  } else if (cls == 'SHIRT') {
    return Shirt(spans: spans) as SpanHoldingCode;
  } else if (cls == 'TWEET') {
    return TweetHolder(spans);
  } else if (cls == 'SIGN') {
    return Sign(spans: spans);
  } else if (cls == 'BG') {
    String? bg = params.isNotEmpty ? params[0] : null;
    return BGCodeElement.fromString(bg, spans: spans);
  } else if (cls == 'TICKET') {
    return Ticket(spans: spans);
  } else if (cls == 'POLLSCREEN') {
    return PollScreen(spans: spans);
  } else if (cls == 'AD') {
    return HumanJackAdHolder.random();
  } else if (cls == 'TITLE') {
    //No needed spans
    return TitleHolder();
  } else if (cls == 'FULLBGAD') {
    // String? sc = readParam(params, 'color');
    //TODO: Parse colors
    return AdElementHolder(spans: spans, color: null);
  } else if (cls == 'BALLOT') {
    bool hasExtra = readBool(params, 'extra') ?? false;
    // List<String> links = readLinks(params, 'links') ?? [];
    return BallotHolder(isExtended: hasExtra);
  } else if (cls == "GOTOBUTTON") {
    String? link;
    if (params.isNotEmpty) {
      link = params[0];
    }
    bool? isChapter = readBool(params, 'IsChapter') ?? true;
    dev.log("Goto: $link $isChapter; \n\tparams = $params");

    return GotoButtonHolder(link: link, spans: spans, isChapter: isChapter);
  } else if (cls == 'CHARACTERSELECTIONSCREEN') {
    return CharacterSelectionHolder();
  } else if (cls == 'FLATEARTHANDYTHUMBNAIL') {
    String? link = knownParams['Link'];
    return AndyThumbnailHolder(spans: spans, link: link);
  } else {
    dev.log("Missed CodeBlock '$cls'");
    return UnhandledSpanHoldingCode(clsname: cls, spans: spans);
  }
}

Holder parseParsedBlock(String cls, List<String> params, BufferPtr bin) {
  dev.log("ParsedBlock: $cls");
  if (cls == 'COLUMNS') {
    // return UnhandledCodeElement(cls, "Columns");
    return Columns.parse(bin);
  } else if (cls == 'SIGNCOLUMNS') {
    return Sign2Cols.parse(bin);
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
