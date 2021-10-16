import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';

class Timeline extends StatelessWidget {
  const Timeline({
    Key? key,
    this.posts = const [],
  }) : super(key: key);

  final List<Post>? posts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...?posts?.map((e) => _buildContent(e)),
        ],
      ),
    );
  }

  Column _buildContent(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(post.profile, post.createdAt),
        _buildBody(post.body),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Divider(height: 0),
        ),
      ],
    );
  }

  Padding _buildBody(String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(body),
    );
  }

  Row _buildHeader(Profile profile, DateTime? createdAt) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(profile.thumbnailPath),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
          ),
        ),
        Text(profile.name),
        const Spacer(),
        Text(createdAt.toString()),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.more_horiz),
        ),
      ],
    );
  }
}
