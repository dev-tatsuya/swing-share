import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/comment/comment_content_body.dart';

class CommentListContent extends StatelessWidget {
  const CommentListContent(
    this.post,
    this.comment, {
    Key? key,
    this.isWriting = false,
  }) : super(key: key);

  final Post post;
  final Comment comment;
  final bool isWriting;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(comment.profile.thumbnailPath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                ),
              ),
              // todo: add vertical line
            ],
          ),
        ),
        CommentContentBody(post, comment, isWriting: isWriting),
      ],
    );
  }
}
