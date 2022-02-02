import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/model/post.dart' as dataModel;
import 'package:swing_share/presentation/common/widget/last_indicator.dart';
import 'package:swing_share/presentation/common/widget/timeline_content.dart';
import 'package:swing_share/presentation/home/home_view_model.dart';
import 'package:swing_share/presentation/video_player/flick_multi_manager.dart';

final usersQuery = FirebaseFirestore.instance
    .collection('users')
    .doc('o9xTeiY3f6VOmll8sIeSpeZj05I3')
    .collection('posts')
    .orderBy('createdAt', descending: true);

final postsQuery = FirebaseFirestore.instance
    .collectionGroup('posts')
    .orderBy('createdAt', descending: true);

final postsTypeQuery = FirebaseFirestore.instance
    .collectionGroup('posts')
    .orderBy('createdAt', descending: true)
    .withConverter<Post>(
      fromFirestore: (snapshot, _) =>
          dataModel.Post.fromMap(snapshot.data()!, snapshot.id).toEntity(),
      toFirestore: (post, _) => {},
    );

class Timeline extends ConsumerWidget {
  const Timeline({
    Key? key,
    this.posts = const [],
    this.isHome = true,
    required this.flickMultiManager,
  }) : super(key: key);

  final List<Post> posts;
  final bool isHome;
  final FlickMultiManager flickMultiManager;

  @override
  Widget build(BuildContext context, ref) {
    final hasNext = ref.watch(homeVm).hasNext;

    return FirestoreListView<Post>(
      pageSize: 10,
      query: postsTypeQuery,
      itemBuilder: (context, snapshot) {
        final post = snapshot.data();

        return Container(
          color: Colors.transparent,
          child: TimelineContent(
            post,
            flickMultiManager: flickMultiManager,
          ),
        );
      },
    );

    return Scrollbar(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverSafeArea(
            sliver: CupertinoSliverRefreshControl(
              onRefresh: () async => ref.read(homeVm.notifier).refresh(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == posts.length && hasNext) {
                  return LastIndicator(() {
                    ref.read(homeVm.notifier).loadMore();
                  });
                }

                return GestureDetector(
                  onTap: () {
                    if (isHome) {
                      ref.read(homeVm.notifier).pushDetailPage(posts[index]);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: TimelineContent(
                      posts[index],
                      flickMultiManager: flickMultiManager,
                    ),
                  ),
                );
              },
              childCount: posts.length + (hasNext ? 1 : 0),
            ),
          ),
        ],
      ),
    );
  }
}
