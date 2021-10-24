import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/common/widget/custom_popup_menu.dart';
import 'package:swing_share/util/color.dart';

class CommentContentBody extends StatelessWidget {
  const CommentContentBody(
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    comment.profile.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        comment.createdAt.toString(),
                        style:
                            const TextStyle(fontSize: 14, color: AppColor.gray),
                      ),
                      if (!isWriting) const SizedBox(width: 4),
                      if (!isWriting) CustomPopupMenu(post, comment: comment),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(comment.body.replaceAll('\\n', '\n')),
            ),
          ],
        ),
      ),
    );
  }
}
