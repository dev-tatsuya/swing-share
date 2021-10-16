import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';
import 'package:swing_share/domain/model/user_posts.dart';
import 'package:swing_share/presentation/common/widget/timeline.dart';
import 'package:swing_share/presentation/home/home_page.dart';
import 'package:swing_share/presentation/login/login_view_model.dart';
import 'package:swing_share/presentation/profile/profile_view_model.dart';

class ProfileState {
  ProfileState({
    required this.profile,
    this.posts = const [],
  });
  final Profile profile;
  final List<Post> posts;
}

final mockProfile = Profile(
  name: '織田信長',
  thumbnailPath:
      'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png',
);

class ProfilePage extends ConsumerWidget {
  ProfilePage({Key? key}) : super(key: key);

  final state = ProfileState(
    profile: mockProfile,
    posts: mockPosts,
  );

  @override
  Widget build(BuildContext context, ref) {
    return StreamBuilder<UserPosts>(
        stream: ref.watch(profileVm).userPosts,
        builder: (context, snapshot) {
          final data = snapshot.data;
          log('data: $data');

          return Scaffold(
            appBar: AppBar(
              title: Text(data?.profile.name ?? '匿名'),
              toolbarHeight: 44,
              leading: GestureDetector(
                onTap: () => ref.read(loginVm).logout(),
                child: const Icon(Icons.logout),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data?.profile.thumbnailPath ??
                            'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
            body: Timeline(posts: data?.posts),
          );
        });
  }
}
