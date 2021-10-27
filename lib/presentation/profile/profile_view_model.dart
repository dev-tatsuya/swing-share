import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swing_share/domain/model/user_posts.dart';
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/model/post.dart' as model;
import 'package:swing_share/infra/model/profile.dart' as model;
import 'package:swing_share/infra/repository/repository_impl.dart';

final profileVm = Provider.autoDispose((ref) => ProfileViewModel(ref.read));

class ProfileViewModel {
  ProfileViewModel(this._read);
  final Reader _read;
  Repository get _repo => _read(repo);

  Stream<UserPosts> get userPosts {
    return Rx.combineLatest2(
      _repo.userStream(),
      _repo.userPostsStream(),
      (model.Profile profile, List<model.Post> posts) => UserPosts(
        profile: profile.toEntity(),
        posts: posts.map((e) => e.toEntity()).toList(),
      ),
    );
  }
}
