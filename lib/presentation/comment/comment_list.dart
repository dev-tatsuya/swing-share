import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/comment/comment_list_content.dart';

class CommentList extends ConsumerWidget {
  const CommentList(
    this.post, {
    Key? key,
    this.comments = const [],
    this.isWriting = false,
  }) : super(key: key);

  final Post post;
  final List<Comment>? comments;
  final bool isWriting;

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...?comments?.map(
            (e) => Container(
              color: Colors.transparent,
              child: CommentListContent(post, e, isWriting: isWriting),
            ),
          ),
        ],
      ),
    );
  }
}
