import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';
import 'package:swing_share/domain/model/user_posts.dart';
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/model/post.dart' as data_model;
import 'package:swing_share/infra/model/profile.dart' as data_model;
import 'package:swing_share/infra/repository/repository_impl.dart';

final profileVm = Provider((ref) => ProfileViewModel(ref.read));

class ProfileViewModel {
  ProfileViewModel(this._read);
  final Reader _read;
  Repository get _repo => _read(repo);

  Stream<UserPosts> get userPosts {
    return Rx.combineLatest2(
      _repo.userStream(),
      _repo.userPostsStream(),
      (data_model.Profile profile, List<data_model.Post> posts) => UserPosts(
        profile: Profile(
          name: profile.name ?? '匿名',
          thumbnailPath: profile.thumbnailPath ??
              'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png',
        ),
        posts: posts
            .map((e) => Post(
                  profile: Profile(
                    name: profile.name ?? '匿名',
                    thumbnailPath: profile.thumbnailPath ??
                        'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png',
                  ),
                  body: e.body ?? '',
                  createdAt: e.createdAt,
                ))
            .toList(),
      ),
    );
  }
}
