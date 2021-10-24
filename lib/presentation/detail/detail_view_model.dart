import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';

final detailVm = Provider.autoDispose((ref) => DetailViewModel(ref.read));

class DetailViewModel {
  DetailViewModel(this._read);
  final Reader _read;

  Stream<List<Comment>> commentsStream(String profileId, String postId) {
    return _read(repo).postCommentsStream(profileId, postId);
  }
}
