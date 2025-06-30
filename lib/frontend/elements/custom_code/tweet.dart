import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/icons.dart';

import '../holders/holder_base.dart';
import '../holders/holder_utils.dart';

class TweetHolder extends Holder {
  late String user;
  late String tweet;
  TweetHolder(List<Holder> spans) : super() {
    //TODO: Strip text out of spans & parse for @ and :
    String text = HolderUtils.stripOutText(spans);
    List<String> parts = text.split(':');

    if (parts[0].contains('@')) {
      user = parts[0].replaceAll('@', '');
    } else {
      if (text.contains('@')) {
        throw DeveloperException(
            'Not implemented - Username in tweet hard to reach. list=($parts}) text="$text"');
      } else {
        user = parts[0];
      }
    }
    if (parts.length > 1) {
      tweet = parts.sublist(1).join(':');
    } else {
      tweet = 'Exception: Tweet JSON unparseable.';
    }
  }

  @override
  Widget element(BuildContext context) {
    return TweetWidget(user: user, tweet: tweet);
  }

  @override
  Widget fallback(BuildContext context) {
    return IsFallbackProvider(
        showFonts: false, child: TweetWidget(user: user, tweet: tweet));
  }
}

const Color tweetColor = Color(0xff4da5e9);
const String tweetFamily = 'Roboto';

class TweetWidget extends StatelessWidget {
  final String user;
  final String tweet;
  const TweetWidget({super.key, required this.user, required this.tweet});

  Widget profileRow(BuildContext context) {
    return SizedBox(
        height: 30,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: tweetColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child:
                    //TODO: This used to be random, which was better
                    const Icon(RpgAwesome.chain, color: Color(0x88000000))),
            // CircleAvatar(
            //   backgroundColor: const Color(0xff5a7083),
            //   maxRadius: 10,
            //   child: Icon(RpgAwesome.random(),
            //       size: 10, color: const Color(0x88000000)),
            // ),
            const SizedBox(width: 5),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user,
                      style: const TextStyle(
                          fontFamily: tweetFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color(0xff010001))),
                  Text('@$user',
                      style: const TextStyle(
                          fontFamily: tweetFamily,
                          fontWeight: FontWeight.w300,
                          fontSize: 8,
                          color: Color(0xff5a7083))),
                ]),
          ],
        ));
  }

  Widget stackWithIcon(BuildContext context, Widget child) {
    return Stack(fit: StackFit.passthrough, children: [
      const Align(
          alignment: Alignment.topRight,
          child: Icon(RpgAwesome.bird_claw, color: tweetColor)),
      Center(child: child)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            // margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.white,
            width: 600,
            child: stackWithIcon(
              context,
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: const Color(0xffe4e5e7)),
                    color: Colors.white,
                  ),
                  width: 500,
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        profileRow(context),
                        const SizedBox(height: 5),
                        Text(tweet,
                            style: const TextStyle(
                                fontFamily: tweetFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.black)),
                        dateRow(context),
                        shareRow(context),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                      ])),
            )));
  }

  // String date

  Widget dateRow(BuildContext context) {
    TextStyle font = const TextStyle(
        fontWeight: FontWeight.w200, fontSize: 12, color: Color(0xff666b70));
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("12:34 •", style: font),
            Text("July 4, 2025", style: font),
          ],
        ));
  }

  static const Color shareColor = Color(0xff666b70);
  static const Color dividerColor = Color(0x80666b70);
  static const TextStyle shareFont =
      TextStyle(fontWeight: FontWeight.w200, fontSize: 12, color: shareColor);

  Widget shareRow(BuildContext context) {
    return Container(
        height: 50,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: dividerColor))),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TODO: Random number
              shareIconRow(RpgAwesome.bleeding_hearts, '1.4k'),
              // const ShareSpacer(),
              shareIconRow(RpgAwesome.poison_cloud, '24'),
              // const ShareSpacer(),
              shareIconRow(RpgAwesome.forward, ''),
              const SizedBox(width: 15),
            ]));
  }

  void iconClicked() {
    dev.log("Icon!");
  }

  Row shareIconRow(IconData icon, String text) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: iconClicked,
              color: ShareButtonColor(),
              icon: Icon(
                // size: 20,
                icon,
                // focusColor: tweetColor,
              )),
          // const SizedBox(width: 2),
          Text(text, style: shareFont, maxLines: 1),
        ]);
  }
}

const Color shareColor = Color(0xff666b70);

class ShareButtonColor extends WidgetStateColor {
  ShareButtonColor() : super(0xff666b70);

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return const Color(0xff444444);
    }
    if (states.contains(WidgetState.hovered)) {
      return const Color(0xff887b90);
    }
    return shareColor;
  }
}

class IconButtonThatChangesColor extends StatelessWidget {
  final Color normal, hover, clicked;
  final VoidCallback onClicked;
  const IconButtonThatChangesColor(
      {super.key,
      required this.normal,
      required this.hover,
      required this.clicked,
      required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ShareSpacer extends StatelessWidget {
  const ShareSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 15);
  }
}
