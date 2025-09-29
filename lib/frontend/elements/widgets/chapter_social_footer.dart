import 'package:flutter/material.dart';
import 'package:soyourhomeworld/backend/chapter.dart';
import 'package:soyourhomeworld/backend/server.dart';

import '../../../backend/utils.dart';
import '../../icons.dart';
import '../../parts/part.dart';

class ChapterSocialFooter extends StatefulWidget {
  const ChapterSocialFooter({super.key});

  @override
  State<ChapterSocialFooter> createState() => _ChapterSocialFooterState();
}

class _ChapterSocialFooterState extends State<ChapterSocialFooter> {
  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.zero,
    );
    Part part = ChapterProvider.partOf(context);
    return DecoratedSliver(
      key: const Key('SocialFooterDeco'),
      decoration: BoxDecoration(
        color: part.primary.s1,
        // border: Border.all(color: part.primary.s7)
      ),
      sliver: const SliverToBoxAdapter(
          key: Key('SocialStba'),
          child: SizedBox(
              height: 96,
              child: _SocialFooterWidget(
                key: Key('socialFooter'),
              ))),
    );
  }
}

class _SocialFooterWidget extends StatefulWidget {
  const _SocialFooterWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SocialFooterState();
}

List<String> fakeComments = [
  'I agree! Furthermore, I think all drones should be executed!',
  'Fuck you!',
  'S(e)(e)my(ti)ti(e)s b>i>t>l>y slash 2as93cbx8azb0da4abc2zasdf98',
  '',
  '🦐️🍫️🥷🏿️',
];

class _SocialFooterState extends State<_SocialFooterWidget> {
  late final Chapter? chapter;
  bool offeredEdit = false;
  bool editing = false;
  bool didDelete = false;
  late final TextEditingController controller;
  late List<String> comments;

  @override
  void initState() {
    comments = fakeComments.toList(growable: false);
    comments.shuffle(rNG);
    comments = comments.sublist(0, rNG.nextInt(comments.length));
    controller = TextEditingController(text: 'Wow!');
    //Select so you can delete it
    controller.selection = const TextSelection(baseOffset: 0, extentOffset: 4);
    // .expandTo(const TextPosition(offset: 5));
    super.initState();
    awaitEditPrivileges();
  }

