import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/common/widget/timeline.dart';
import 'package:swing_share/presentation/entry/entry_page.dart';
import 'package:swing_share/presentation/home/home_view_model.dart';
import 'package:swing_share/presentation/video_player/flick_multi_manager.dart';
import 'package:swing_share/util/color.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
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
      body: StreamBuilder<List<Post>>(
        stream: ref.watch(homeVm).postStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
          }

          return VisibilityDetector(
            key: ObjectKey(flickMultiManager),
            onVisibilityChanged: (visibility) {
              if (visibility.visibleFraction == 0 && mounted) {
                flickMultiManager.pause();
              }
            },
            child: Timeline(
              flickMultiManager: flickMultiManager,
              posts: snapshot.data ?? [],
            ),
          );
        },
      ),
    );
  }
}
