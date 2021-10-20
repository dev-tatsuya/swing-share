import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/presentation/common/widget/timeline.dart';
import 'package:swing_share/presentation/entry/entry_page.dart';

class HomeState {
  HomeState(this.posts);
  final List<Post> posts;
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
      body: StreamBuilder<List<Post>>(
          stream: ref.watch(repo).allPostsStream(),
          builder: (context, snapshot) {
            return Timeline(posts: snapshot.data);
          }),
    );
  }
}
