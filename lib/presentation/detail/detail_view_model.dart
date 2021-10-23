import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';

final detailVm = Provider.autoDispose((ref) => DetailViewModel(ref.read));

class DetailViewModel {
  DetailViewModel(this._read);
  final Reader _read;

  Stream<List<Post>> commentsStream(String profileId, String postId) {
    return _read(repo).postCommentsStream(profileId, postId).map(
          (event) => event.map((e) => e.toEntity()).toList(),
        );
  }
}
