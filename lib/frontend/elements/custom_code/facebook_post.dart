import 'package:flutter/material.dart';

// import 'package:soyourhomeworld/frontend/theme/base_text_theme.dart';

import '../../../backend/chapter.dart';
import '../../parts/noir_colors.dart';
import '../../parts/part.dart';
import '../../theme/base_text_theme.dart';
import '../holders/holder_base.dart';

class _Comment {
  final String user;
  final String? comment;
  final bool replying;
  const _Comment(
      {required this.user, required this.comment, this.replying = false});

  //  _Comment factory ({required String user, required String? comment}) {
  //   comment = comment?.trim();
  //   //Save current open comment
  // user = user.replaceAll('@', '');
  // user = user.replaceAll(':', '');
  // user = user.trim();
  //
  //   return _Comment.fromValues(user: user, comment: comment);
  // }

  const _Comment.blank()
      : user = '',
        comment = '',
        replying = false;
  String toText() {
    return '@$user:\n${comment ?? ''}';
  }
}

class FacebookHolder extends CodeHolder {
  ///Presumed to be in the Noir Part
  final _Comment post;
  final List<_Comment> comments;

  FacebookHolder.blank()
      : post = const _Comment.blank(),
        comments = const [
          _Comment.blank(),
          _Comment.blank(),
          _Comment.blank(),
        ];

  FacebookHolder._fromThings({required this.post, required this.comments});

  factory FacebookHolder(List<Holder> spans) {
    if (spans.isEmpty) {
      return FacebookHolder.blank();
    }

    List<_Comment> comments = [];

    String? user;
    String? currentString;
    bool replying = false;

    for (Holder span in spans) {
      String spanText = span.toText();
      if (spanText.trim().startsWith('@')) {
        if (user != null) {
          bool wasReplying = replying;
          replying = false;
          if (currentString?.contains('|') ?? false) {
            currentString = currentString!.replaceAll('|', '');
            replying = true;
          }
          currentString = currentString?.trim();
          //Save current open comment
          comments.add(_Comment(
              user: user, comment: currentString, replying: wasReplying));
        }
        user = spanText.replaceAll('@', '');
        user = user.replaceAll(':', '');
        user = user.trim();
        //In theory, user could be split over multiple spans
        //This would be unfixable
        currentString = null;
      } else {
        if (currentString == null) {
          currentString = spanText;
        } else {
          currentString += spanText;
        }
      }
    }
    if (user != null) {
      //Last comment can't have a reply under it
      currentString = currentString?.trim();
      comments.add(
          _Comment(user: user, comment: currentString, replying: replying));
    }

    if (comments.isEmpty) {
      return FacebookHolder.blank();
    }
    return FacebookHolder._fromThings(
        post: comments[0], comments: comments.sublist(1));
  }

  @override
  String toText() {
    return '${post.toText()}\n${comments.map((c) => c.toText()).join('\n\n')}';
  }

  @override
  Widget element(BuildContext context) {
    return FacebookElement(key: Key('FB_Post_$hashCode'), holder: this);
  }

  @override
  Widget fallback(BuildContext context) {
    return FacebookElement(key: Key('FB_Post_$hashCode'), holder: this);
  }

  @override
  bool get wantsPadding => false;
}

class _FBHilite extends WidgetStateProperty<Color> {
  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered)) {
      return NoirPrimary.shadec;
    }
    return NoirPrimary.shadef;
  }
}

ButtonStyle blankButton = ButtonStyle(
    padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 3, horizontal: 2)),
    foregroundColor: _FBHilite());

class FacebookElement extends StatelessWidget {
  final FacebookHolder holder;
  const FacebookElement({required super.key, required this.holder});

  void nullClick() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        key: const Key("FBPost"),
        width: 600,
        decoration: BoxDecoration(
            color: NoirPrimary.shade3,
            border: Border.all(color: NoirPrimary.shade5, width: 1)),
        margin: const EdgeInsets.only(bottom: 12, left: 6, right: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          key: const Key("primaryCol"),
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MainFBPost(key: const Key("Post"), post: holder.post),
            for (_Comment comment in holder.comments)
              _CommentWidget(
                  key: Key("fb_comment ${comment.hashCode}"), post: comment),
            //Spacer
            const SizedBox(height: 48),
          ],
        ));
  }
}

