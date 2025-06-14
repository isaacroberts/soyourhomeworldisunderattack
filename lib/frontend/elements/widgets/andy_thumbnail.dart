import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/frontend/elements/custom_code/code_holders.dart';
import 'package:soyourhomeworld/frontend/styles.dart';

class YoutubeVideo extends StatelessWidget {
  final Widget? profileIcon;
  final String profileName;
  final String videoName;
  final Widget videoThumb;
  final String? viewCt;
  final String? dateDescriptor;
  const YoutubeVideo(
      {super.key,
      this.profileIcon,
      required this.profileName,
      required this.videoName,
      required this.videoThumb,
      this.viewCt,
      this.dateDescriptor});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SizedBox(
            height: 300,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: ClipRRect(
                        key: const Key('ytClipRect'),
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox.expand(
                          child: videoThumb,
                        ))),
                const SizedBox(
                  height: 5,
                ),
                iconRow(context)
              ],
            )));
  }

  Widget iconRow(BuildContext context) {
    return SizedBox(
        height: 55,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            profileIcon ??
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff555555)),
                  child: const Icon(
                    Icons.person,
                    size: 55,
                  ),
                ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(videoName,
                    style: siliconeValleyFont.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w700)),
                Text(profileName,
                    style: siliconeValleyFont.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xff888888))),
                Text(
                    '${viewCt ?? '1.4k'} views * ${dateDescriptor ?? '1 day ago'}',
                    style: siliconeValleyFont.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xff888888))),
              ],
            )
          ],
        ));
  }
}

class AndyThumbnailHolder extends SpanHoldingCode {
  final String? link;
  const AndyThumbnailHolder({required super.spans, this.link});

  void onPressed(BuildContext context) {
    String link = this.link ?? 'YTHook';
    context.go('/search/$link');
  }

  @override
  Widget element(BuildContext context) {
    return Center(
        child: MaterialButton(
            onPressed: () => onPressed(context),
            child: const YoutubeVideo(
              key: Key('AndyYTVideo'),
              profileIcon: _AndyIcon(
                key: Key("AndyYTIcon"),
              ),
              profileName: 'FlatEarthAndy',
              videoName: 'I went to Greenland to see the Ice Wall!',
              videoThumb: AndyVideoThumbnail(
                key: Key('AndyThumb'),
              ),
              viewCt: '1.4k',
              dateDescriptor: '1 day ago',
            )));
  }
}

class _AndyIcon extends StatelessWidget {
  const _AndyIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 55,
        height: 55,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color(0xff79b9ff)),
        alignment: Alignment.center,
        child: const Text(':)',
            style: TextStyle(
              fontFamily: 'Palatino',
              fontSize: 24,
              color: Color(0xffdda863),
            )));
  }
}

class AndyVideoThumbnail extends StatelessWidget {
  const AndyVideoThumbnail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(colors: [
              Color(0xffaeb4fb),
              Color(0xff5f8cf3),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: stack(context));
  }

  Widget stack(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(0, 80),
          transformHitTests: false,
          child: Transform.scale(
              scaleY: .1,
              child: const Icon(Icons.circle,
                  size: 500, color: Color(0xff447744))),
        ),
        const Align(
          alignment: Alignment(-.33, 1),
          child: Icon(Icons.landscape, size: 150, color: Color(0xff884819)),
        ),
        const Align(
          alignment: Alignment(1, 1),
          child: Icon(Icons.landscape, size: 300, color: Color(0xff592500)),
        ),

        // const Align(
        //   alignment: Alignment(.5, -.5),
        //   child: Icon(Icons.celebration_outlined,
        //       size: 100,
        //       // shadows: [Shadow(blurRadius: 3, offset: Offset(0, 10))],
        //       color: Color(0x88ffaa00)),
        // ),

//Thanks for circling that
        Align(
            alignment: const Alignment(.57, -.75),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  // color: Color(0x220000ff),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xccff2111), width: 8)),
            )),
        const Align(
          alignment: Alignment(.5, -.5),
          child: Icon(Icons.vertical_shades,
              size: 100,
              shadows: [
                // Shadow(
                //     color: Color(0xffffffff),
                //     blurRadius: 10,
                //     offset: Offset(0, 0)),
                Shadow(
                    color: Color(0x7f000000),
                    blurRadius: 15,
                    offset: Offset(0, 20))
              ],
              color: Color(0xffeeeeee)),
        ),
        Align(
            alignment: const Alignment(-.05, 0),
            child: Text(
              '👉️',
              style: bodyFont.copyWith(shadows: [
                const Shadow(
                    color: Color(0x4f000000),
                    offset: Offset(0, 5),
                    blurRadius: 5),
              ], fontSize: 60, color: const Color(0xff000000)),
            )),
        Align(
            alignment: const Alignment(-.33, 0),
            child: Text(
              '🤯️',
              style: bodyFont.copyWith(shadows: [
                const Shadow(
                    color: Color(0x8f000000),
                    offset: Offset(0, 5),
                    blurRadius: 5),
              ], fontSize: 60, color: const Color(0xff000000)),
            )),
      ],
    );
  }
}
/*
class _VideoTimeDisplay extends StatelessWidget {
  const _VideoTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color(0x88000000),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
            child: Text(
              '12:31',
              style: Theme.of(context).textTheme.labelLarge,
            )));
  }
}
*/
