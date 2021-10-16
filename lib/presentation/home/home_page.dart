import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';
import 'package:swing_share/presentation/common/widget/timeline.dart';
import 'package:swing_share/presentation/entry/entry_page.dart';

class HomeState {
  HomeState(this.posts);
  final List<Post> posts;
}

const mockBody = 'JIG はソースコードで表現したドメインモデルを目に見えるようにするツール。\n\n'
    'モデルと実装を一致させるというドメイン駆動設計のアプローチを実践するために生まれた。\n'
    '私が現場でドメイン駆動設計を実践する時の必須ツール。';

final mockPosts = [
  Post(
    profile: Profile(
      name: '織田信長',
      thumbnailPath:
          'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png',
    ),
    body: mockBody,
    createdAt: DateTime.now(),
  ),
  Post(
    profile: Profile(
      name: '明智光秀',
      thumbnailPath:
          'https://knsoza1.com/wp-content/uploads/2020/07/7c820207265c90f9df0c2f0b91b2c4a8.png',
    ),
    body: mockBody,
    createdAt: DateTime.now(),
  ),
  Post(
    profile: Profile(
      name: '豊臣秀吉',
      thumbnailPath:
          'https://knsoza1.com/wp-content/uploads/2020/07/8d27ad3552fd86901f4976429ad22ce2.png',
    ),
    body: mockBody,
    createdAt: DateTime.now(),
  ),
  Post(
    profile: Profile(
      name: '徳川家康',
      thumbnailPath:
          'https://knsoza1.com/wp-content/uploads/2020/07/42ff381a6e93f93d64a6c03312a370a6.png',
    ),
    body: mockBody,
    createdAt: DateTime.now(),
  ),
];

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final state = HomeState(mockPosts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => const EntryPage(),
            ),
          ),
          child: const Text('Home'),
        ),
        toolbarHeight: 44,
      ),
      body: Timeline(posts: state.posts),
    );
  }
}
