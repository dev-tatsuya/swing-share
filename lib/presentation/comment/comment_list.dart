import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/comment/comment_list_content.dart';

class CommentList extends ConsumerWidget {
  const CommentList({
    Key? key,
    this.posts = const [],
  }) : super(key: key);

  final List<Post>? posts;

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...?posts?.map(
            (e) => Container(
              color: Colors.transparent,
              child: CommentListContent(e),
            ),
          ),
        ],
      ),
    );
  }
}
