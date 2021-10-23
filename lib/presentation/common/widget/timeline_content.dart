import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/common/widget/timeline_content_body.dart';
import 'package:swing_share/util/color.dart';

class TimelineContent extends StatelessWidget {
  const TimelineContent(this.post, {Key? key}) : super(key: key);

  final Post post;

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
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.reply,
                        color: AppColor.gray,
                        size: 20,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '99+',
                        style: TextStyle(color: AppColor.gray),
                      ),
                    ],
                  )
                ],
              ),
            ),
            TimelineContentBody(post),
          ],
        ),
        const Divider(height: 0),
      ],
    );
  }
}
