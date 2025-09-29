import 'package:flutter/material.dart';

import 'image_holder.dart';

class ImageButtonRow extends StatefulWidget {
  final StdImageHolder holder;

  const ImageButtonRow({required super.key, required this.holder});

  @override
  State<StatefulWidget> createState() => _ImageButtonRowState();
}

class _ImageButtonRowState extends State<ImageButtonRow> {
  StdImageHolder get holder => widget.holder;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('imgButtonRow'),
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(
        //     padding: const EdgeInsets.all(12),
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.comment,
        //       color: holder.foreColor ?? const Color(0x2fffffff),
        //     )),
        Padding(
            key: const Key('namePad'),
            padding: const EdgeInsets.all(12),
            child: Tooltip(
                key: const Key('imgName'),
                message: holder.displayUrl,
                waitDuration: Duration.zero,
                // triggerMode: TooltipTriggerMode.tap,
                child: Icon(
                  key: const Key('nameIcon'),
                  Icons.short_text,
                  color: holder.foreColor ?? const Color(0x2fffffff),
                ))),
        Padding(
            key: const Key('creditPad'),
            padding: const EdgeInsets.all(12),
            child: Tooltip(
                key: const Key('creditTtp'),
                message: holder.credit,
                waitDuration: Duration.zero,
                // triggerMode: TooltipTriggerMode.tap,
                child: Icon(
                  key: const Key('creditIcon'),
                  Icons.person_pin_circle_outlined,
                  color: holder.foreColor ?? const Color(0x2fffffff),
                ))),
      ],
    );
  }
}
