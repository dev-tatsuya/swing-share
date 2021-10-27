import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/model/post.dart' as model;
import 'package:swing_share/presentation/common/widget/timeline.dart';
import 'package:swing_share/presentation/entry/entry_page.dart';
import 'package:swing_share/presentation/home/home_view_model.dart';
import 'package:swing_share/util/color.dart';

class HomeState {
  HomeState(this.posts);
  final List<Post> posts;
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(homeVm).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColor.dark!.withOpacity(0.9),
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
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: ref.watch(homeVm).postsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
          }

          final posts = snapshot.data
              ?.map((e) => model.Post.fromMap(
                    e.data() as Map<String, dynamic>,
                    e.id,
                  ).toEntity())
              .toList();

          return Timeline(posts: posts ?? []);
        },
      ),
    );
  }
}
