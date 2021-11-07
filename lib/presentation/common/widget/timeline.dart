import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/common/widget/last_indicator.dart';
import 'package:swing_share/presentation/common/widget/timeline_content.dart';
import 'package:swing_share/presentation/home/home_view_model.dart';
import 'package:swing_share/presentation/video_player/flick_multi_manager.dart';

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
