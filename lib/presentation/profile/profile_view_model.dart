import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';
import 'package:swing_share/domain/model/user_posts.dart';
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/model/post.dart' as data_model;
import 'package:swing_share/infra/model/profile.dart' as data_model;
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/presentation/login/login_view_model.dart';

final profileVm = Provider.autoDispose((ref) => ProfileViewModel(ref.read));

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
          name: profile.name ?? defaultName,
          thumbnailPath: profile.thumbnailPath ?? defaultPhotoUrl,
        ),
        posts: posts
            .map((e) => Post(
                  id: e.id,
                  profile: Profile(
                    name: e.author?['name'] ?? defaultName,
                    thumbnailPath:
                        e.author?['thumbnailPath'] ?? defaultPhotoUrl,
                  ),
                  body: e.body ?? '',
                  createdAt: e.createdAt,
                ))
            .toList(),
      ),
    );
  }
}
