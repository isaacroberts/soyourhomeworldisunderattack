import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold_with_scroll.dart';

import '../../backend/utils.dart';
import '../elements/widgets/popup_card.dart';
import '../parts/noir_colors.dart';

class ImageUploadPage extends StatelessWidget {
  final String? sourceImage;

  const ImageUploadPage({super.key, required this.sourceImage});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithScroll(
        key: const Key('scaffold'),
        source: null,
        body: ImageUploadWidget(
          key: const Key('widg'),
          sourceImage: sourceImage,
        ));
  }
}

void showImageUploadDialog(BuildContext context,
    {required String? sourceImage}) {
  Widget builder(BuildContext context) {
    return PopupCardContainer(
        key: const Key('popupCtr'),
        background: NoirPrimary.shade1,
        child: ImageUploadWidget(
            key: const Key('uploadWarning'), sourceImage: sourceImage));
  }

  pushPopupCard(context, builder: builder, label: 'Image Upload');
}

class ImageUploadWidget extends StatefulWidget {
  final String? sourceImage;
  const ImageUploadWidget({super.key, this.sourceImage});

  @override
  State<ImageUploadWidget> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUploadWidget> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image Upload',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        Text(
          copy,
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        buttonRow(),
      ],
    );
  }

  Widget buttonRow() {
    var textTheme = Theme.of(context).textTheme.labelLarge;

    Widget w = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
            key: const Key('continue'),
            onPressed: onBeginVerification,
            child: Text(
              'Verify you\'re a Human!',
              style: textTheme,
            )),
        const SizedBox(
          width: 12,
        ),
        FilledButton(
            key: const Key('close'),
            onPressed: onClose,
            child: Text(
              'Close',
              style: textTheme,
            )),
      ],
    );
    w = SizedBox(
      height: 48,
      child: w,
    );
    return w;
  }

  void onBeginVerification() {
    if (mounted) {
      //ModalRoute
      pushPopupCard(context,
          builder: dialogBuilder, label: 'Human Verification');

//Show popup
//       showVerificationDialog(context);
    }
  }

  void onClose() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<dynamic> showVerificationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: dialogBuilder,
      barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(128),
      barrierDismissible: true,
      barrierLabel: 'Verification Popup',
    );
  }

  Widget dialogBuilder(BuildContext context) {
    return HumanVerificationPopup(
      key: const Key('human_verify'),
      sourceImage: widget.sourceImage,
    );
  }
}

const String copy = """

Unfortunately, I am an Anti-AI extremist. You cannot send me loose jpegs. I would go into a Butlerian rage if even one synthetic image were to get on my blessed server.   

EARTH IS FOR GOD'S CHILDREN. Robots were made to work, not sit around and make art. If robots have time to be ${LQ}creative$RQ, they have time to clean.  

Only Humans are permitted to read this book. Certainly, to upload an image, you must be one.
""";

const String popupCopy = """

Joseph Silverstein, the One-Eyed Whaler will facetime you. 

Please leave your phone number. 
""";

class HumanVerificationPopup extends StatefulWidget {
  final String? sourceImage;
  const HumanVerificationPopup({super.key, required this.sourceImage});

  @override
  State<HumanVerificationPopup> createState() => _HumanVerificationPopupState();
}

class _HumanVerificationPopupState extends State<HumanVerificationPopup> {
  TextEditingController controller = TextEditingController();
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var textTheme = theme.textTheme;
    Color onPrimary = theme.colorScheme.onPrimaryContainer;
    return PopupCardContainer(
        key: const Key('popupCtr'),
        background: theme.colorScheme.primaryContainer,
        child: SelectionArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (submitted)
              Text(
                "Not built yet big dawg",
                style: textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.error),
              ),

            Text(
              'Prove you\'re a human!',
              style: textTheme.titleLarge?.copyWith(color: onPrimary),
            ),
            Text(
              popupCopy,
              style: textTheme.bodyLarge?.copyWith(color: onPrimary),
            ),
            // Text(
            //   'Enter your phone number:',
            //   style:
            //       textTheme.labelSmall?.copyWith(color: onPrimary),
            // ),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: textTheme.bodyLarge?.copyWith(color: onPrimary),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Image: ${widget.sourceImage}',
              style: textTheme.labelMedium?.copyWith(color: onPrimary),
            ),
            const SizedBox(
              height: 48,
            ),
            buttonRow(context)
          ],
        )));
  }

  Widget buttonRow(BuildContext context) {
    Widget w = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: onSubmit, child: const Text('Submit')),
          const SizedBox(
            width: 48,
          ),
          ElevatedButton(onPressed: onClose, child: const Text('Close')),
        ]);
    w = SizedBox(
      height: 48,
      child: w,
    );
    return w;
  }

  void onClose() {
    Navigator.pop(context);
  }

  void onSubmit() {
    setState(() {
      submitted = true;
    });
  }
}
