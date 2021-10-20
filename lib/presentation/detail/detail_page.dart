import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this.post, {Key? key}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('詳細')),
      body: const Center(child: Text('詳細ページ')),
    );
  }
}
