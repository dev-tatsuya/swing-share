import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/presentation/profile/state/profile_state.dart';

final profileVm =
    StateNotifierProvider.autoDispose<ProfileViewModel, ProfileState>(
        (ref) => ProfileViewModel(ref.read));

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this._read) : super(const ProfileState());
  final Reader _read;
  Repository get _repo => _read(repo);

  Future<void> fetch({bool loadMore = false}) async {
    final profile = await _repo.profile();
    final items = await _repo.myPosts(
        lastPostDateTime: loadMore ? state.posts.last.createdAt : null);
    state = state.copyWith(
      profile: profile,
      posts: [if (loadMore) ...state.posts, ...items],
      hasNext: items.length >= 10,
    );
  }
}
