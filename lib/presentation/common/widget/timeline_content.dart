import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';

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
              child: Container(
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
            ),
            Expanded(
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
                              // fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                post.createdAt.toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white60),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.more_horiz,
                                  size: 24, color: Colors.white60),
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
            ),
          ],
        ),
        const Divider(height: 0),
      ],
    );
  }
}
