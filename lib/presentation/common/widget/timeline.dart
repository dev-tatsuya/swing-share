import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/common/widget/timeline_content.dart';
import 'package:swing_share/presentation/home/home_view_model.dart';

class Timeline extends ConsumerWidget {
  const Timeline({
    Key? key,
    this.posts = const [],
    this.isHome = true,
  }) : super(key: key);

  final List<Post>? posts;
  final bool isHome;

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            ...?posts?.map(
              (e) => GestureDetector(
                onTap: () {
                  if (isHome) {
                    ref.read(homeVm).pushDetailPage(e);
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: TimelineContent(e),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
