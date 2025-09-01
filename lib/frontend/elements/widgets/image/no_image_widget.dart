import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/image/image_constants.dart';
import 'package:soyourhomeworld/frontend/pages/image_upload_page.dart'
    deferred as image_upload_page;
import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

import '../../../../backend/chapter.dart';
import '../../../../backend/part_id.dart';
import '../../../parts/grand_swatch.dart';
import '../../../parts/part.dart';
import 'image_container.dart';

enum NoImageReason {
  ///Image tried, not found
  networkError,

  ///Author set blank in book
  leftBlank,

  ///Image does not exist, or wrong name
  imageIOU,

  ///Image is a suggestion
  suggestion,

  ///Unknown
  none;

  String getTitleText() {
    switch (this) {
      case NoImageReason.networkError:
        return 'Image Error';
      case NoImageReason.imageIOU:
        return 'Missing image';
      case NoImageReason.suggestion:
        return 'Needs image';
      case NoImageReason.leftBlank:
        return "No image yet";
      case NoImageReason.none:
        return 'No image.';
    }
  }

  String getReasonText() {
    switch (this) {
      case NoImageReason.networkError:
        return '(Network failed)';
      case NoImageReason.leftBlank:
      case NoImageReason.suggestion:
        return "Try submitting one!";
      case NoImageReason.imageIOU:
        return "Try submitting one!";
      case NoImageReason.none:
        return 'I don\'t know why.';
    }
  }

  bool canSubmit() {
    switch (this) {
      case NoImageReason.networkError:
        return false;
      case NoImageReason.leftBlank:
      case NoImageReason.suggestion:
      case NoImageReason.imageIOU:
      case NoImageReason.none:
        return true;
    }
  }

  Color getBgColor(BuildContext context) {
    PartId partId = Chapter.of(context).part;

    if (partId == PartId.noir) {
      //Noir
      GrandSwatch primary = Part.of(context).primary;
      switch (this) {
        case NoImageReason.networkError:
          return Theme.of(context).colorScheme.error;
        case NoImageReason.leftBlank:
        case NoImageReason.imageIOU:
        case NoImageReason.suggestion:
          return primary.s3;
        // return Theme.of(context).colorScheme.primaryContainer;
        case NoImageReason.none:
          return primary.s0;
      }
    } else //if (partId == PartId.greenland)
    {
      //GN
      switch (this) {
        case NoImageReason.networkError:
          return Theme.of(context).colorScheme.error;
        case NoImageReason.leftBlank:
        case NoImageReason.imageIOU:
        case NoImageReason.suggestion:
          return Theme.of(context).colorScheme.secondaryFixedDim;
        case NoImageReason.none:
          return Theme.of(context).shadowColor;
      }
    }
  }

  Color getOnBgColor(BuildContext context) {
    PartId partId = Chapter.of(context).part;

    if (partId == PartId.noir) {
//Noir
      GrandSwatch primary = Part.of(context).primary;
      switch (this) {
        case NoImageReason.networkError:
          return Theme.of(context).colorScheme.onError;
        case NoImageReason.leftBlank:
        case NoImageReason.imageIOU:
        case NoImageReason.suggestion:
          return primary.sd;
        case NoImageReason.none:
          return primary.sc;
      }
    } else //if (partId == PartId.greenland)
    {
      //GN
      switch (this) {
        case NoImageReason.networkError:
          return Theme.of(context).colorScheme.onError;
        case NoImageReason.leftBlank:
        case NoImageReason.imageIOU:
        case NoImageReason.suggestion:
          return Theme.of(context).colorScheme.onSecondaryFixed;
        case NoImageReason.none:
          return Part.of(context).secondary.sf;
      }
    }
  }
}

class NoImageWidget extends StatelessWidget {
  final NoImageReason reason;
  final String? url;
  final String? displayUrl;

  const NoImageWidget(
      {required super.key,
      required this.reason,
      required this.displayUrl,
      required this.url});
  @override
  Widget build(BuildContext context) {
    Color bg = reason.getBgColor(context);

    return ImageContainer.factory(
        url: url,
        displayUrl: displayUrl,
        color: bg,
        allowExpand: false,
        child: _UnwrappedNoImageWidget(
            key: super.key, reason: reason, displayUrl: displayUrl));
  }
}

class _UnwrappedNoImageWidget extends StatelessWidget {
  final NoImageReason reason;
  final String? displayUrl;
  const _UnwrappedNoImageWidget(
      {required super.key, required this.reason, required this.displayUrl});

  @override
  Widget build(BuildContext context) {
    // final Color bg = reason.getBgColor(context);
    final Color onBg = reason.getOnBgColor(context);

    return SizedBox(
        height: standardImageHeight,
        width: standardImageWidth,
        child: Center(child: buildRow(context, onBg)));
  }

  Widget buildRow(BuildContext context, Color onBg) {
    return Row(
      key: const Key('row4Icon'),
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              Icons.image_not_supported,
              color: onBg,
              size: 3 * k,
            )),
        buildColumn(context, onBg)
      ],
    );
  }

  Column buildColumn(BuildContext context, Color onBg) {
    EdgeInsets padding = EdgeInsets.only(left: 6);

    Widget reasonText = Text(reason.getReasonText(),
        textAlign: TextAlign.start,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: onBg));

    if (reason.canSubmit()) {
      reasonText = TextButton(
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 3, horizontal: 6))),
          onPressed: () => onSubmit(context),
          child: reasonText);
    } else {
      reasonText = Padding(padding: padding, child: reasonText);
    }
    return Column(
      key: const Key("NoImageCol"),
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: padding,
            child: Text(
              reason.getTitleText(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: onBg),
            )),
        if (displayUrl != null)
          Padding(
              padding: padding,
              child: Text(displayUrl!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: onBg))),
        reasonText,
      ],
    );
  }

  void onSubmit(BuildContext context) async {
    //Mount check
    if (context.mounted) {
      // Deferred load
      await image_upload_page.loadLibrary();
      //Mount check
      if (context.mounted) {
        //show Dialog
        image_upload_page.showImageUploadDialog(context,
            sourceImage: displayUrl);
      }
    }
  }
}
