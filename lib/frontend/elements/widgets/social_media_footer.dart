import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soyourhomeworld/backend/server.dart';
import 'package:soyourhomeworld/frontend/pages/sidebar/logo.dart';
import 'package:soyourhomeworld/frontend/parts/noir_colors.dart';
import 'package:soyourhomeworld/frontend/parts/noir_part.dart';
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

import '../../../backend/chapter.dart';
import '../../icons.dart';
import '../../view_settings.dart';

typedef _swatch = NoirPrimary;
// const GrandSwatch swatch = NoirSecondary();

class NoirSocialMediaFooter extends StatefulWidget {
  final ScrollController scrollController;
  const NoirSocialMediaFooter({super.key, required this.scrollController});

  @override
  State<StatefulWidget> createState() => _SocialMediaState();
}

//TODO: Server
Set<Chapter> likedChapters = {};

double totalScrolled = 0;

class _SocialMediaState extends State<NoirSocialMediaFooter> {
  bool get show => ViewSettings.instance.showBottomNav;
  set show(bool? s) => ViewSettings.instance.showBottomNav = s;

  @override
  void initState() {
    ViewSettings.instance.showBottomNavNotifier
        .addListener(showBottomNavChanged);
    super.initState();
  }

  @override
  void dispose() {
    ViewSettings.instance.showBottomNavNotifier
        .removeListener(showBottomNavChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = show ? buildComplete(context) : buildUnshown(context);
    return child;
  }

  static const Color color = _swatch.shade9;
  static const Color buttonColor = _swatch.shade9;

  Widget buildComplete(BuildContext context) {
    Chapter? chapter = Chapter.maybeOf(context);
    bool liked = likedChapters.contains(chapter);

    return _SocialMediaContainer(
        key: const Key("ctr"),
        child: Row(
          key: const Key("row"),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
            Tooltip(
                richMessage: const WidgetSpan(
                    child: CollapsedSiteLogo(
                  key: Key("logo"),
                  part: PartNoir(),
                )),
                constraints: const BoxConstraints(
                    maxWidth: double.infinity, maxHeight: double.infinity),
                decoration: const BoxDecoration(),
                // message: 'Book',
                child: Row(children: [
                  const Icon(
                    RpgAwesome.burning_meteor,
                    color: color,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Help, My Homeworld!",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: color),
                  ),
                ])),
            // const SizedBox(width: 12),
            // Odometer(color: color, controller: widget.scrollController),
            const SizedBox(width: 12),
            const Expanded(child: SizedBox()),
            Tooltip(
                message: 'Like${liked ? 'd' : ''} to charge',
                child: IconButton(
                    onPressed: toggleLike,
                    icon: Icon(
                      RpgAwesome.glass_heart,
                      color: liked ? _swatch.shadea : buttonColor,
                    ))),
            const SizedBox(width: 12),
            Tooltip(
                message: 'Request backup',
                child: IconButton(
                  onPressed: backupRequested,
                  icon: const Icon(
                    RpgAwesome.crossed_swords,
                    color: buttonColor,
                    size: 24,
                  ),
                )),
            const SizedBox(width: 12),
            Tooltip(
                message: 'Comment to Cast',
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      RpgAwesome.speech_bubble,
                      color: buttonColor,
                    ))),
            const SizedBox(width: 12),

            Tooltip(
              message: 'Hide social footer',
              child: IconButton(
                  onPressed: turnOffBottomNav,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: color,
                  )),
            ),
            // Switch(
            //     key: const Key("showSwitch"),
            //     value: ViewSettings.instance.showBottomNav,
            //     onChanged: setBottomNav),
          ],
        ));
  }

  Widget buildUnshown(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 12 + 6, horizontal: 12 + 12),
            child: IconButton(
              key: const Key("showSwitch"),
              onPressed: turnOnBottomNav,
              icon: const Icon(
                RpgAwesome.speech_bubble,
                color: color,
              ),
            )));
  }

  void toggleLike() {
    Chapter? chapter = Chapter.maybeOf(context);
    if (chapter != null) {
      if (likedChapters.contains(chapter)) {
        likedChapters.remove(chapter);
      } else {
        likedChapters.add(chapter);
      }
      setState(() {});
    }
  }

  void showBottomNavChanged() {
    setState(() {});
  }

  void turnOffBottomNav() {
    show = false;
  }

  void turnOnBottomNav() {
    show = true;
  }

  void setBottomNav(bool? set) {
    ViewSettings.instance.showBottomNav = set;
  }

  void onDoom() {
    Navigator.pop(context);
  }

  void backupRequested() {
    Chapter? chapter = Chapter.maybeOf(context);
    late String link;
    if (chapter == null) {
      link = serverDisplayURL;
    } else {
      if (chapter.index == 0) {
        link = serverDisplayURL;
      } else {
        link = '$serverDisplayURL/search/${chapter.varName}';
      }
    }

    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
      content: Text("Copied: $link"),
    ));
  }
}

class Odometer extends StatefulWidget {
  const Odometer({
    super.key,
    required this.color,
    required this.controller,
  });

  final Color color;
  final ScrollController controller;

  @override
  State<StatefulWidget> createState() => _OdometerState();
}

class _OdometerState extends State<Odometer> {
  double lastScrollDist = 0;
  Color get color => widget.color;

  @override
  void initState() {
    widget.controller.addListener(scrollNotification);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(scrollNotification);

    super.dispose();
  }

  void scrollNotification() {
    double distance = widget.controller.offset;

    double travelled = distance - lastScrollDist;
    if (travelled > 0) {
      setState(() {
        totalScrolled += travelled;
      });
    }
    lastScrollDist = distance;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: 'Keep scrolling! You can still save your planet!',
        child: Container(
            width: 72,
            height: 36,
            decoration: BoxDecoration(
                color: _swatch.shade3,
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(3)),
            alignment: Alignment.center,
            child: Text(
              pixelsToDistance(totalScrolled),
              style: appFont(
                  color: color, fontWeight: FontWeight.w200, fontSize: 12),
            )));
  }

  double scrollToDistance(double pixels) {
    return MediaQuery.of(context).devicePixelRatio * pixels;
  }

  double distanceToFeet(double pixels) {
    double ppi = 15;
    return pixels / ppi / 12;
  }

  String pixelsToDistance(double pixels) {
    double feet = distanceToFeet(scrollToDistance(pixels));
    if (feet < 1) {
      return '0 ft';
    } else if (feet < 5280) {
      return '${feet.round()} ft';
    } else {
      double miles = feet / 5280;
      return '${miles.toStringAsPrecision(2)} mi';
    }
  }
}

class _SocialMediaContainer extends StatelessWidget {
  final Widget? child;
  const _SocialMediaContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          color: _swatch.shade6,
          border: Border.all(color: _swatch.shade8),
          borderRadius: BorderRadius.circular(36)),
      constraints: BoxConstraints(
          minWidth: 60,
          maxWidth: MediaQuery.sizeOf(context).width,
          minHeight: 48,
          maxHeight: 48),
      alignment: Alignment.center,
      child: child,
    );
  }
}