class _MainFBPost extends StatelessWidget {
  const _MainFBPost({
    super.key,
    required this.post,
  });

  final _Comment post;

  @override
  Widget build(BuildContext context) {
    TextStyle bodyFont = Part.of(context).bodyFont;

    return Padding(
        key: const Key("PostPad"),
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          key: const Key('PostCol'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainUsernameRow(
                key: const Key("mainUserName"), username: post.user),
            if (post.comment != null)
              Padding(
                  key: const Key("PostTextPad"),
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    key: const Key("PostText"),
                    post.comment ?? '',
                    style: bodyFont.copyWith(fontSize: 24 * fontScale),
                  )),
          ],
        ));
  }
}

class MainUsernameRow extends StatelessWidget {
  final String username;
  const MainUsernameRow({required super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    String? when = Chapter.maybeOf(context)?.data?.when;
    when ??= DateTime.now().toString();
    TextStyle bodyFont = Part.of(context).bodyFont;

    return SizedBox(
        key: const Key("UserNameSpace"),
        height: 60,
        child: Row(
          key: const Key("UsernameRow"),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                key: Key('userIconPad'),
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                child: Icon(
                    key: Key("UserIcon"),
                    Icons.circle,
                    size: 48,
                    color: NoirPrimary.shade1)),
            Column(
              key: const Key("UserTextCol"),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _FBUsername(
                    key: const Key("username"), name: username, isMain: true),
                Text(
                  key: const Key("Date"),
                  when,
                  style: bodyFont.copyWith(
                      fontSize: 8 * fontScale, color: NoirPrimary.shade7),
                )
              ],
            )
          ],
        ));
  }
}

class _CommentWidget extends StatelessWidget {
  const _CommentWidget({
    required super.key,
    required this.post,
  });
  final _Comment post;

  @override
  Widget build(BuildContext context) {
    TextStyle bodyFont = Part.of(context).bodyFont;

    bool realUser = post.user.isNotEmpty;
    Widget child = Row(
        key: const Key("CommentRow"),

        // decoration: BoxDecoration(
        //     border: Border(top: BorderSide(color: Primary.shaded, width: 1))),
        // padding: const EdgeInsets.only(top: 0, bottom: 6, left: 48, right: 12),
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              key: const Key("CommentPad"),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Icon(
                key: const Key("CommentIcon"),
                realUser ? Icons.circle : Icons.circle_outlined,
                size: 24 * fontScale,
                color: NoirPrimary.shade1,
              )),
          Expanded(
              child: Column(
            key: const Key("CommentTextCol"),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Divider(),
              _FBUsername(
                  key: const Key("username"), name: post.user, isMain: false),
              Text(
                key: const Key("commentText"),
                post.comment ?? '',
                style: bodyFont.copyWith(fontSize: 12 * fontScale),
              ),
            ],
          ))
        ]);

    if (post.replying) {
      child = Column(
        key: const Key("replyRow"),
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              key: Key("replySpacing"),

              //(Icon size (48) + Icon padding(12) )/2
              padding: EdgeInsets.only(left: -1 + 6 + 24),
              // alignment: Alignment(-.5, -1),
              child: ColoredBox(
                  key: Key("replyLineColor"),
                  color: NoirPrimary.shade5,
                  child: SizedBox(
                    key: Key("replyLineSize"),
                    width: 3,
                    height: 24,
                  ))),
          child
        ],
      );
      return child;
    } else {
      return Padding(
          key: const Key("CommentPad"),
          padding: const EdgeInsets.only(top: 24),
          child: child);
    }
  }
}

class _FBUsername extends StatelessWidget {
  final String name;
  final bool isMain;
  const _FBUsername({super.key, required this.name, required this.isMain});

  void nullClick() {}
  @override
  Widget build(BuildContext context) {
    TextStyle bodyFont = Part.of(context).bodyFont;
    //Only main comment should have colon
    String colon = isMain ? ':' : '';
    return TextButton(
        key: const Key("UsernameTextButton"),
        onPressed: nullClick,
        style: blankButton,
        child: Text(
          key: const Key("UsernameText"),
          '@$name$colon',
          style: bodyFont.copyWith(
              color: NoirPrimary.shadea, decoration: TextDecoration.underline),
          textAlign: TextAlign.start,
        ));
  }
}
