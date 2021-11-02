import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/presentation/common/widget/timeline.dart';
import 'package:swing_share/presentation/login/login_view_model.dart';
import 'package:swing_share/presentation/profile/profile_view_model.dart';
import 'package:swing_share/presentation/video_player/flick_multi_manager.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      ref.read(profileVm.notifier).fetch();
      return null;
    }, []);

    final state = ref.watch(profileVm);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.profile?.name ?? '匿名'),
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
                  image: NetworkImage(
                      state.profile?.thumbnailPath ?? defaultPhotoUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
      ),
      body: Timeline(
        posts: state.posts,
        flickMultiManager: FlickMultiManager(),
      ),
    );
  }
}
