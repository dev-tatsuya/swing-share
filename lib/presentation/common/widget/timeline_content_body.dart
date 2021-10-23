import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/util/color.dart';

class TimelineContentBody extends StatelessWidget {
  const TimelineContentBody(this.post, {Key? key}) : super(key: key);

  final Post post;

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
                    post.profile.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        post.createdAt.toString(),
                        style:
                            const TextStyle(fontSize: 14, color: AppColor.gray),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.more_horiz,
                          size: 24, color: AppColor.gray),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(post.body.replaceAll('\\n', '\n')),
            ),
          ],
        ),
      ),
    );
  }
}