  void awaitEditPrivileges() async {
    await Future.delayed(Duration(milliseconds: rNG.nextInt(500)));
    if (rNG.nextInt(5) > 1) {
      setState(() {
        offeredEdit = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    chapter = Chapter.maybeOf(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      //Widget shouldn't err out but shouldn't show anything
      return const SizedBox.shrink(
        key: Key('nullChapterSocialFooter'),
      );
    }
    Part part = ChapterProvider.partOf(context);

    List<Widget> children = [];

    late Widget editWidget;

    if (comments.isEmpty && didDelete) {
      editWidget = Icon(
        //Light accusation
        RpgAwesome.scythe,
        color: part.primary.s6,
      );
    } else if (!editing) {
      //TODO: Crossfade
      editWidget = IconButton(
          key: const Key("toggleEdit"),
          onPressed: startEditing,
          icon: Icon(
            comments.isEmpty
                ?
                //Needed to illustrate that this is for commenting
                RpgAwesome.speech_bubble
                :
                //Clashes with chip comment icons
                Icons.add,
            color: part.primary.sc,
          ));
    } else {
      editWidget = IconButton(
          key: const Key("toggleEdit"),
          onPressed: cancelEdit,
          icon: Icon(
            Icons.cancel_outlined,
            color: part.primary.sc,
          ));
    }
    if (!offeredEdit) {
      if (!editing) {
        //Present button as honeypot to bots
        int hideType = rNG.nextInt(2);
        //Change up how button is hidden
        switch (hideType) {
          case 0:
            editWidget = Offstage(
              key: const Key('M'),
              child: editWidget,
            );
          case 1:
          // editWidget =
          //     Opacity(key: const Key('F'), opacity: 0, child: editWidget);
//TODO: There are other methods
          case 2:
            editWidget = Visibility(
                key: const Key("P"),
                visible: false,
                //Pressable for your bot ass
                maintainInteractivity: true,
                maintainAnimation: true,
                //Otherwise user can press
                maintainSize: true,
                maintainState: true,
                child: editWidget);
        }
      } else {
        editWidget = IconButton(
            key: const Key("toggleEdit"),
            onPressed: cancelEdit,
            icon: Icon(
              RpgAwesome.bleeding_eye,
              color: part.primary.sa,
            ));
      }
    }
    children.add(editWidget);

    if (editing) {
      //TODO: Move to widget
      children.add(Expanded(
          child: Container(
              decoration: BoxDecoration(
                  //Same as chip
                  color: part.primary.s2,
                  border: Border.all(color: part.primary.s5),
                  borderRadius: const BorderRadius.all(Radius.circular(24))),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              height: 38,
              alignment: Alignment.center,
              child: EditableText(
                controller: controller,

                //TODO: Figure out what a focus node is because it's going to be important

                focusNode: FocusNode(
                  debugLabel: 'CommentInput',
                ),
                style: part.bodyFont.copyWith(color: part.primary.sc),
                cursorColor: part.primary.s7,
                backgroundCursorColor: part.primary.s5,
                keyboardAppearance: part.brightness,
              ))));
      children.add(IconButton(
          onPressed: submitComment,
          icon: Icon(
            Icons.send,
            color: part.primary.sa,
          )));
    } else {
      for (int cix = 0; cix < comments.length; ++cix) {
        //TODO: move to widget
        children.add(Padding(
            padding: const EdgeInsets.all(6),
            child: Chip(
              key: Key('comment$cix'),
              avatar: const Icon(RpgAwesome.speech_bubble),
              label: Text(
                comments[cix],
                maxLines: 2,
              ),
              //Body font (so you're a part of the book)
              //But with faded color (because you must read)
              labelStyle: part.bodyFont.copyWith(color: part.primary.sc),
              onDeleted: () => onDelete(cix),
              deleteButtonTooltipMessage: 'Mark spam',
              chipAnimationStyle: ChipAnimationStyle(

                  //This would tell the user to delete the next comment (hilarious)
                  deleteDrawerAnimation: AnimationStyle.noAnimation),
            )));
      }
    }

    late Widget widget;
    if (children.length == 1) {
      widget = children[0];
    } else {
      //
      // //Cover empty row
      // children.add(Icon(
      //   didDelete
      //       ?
      //   //Light accusation
      //   RpgAwesome.scythe
      //       :
      //   //Faultless user
      //   //Doesn't know why there's an icon here
      //   RpgAwesome.acid,
      //   color: part.primary.s6,
      // ));
      //TODO: Left-align when row is short
      widget = Row(
        key: const Key('commentChipRow'),
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: editing ? MainAxisSize.max : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );

      if (!editing) {
        widget = SingleChildScrollView(
            key: const Key('socialHorizScroll'),
            scrollDirection: Axis.horizontal,
            child: widget);
      }
    }

    widget = AnimatedSwitcher(
        key: const Key('socTypingSwitcher'),
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 150),
        // transitionBuilder: transitionBuilder,
        // layoutBuilder: layoutBuilder,
        child: widget);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6), child: widget);
  }

  Widget layoutBuilder(Widget? child, List<Widget> exiting) {
    // return Stack(
    //   alignment: Alignment.center,
    //   children: <Widget>[...exiting, if (child != null) child],
    // );
    return Column(
      key: const Key('switcherCol'),
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [...exiting, if (child != null) child],
    );
  }

  Widget transitionBuilder(Widget child, Animation<double> animation) {
    if (animation.status != AnimationStatus.reverse) {
      // return FadeTransition(opacity: animation, child: child);
      // return child;
      Animation<Offset> slide =
          Tween<Offset>(begin: const Offset(0, .5), end: const Offset(0, 0))
              .animate(animation);
      return SlideTransition(
          key: const Key('transSlide'), position: slide, child: child);
    } else {
      return FadeTransition(opacity: animation, child: child);

      Animation<Offset> slide =
          Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(animation);
      return SlideTransition(
          key: const Key('transRSlide'), position: slide, child: child);
      // return FadeTransition(opacity: animation, child: child);
    }
  }

  void startEditing() {
    if (mounted && !editing) {
      setState(() {
        editing = true;
      });
    }
  }

  void cancelEdit() {
    if (mounted && editing) {
      setState(() {
        editing = false;
      });
    }
  }

  void submitComment() async {
    String text = controller.value.text;
    comments.insert(0, text);
    await sendAndHandleErrors(
        'submit_comment', {'text': controller.value.text, 'uid': 69});
    controller.text = '[Sent]: $text';
    cancelEdit();
  }

  void onDelete(int ix) {
    comments.removeAt(ix);
    setState(() {});
    didDelete = true;
  }
}
