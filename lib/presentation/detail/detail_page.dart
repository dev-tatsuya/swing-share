import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this.post, {Key? key}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
        toolbarHeight: 44,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildBody(),
          _buildFooter(),
          const Divider(height: 0),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
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
        Text(
          post.profile.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.more_horiz, size: 24, color: Colors.white60),
        ),
      ],
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Text(
        post.body.replaceAll('\\n', '\n'),
        style: const TextStyle(fontSize: 16.4),
      ),
    );
  }

  Padding _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Text(
        post.createdAt.toString(),
        style: const TextStyle(fontSize: 14, color: Colors.white60),
      ),
    );
  }
}
