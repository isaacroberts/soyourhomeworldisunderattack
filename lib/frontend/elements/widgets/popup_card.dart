import 'package:flutter/material.dart';

void pushPopupCard(
  BuildContext context, {
  required Widget Function(BuildContext) builder,
  required String label,
}) {
  Navigator.push(
      context,
      ModalBottomSheetRoute(
          builder: builder,
          backgroundColor: Theme.of(context).colorScheme.scrim.withAlpha(128),
          barrierLabel: label,
          isDismissible: true,
          useSafeArea: true,
          isScrollControlled: true));
}

class PopupCardContainer extends StatelessWidget {
  final Color background;
  final Widget? child;
  const PopupCardContainer(
      {required super.key, required this.background, this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 6, right: 6),
            child: Material(
                type: MaterialType.card,
                color: background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 48, horizontal: 24),
                    child: child))));
  }
}
