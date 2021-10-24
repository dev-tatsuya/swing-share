import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/presentation/comment/comment_list.dart';
import 'package:swing_share/presentation/common/widget/send_button.dart';
import 'package:swing_share/presentation/common/widget/timeline_content.dart';
import 'package:swing_share/util/color.dart';
import 'package:swing_share/util/string.dart';

class CommentEntryPage extends ConsumerStatefulWidget {
  const CommentEntryPage(
    this.post, {
    Key? key,
    this.comments = const [],
  }) : super(key: key);

  final Post post;
  final List<Comment>? comments;

  @override
  _CommentEntryPageState createState() => _CommentEntryPageState();
}

class _CommentEntryPageState extends ConsumerState<CommentEntryPage> {
  late TextEditingController _ctrl;
  String get _body => trimLastBlankLine(_ctrl.text);

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColor.dark!.withOpacity(0.8),
        elevation: 1,
        toolbarHeight: 44,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: SendButton(
                disabled: _body.isEmpty,
                onTap: () async {
                  await ref.read(repo).setComment(
                        _body,
                        widget.post.profile.id ?? '',
                        widget.post.id ?? '',
                        widget.post.incrementedCount,
                      );
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: SafeArea(
          child: Column(
            children: [
              TimelineContent(widget.post, isWriting: true),
              CommentList(widget.post,
                  comments: widget.comments, isWriting: true),
              TextField(
                style: const TextStyle(fontSize: 16.4),
                autofocus: true,
                cursorColor: Colors.blueGrey,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 20,
                controller: _ctrl,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
