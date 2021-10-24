import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/common/widget/timeline_content_body.dart';
import 'package:swing_share/util/color.dart';

class TimelineContent extends StatelessWidget {
  const TimelineContent(
    this.post, {
    Key? key,
    this.isWriting = false,
  }) : super(key: key);

  final Post post;
  final bool isWriting;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, right: 8, bottom: 12),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(post.profile.thumbnailPath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                  ),
                  if (post.commentCount != 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.reply,
                            color: AppColor.gray,
                            size: 20,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            post.commentCount.toString(),
                            style: const TextStyle(color: AppColor.gray),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
            TimelineContentBody(post, isWriting: isWriting),
          ],
        ),
        const Divider(height: 0),
      ],
    );
  }
}
